import 'package:flutter/material.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

enum LinkIcon {
  none(null),
  forward(Icons.arrow_forward),
  back(Icons.arrow_back),
  external(Icons.north_east),
  down(Icons.south),
  up(Icons.north);

  final IconData? data;
  const LinkIcon(this.data);
}

/// Text link with an underline that draws in on hover and an arrow that
/// nudges in its direction.
class HoverLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final LinkIcon icon;
  final TextStyle? style;
  final Color? color;

  const HoverLink({
    super.key,
    required this.label,
    required this.onTap,
    this.icon = LinkIcon.none,
    this.style,
    this.color,
  });

  @override
  State<HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<HoverLink> {
  bool _hovering = false;

  Offset get _nudge => switch (widget.icon) {
        LinkIcon.forward => const Offset(3, 0),
        LinkIcon.back => const Offset(-3, 0),
        LinkIcon.external => const Offset(2, -2),
        LinkIcon.down => const Offset(0, 3),
        LinkIcon.up => const Offset(0, -3),
        LinkIcon.none => Offset.zero,
      };

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.ink;
    final style = (widget.style ?? context.text.link).copyWith(color: color);
    final iconData = widget.icon.data;
    final iconWidget = iconData == null
        ? null
        : AnimatedSlide(
            offset: _hovering ? _nudge / 16 : Offset.zero,
            duration: AppMotion.base,
            curve: AppMotion.standard,
            child: Icon(iconData, size: (style.fontSize ?? 16) * 0.95, color: color),
          );

    return Semantics(
      link: true,
      child: HoverDetector(
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: widget.onTap,
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpace.x2,
                  children: [
                    if (widget.icon == LinkIcon.back) iconWidget!,
                    Flexible(child: Text(widget.label, style: style)),
                    if (iconWidget != null && widget.icon != LinkIcon.back) iconWidget,
                  ],
                ),
                const SizedBox(height: AppSpace.x1),
                // The underline grows from the left on hover.
                AnimatedContainer(
                  duration: AppMotion.base,
                  curve: AppMotion.standard,
                  height: 1,
                  width: _hovering ? _textWidth(style) : 0,
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _textWidth(TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: widget.label, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return painter.width;
  }
}
