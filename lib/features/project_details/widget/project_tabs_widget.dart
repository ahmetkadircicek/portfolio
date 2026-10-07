import 'package:flutter/material.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Segmented control with one tab per project.
class ProjectTabs extends StatelessWidget {
  final int currentPage;
  final ValueChanged<int> onPageSelected;

  const ProjectTabs({super.key, required this.currentPage, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    final tabs = Container(
      padding: const EdgeInsets.all(AppSpace.x1),
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: AppRadius.pillAll),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < Projects.all.length; i++)
            _Tab(label: Projects.all[i].name, selected: i == currentPage, onTap: () => onPageSelected(i)),
        ],
      ),
    );
    // Phones and narrow tablets scroll the tabs sideways.
    return Align(
      alignment: context.isMobile ? Alignment.centerLeft : Alignment.centerRight,
      child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: tabs),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Tab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: HoverDetector(
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.base,
            curve: AppMotion.standard,
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.x4, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.ink : AppColors.surface,
              borderRadius: AppRadius.pillAll,
            ),
            child: Text(
              label,
              style: context.text.bodySmall.copyWith(
                height: 1.2,
                fontWeight: FontWeight.w500,
                color: selected ? AppColors.onInk : AppColors.inkMuted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
