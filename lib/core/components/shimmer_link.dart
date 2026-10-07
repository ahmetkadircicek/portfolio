import 'package:flutter/material.dart';
import 'package:portfolio/core/components/hover_link.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:shimmer/shimmer.dart';

/// [HoverLink] with a gold shimmer running across it, for the one link on a
/// screen that should catch the eye.
class ShimmerLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final LinkIcon icon;

  const ShimmerLink({super.key, required this.label, required this.onTap, this.icon = LinkIcon.none});

  @override
  Widget build(BuildContext context) {
    final link = HoverLink(label: label, onTap: onTap, icon: icon);
    if (MediaQuery.disableAnimationsOf(context)) return link;
    // The shimmer animates forever; keep its repaints to itself.
    return RepaintBoundary(
      child: Shimmer.fromColors(
        baseColor: AppColors.ink,
        highlightColor: AppColors.accent,
        period: const Duration(milliseconds: 2400),
        child: link,
      ),
    );
  }
}
