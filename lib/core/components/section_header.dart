import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Small upper-case label above content, e.g. `PROJECTS`.
class Eyebrow extends StatelessWidget {
  final String text;
  final Color? color;

  const Eyebrow(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: context.text.label.copyWith(color: color ?? context.colors.inkSubtle));
  }
}

/// Section title in the display serif with a count or index beside it,
/// over a hairline.
class SectionHeader extends StatelessWidget {
  final String title;

  /// Shown in parentheses after the title, e.g. `06`.
  final String? count;
  final String? description;

  /// Shown at the end of the title line, e.g. an open/close control.
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.count, this.description, this.trailing});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _withTrailing(Text.rich(
          TextSpan(
            text: title.toUpperCase(),
            children: [
              if (count != null)
                // Small and on the title's baseline, right after it.
                TextSpan(text: '  ($count)', style: text.label.copyWith(color: context.colors.inkSubtle)),
            ],
          ),
          style: text.h1,
        )),
        if (description != null) ...[
          const SizedBox(height: AppSpace.x4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(description!, style: text.bodyLarge.copyWith(color: context.colors.inkMuted)),
          ),
        ],
        SizedBox(height: context.isMobile ? AppSpace.x4 : AppSpace.x6),
        Divider(height: 1, thickness: 1, color: context.colors.line),
      ],
    );
  }

  Widget _withTrailing(Widget title) {
    if (trailing == null) return title;
    return Row(children: [Expanded(child: title), trailing!]);
  }
}
