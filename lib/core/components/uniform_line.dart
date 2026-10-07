import 'dart:math' as math;

import 'package:flutter/material.dart';

/// One line of text that belongs to a set, e.g. every entry title. All
/// lines of the set get one size: [style] if the longest of [all] fits the
/// width, otherwise the size at which that longest one fits. A line is never
/// shrunk on its own, so titles in a list always match.
class UniformLine extends StatefulWidget {
  final String text;
  final Iterable<String> all;
  final TextStyle style;

  const UniformLine(this.text, {super.key, required this.all, required this.style});

  @override
  State<UniformLine> createState() => _UniformLineState();
}

class _UniformLineState extends State<UniformLine> {
  @override
  void initState() {
    super.initState();
    // Measured widths change once the web fonts arrive.
    PaintingBinding.instance.systemFonts.addListener(_rebuild);
  }

  @override
  void dispose() {
    PaintingBinding.instance.systemFonts.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    return LayoutBuilder(
      builder: (context, box) {
        var widest = 0.0;
        for (final line in widget.all) {
          final painter = TextPainter(
            text: TextSpan(text: line, style: widget.style),
            textDirection: TextDirection.ltr,
            textScaler: scaler,
            maxLines: 1,
          )..layout();
          widest = math.max(widest, painter.width);
          painter.dispose();
        }
        var style = widget.style;
        if (widest > box.maxWidth && box.maxWidth.isFinite) {
          // Size and tracking shrink together, so the longest line fills the
          // width exactly.
          final scale = box.maxWidth / widest;
          style = style.copyWith(
            fontSize: (style.fontSize ?? 14) * scale,
            letterSpacing: style.letterSpacing == null ? null : style.letterSpacing! * scale,
          );
        }
        return Text(widget.text, style: style, maxLines: 1, softWrap: false);
      },
    );
  }
}
