import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/components/home_link_widget.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/constants/padding_constants.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';

class ProjectsNavigationBarWidget extends StatelessWidget {
  final List<String> titles;
  final int currentPage;
  final ValueChanged<int> onPageSelected;

  const ProjectsNavigationBarWidget({
    super.key,
    required this.titles,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = [
      for (var i = 0; i < titles.length; i++) _buildNavButton(context, titles[i], i),
    ];

    return Container(
      padding: PaddingConstants.allMedium,
      margin: context.pageMargin,
      decoration: BoxDecoration(
        color: context.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      // Phones cannot fit six titles in a row, so they scroll sideways under
      // the page title instead.
      child: context.isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                const HomeLinkWidget(title: 'Projects'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(spacing: 16, children: buttons),
                ),
              ],
            )
          : Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const HomeLinkWidget(title: 'Projects'),
                const Spacer(),
                ...buttons,
              ],
            ),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, int page) {
    final isSelected = currentPage == page;

    return HoverDetector(
      child: GestureDetector(
        onTap: () => onPageSelected(page),
        child: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: context.onPrimary.withValues(alpha: isSelected ? 1 : 0.5),
          ),
        ),
      ),
    );
  }
}
