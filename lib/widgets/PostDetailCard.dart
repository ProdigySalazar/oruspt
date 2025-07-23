import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetailCard extends StatelessWidget {
  final String title;
  final String body;

  const PostDetailCard({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
            width: 60,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            body,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              height: 1.6,
              color: Colors.grey.shade800,
            ),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '📘 Fin del capítulo',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
