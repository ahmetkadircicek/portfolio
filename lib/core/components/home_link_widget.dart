import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';

/// Page title in the navigation bars that also leads back to the home page.
class HomeLinkWidget extends StatelessWidget {
  final String title;

  const HomeLinkWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return HoverDetector(
      child: GestureDetector(
        onTap: () => context.go('/home'),
        child: Semantics(
          link: true,
          label: 'Back to home',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Icon(Icons.arrow_back_ios_new, size: 12, color: context.onPrimary.withValues(alpha: 0.6)),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: context.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
