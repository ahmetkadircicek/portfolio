import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: context.pageMargin,
        decoration: BoxDecoration(
          color: context.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                '404',
                style: GoogleFonts.cardo(fontSize: 96, fontWeight: FontWeight.w900, letterSpacing: 14),
              ),
            ),
            Text(
              'This page does not exist.',
              style: GoogleFonts.montserrat(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            HoverDetector(
              child: GestureDetector(
                onTap: () => context.go('/home'),
                child: Text(
                  'Back to home',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.onPrimary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
