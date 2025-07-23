import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruspt/utils/snackbar_util.dart';

class CreatePostDialog extends StatefulWidget {
  const CreatePostDialog({super.key});

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  int? _selectedUserId;
  bool _isSubmitting = false;

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate() || _selectedUserId == null) return;

    setState(() => _isSubmitting = true);

    final response = await GetConnect()
        .post('https://jsonplaceholder.typicode.com/posts/', {
          'title': _titleController.text,
          'body': _bodyController.text,
          'userId': _selectedUserId,
        });

    setState(() => _isSubmitting = false);

    if (response.statusCode == 201) {
      Get.back();
      showSnackbar(
        title: 'Éxito',
        message: 'El post fue creado correctamente',
        type: SnackbarType.success,
      );
    } else {
      showSnackbar(
        title: 'Error',
        message: 'No se pudo crear el post',
        type: SnackbarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📝 Crear nuevo post',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildField(
                      controller: _titleController,
                      label: 'Título',
                      validatorMessage: 'El título es requerido',
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: _bodyController,
                      label: 'Cuerpo',
                      maxLines: 3,
                      validatorMessage: 'El cuerpo es requerido',
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      value: _selectedUserId,
                      decoration: InputDecoration(
                        labelText: 'ID del usuario',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: Colors.grey.shade800,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      items: [1, 2, 3, 4, 5]
                          .map(
                            (id) => DropdownMenuItem(
                              value: id,
                              child: Text('Usuario $id'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        _selectedUserId = value;
                      }),
                      validator: (value) =>
                          value == null ? 'Selecciona un usuario' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSubmitting ? null : () => Get.back(),
                    child: Text(
                      'Cancelar',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitPost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade600,
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Crear',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? validatorMessage,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.montserrat(fontSize: 14),
      decoration: _inputDecoration(label),
      validator: (value) =>
          value == null || value.trim().isEmpty ? validatorMessage : null,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      labelStyle: GoogleFonts.montserrat(fontSize: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
