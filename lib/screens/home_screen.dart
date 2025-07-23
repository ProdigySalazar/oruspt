import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruspt/controllers/home_controller.dart';
import 'package:oruspt/widgets/MyTextField.dart';
import 'package:oruspt/widgets/MyTable.dart';
import 'package:oruspt/widgets/modals/CreatePostDialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          '📚 Biblioteca App',
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.3,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),

      body: Container(
        color: Colors.grey.shade50,
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final totalPages =
              (controller.filteredPosts.length / controller.rowsPerPage.value)
                  .ceil();

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Mytextfield(
                      label: 'Buscar por título o cuerpo',
                      icon: Icons.search,
                      onChanged: (value) {
                        controller.searchTerm.value = value;
                        controller.applyFilter();
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  SizedBox(
                    width: 120,
                    child: DropdownButtonFormField<int>(
                      isDense: true,
                      menuMaxHeight: 200,
                      value: controller.rowsPerPage.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.rowsPerPage.value = value;
                          controller.currentPage.value = 0;
                          controller.applyFilter();
                        }
                      },

                      decoration: InputDecoration(
                        labelText: 'Filas',
                        labelStyle: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: Colors.grey.shade800,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: Colors.white,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      items: const [
                        DropdownMenuItem(value: 10, child: Text('10')),
                        DropdownMenuItem(value: 20, child: Text('20')),
                        DropdownMenuItem(value: 50, child: Text('50')),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  // Icono decorativo inclinado al fondo
                  Positioned(
                    right: -10,
                    bottom: -10,
                    child: Opacity(
                      opacity: 0.06,
                      child: Transform.rotate(
                        angle: -0.5, // en radianes (~-28.6°)
                        child: Icon(
                          Icons.auto_stories_rounded,
                          size: 160,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),

                  // Botón principal
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: Get.context!,
                            builder: (_) => const CreatePostDialog(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          minimumSize: const Size(0, 38),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.add, size: 18),
                        label: Text(
                          'Nuevo',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.filteredPosts.isEmpty
                    ? const Center(child: Text('No hay datos disponibles.'))
                    : const Mytable(),
              ),

              if (!controller.isLoading.value &&
                  controller.filteredPosts.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Página ${controller.currentPage.value + 1} de $totalPages '
                        '(${controller.filteredPosts.length} registros)',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              tooltip: 'Página anterior',
                              onPressed: controller.currentPage.value > 0
                                  ? () => controller.currentPage.value--
                                  : null,
                              color: controller.currentPage.value > 0
                                  ? Colors.indigo
                                  : Colors.grey.shade400,
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              tooltip: 'Página siguiente',
                              onPressed:
                                  (controller.currentPage.value + 1) <
                                      totalPages
                                  ? () => controller.currentPage.value++
                                  : null,
                              color:
                                  (controller.currentPage.value + 1) <
                                      totalPages
                                  ? Colors.indigo
                                  : Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
