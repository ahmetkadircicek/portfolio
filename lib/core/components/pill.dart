import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

enum PillStyle {
  /// Neutral surface, e.g. technologies.
  neutral,

  /// White on images, e.g. feature card labels.
  onImage,

  /// Tinted with a color and led by a dot, e.g. project status.
  status,
}

class Pill extends StatelessWidget {
  final String label;
  final PillStyle style;
  final Color? color;

  const Pill(this.label, {super.key, this.style = PillStyle.neutral, this.color});

  const Pill.status(this.label, {super.key, required Color this.color}) : style = PillStyle.status;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? AppColors.ink;
    final (background, foreground) = switch (style) {
      PillStyle.neutral => (AppColors.surface, AppColors.ink),
      PillStyle.onImage => (AppColors.canvas, AppColors.ink),
      PillStyle.status => (tint.withValues(alpha: 0.1), tint),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.x3, vertical: 6),
      decoration: BoxDecoration(color: background, borderRadius: AppRadius.pillAll),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpace.x2,
        children: [
          if (style == PillStyle.status)
            Container(width: 6, height: 6, decoration: BoxDecoration(color: tint, shape: BoxShape.circle)),
          Text(label, style: context.text.bodySmall.copyWith(fontSize: 13, height: 1.2, color: foreground)),
        ],
      ),
    );
  }
}
