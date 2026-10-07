import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Small upper-case label above content, e.g. `SELECTED WORK`.
class Eyebrow extends StatelessWidget {
  final String text;
  final Color color;

  const Eyebrow(this.text, {super.key, this.color = AppColors.inkSubtle});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: context.text.label.copyWith(color: color));
  }
}

/// Section title in the display serif with a count or index beside it,
/// over a hairline.
class SectionHeader extends StatelessWidget {
  final String title;

  /// Shown in parentheses after the title, e.g. `06`.
  final String? count;
  final String? description;

  const SectionHeader({super.key, required this.title, this.count, this.description});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title.toUpperCase(),
            children: [
              if (count != null)
                WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSpace.x2),
                    child: Text('($count)', style: text.label.copyWith(color: AppColors.inkSubtle)),
                  ),
                ),
            ],
          ),
          style: text.h1,
        ),
        if (description != null) ...[
          const SizedBox(height: AppSpace.x4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(description!, style: text.bodyLarge.copyWith(color: AppColors.inkMuted)),
          ),
        ],
        SizedBox(height: context.isMobile ? AppSpace.x6 : AppSpace.x8),
        const Divider(height: 1, thickness: 1, color: AppColors.line),
      ],
    );
  }
}
