import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mytextfield extends StatelessWidget {
  final String label;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? hintText;

  const Mytextfield({
    super.key,
    required this.label,
    required this.icon,
    this.onChanged,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.montserrat(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 13,
          color: Colors.grey.shade800,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 13,
          color: Colors.grey.shade500,
        ),
        prefixIcon: Icon(icon, color: Colors.grey.shade700),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
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
    );
  }
}
