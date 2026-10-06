import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/constants/padding_constants.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';

class ProjectsNavigationBarWidget extends StatelessWidget {
  final int currentPage;
  final Function(int) onPageSelected;

  const ProjectsNavigationBarWidget({
    super.key,
    required this.currentPage,
    required this.onPageSelected,
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
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Projects',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: context.onPrimary,
            ),
          ),
          const Spacer(),
          _buildNavButton(context, 'Tunes', 0),
          _buildNavButton(context, 'Vilsa', 1),
          _buildNavButton(context, 'Sevkiyatvar', 2),
          _buildNavButton(context, 'Travelai', 3),
          _buildNavButton(context, 'Visiostellar', 4),
          _buildNavButton(context, 'Peasy', 5),
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
