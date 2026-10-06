import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/constants/padding_constants.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';

class ContactsNavigationBarWidget extends StatelessWidget {
  const ContactsNavigationBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingConstants.allMedium,
      margin: PaddingConstants.allLarge + PaddingConstants.symmetricHorizontalLarge,
      decoration: BoxDecoration(
        color: context.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Contact Me',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: context.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
