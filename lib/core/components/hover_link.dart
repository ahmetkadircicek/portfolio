import 'package:flutter/material.dart';
import 'package:portfolio/core/components/web_link.dart';
import 'package:portfolio/core/components/pressable.dart';
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

/// Text link with an underline that draws in on hover or keyboard focus and
/// an arrow that nudges in its direction.
class HoverLink extends StatelessWidget {
  final String label;

  /// Where the link goes: a path in the site (`/contact`) or a full URL. With
  /// it the link is a real browser link; without it, [onTap] runs.
  final String? to;
  final VoidCallback? onTap;
  final LinkIcon icon;
  final TextStyle? style;
  final Color? color;

  const HoverLink({
    super.key,
    required this.label,
    this.to,
    this.onTap,
    this.icon = LinkIcon.none,
    this.style,
    this.color,
  });

  Offset get _nudge => switch (icon) {
        LinkIcon.forward => const Offset(3, 0),
        LinkIcon.back => const Offset(-3, 0),
        LinkIcon.external => const Offset(2, -2),
        LinkIcon.down => const Offset(0, 3),
        LinkIcon.up => const Offset(0, -3),
        LinkIcon.none => Offset.zero,
      };

  @override
  Widget build(BuildContext context) {
    final to = this.to;
    if (to == null) return _build(context, onTap);
    return WebLink(to: to, builder: _build);
  }

  Widget _build(BuildContext context, VoidCallback? onTap) {
    final color = this.color ?? context.colors.ink;
    final style = (this.style ?? context.text.link).copyWith(color: color);
    return Semantics(
      link: true,
      child: Pressable(
        onPressed: onTap,
        ringColor: color,
        radius: AppRadius.smAll,
        builder: (context, active) => _link(context, style, color, active),
      ),
    );
  }

  Widget _link(BuildContext context, TextStyle style, Color color, bool active) {
    final iconData = icon.data;
    final iconWidget = iconData == null
        ? null
        : AnimatedSlide(
            offset: active ? _nudge / 16 : Offset.zero,
            duration: AppMotion.base,
            curve: AppMotion.standard,
            child: Icon(iconData, size: (style.fontSize ?? 16) * 0.95, color: color),
          );

    // The link is as tall as its text, so it lines up with whatever sits
    // beside it; the underline hangs below without taking space.
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpace.x2,
          children: [
            if (icon == LinkIcon.back) iconWidget!,
            Flexible(child: Text(label, style: style)),
            if (iconWidget != null && icon != LinkIcon.back) iconWidget,
          ],
        ),
        // The underline grows from the left on hover or focus.
        Positioned(
          left: icon == LinkIcon.back ? (style.fontSize ?? 16) * 0.95 + AppSpace.x2 : 0,
          bottom: -AppSpace.x1,
          child: AnimatedContainer(
            duration: AppMotion.base,
            curve: AppMotion.standard,
            height: 1,
            width: active ? _textWidth(style) : 0,
            color: color,
          ),
        ),
      ],
    );
  }

  double _textWidth(TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: label, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return painter.width;
  }
}
