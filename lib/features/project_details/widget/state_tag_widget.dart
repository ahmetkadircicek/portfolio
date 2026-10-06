import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';

class StateTagWidget extends StatelessWidget {
  final String label;
  final Color? color;

  const StateTagWidget({
    super.key,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.2) ?? context.secondary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: color ?? context.onPrimary,
        ),
      ),
    );
  }
}
