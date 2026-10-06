import 'package:flutter/material.dart';
import 'package:portfolio/core/components/home_link_widget.dart';
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
      margin: context.pageMargin,
      decoration: BoxDecoration(
        color: context.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HomeLinkWidget(title: 'Contact Me'),
        ],
      ),
    );
  }
}
