import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Phone screens standing on a ground: three or five of them overlapping,
/// the middle one larger and in front, all cropped by the bottom edge. The
/// ground fades out towards the top, so the screens rise out of it instead
/// of sitting in a box.
///
/// [screens] run from outermost to outermost; the middle one is the best.
/// [lifted] raises them a little, e.g. on hover.
class ScreenStage extends StatelessWidget {
  final List<String> screens;
  final double aspectRatio;

  /// The project's color for a faint tint; null uses the neutral surface.
  final Color? tint;
  final bool lifted;
  final BorderRadius radius;

  const ScreenStage({
    super.key,
    required this.screens,
    this.aspectRatio = 16 / 9,
    this.tint,
    this.lifted = false,
    this.radius = const BorderRadius.all(Radius.circular(14)),
  }) : assert(screens.length == 3 || screens.length == 5);

  /// Width of a screen for its height; the trimmed phone frames are close
  /// to this.
  static const _screenRatio = 0.49;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final base = tint ?? colors.surface;
    final ground = tint == null
        ? [base, base, base.withValues(alpha: 0)]
        : [base.withValues(alpha: 0.16), base.withValues(alpha: 0.06), base.withValues(alpha: 0)];
    final stops = tint == null ? const [0.0, 0.3, 1.0] : const [0.0, 0.4, 1.0];
    final duration = context.reduceMotion ? Duration.zero : const Duration(milliseconds: 500);

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: radius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: ground,
              stops: stops,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, box) {
              final h = box.maxHeight;
              final w = box.maxWidth;
              // Height and top of each screen as a share of the stage height,
              // from the outside in; mirrored on the other side.
              final five = screens.length == 5;
              final rows = five
                  ? const [(0.92, 0.304), (1.06, 0.188), (1.22, 0.072)]
                  : const [(1.04, 0.225), (1.20, 0.078)];
              final overlap = h * (five ? 0.109 : 0.1385);
              final specs = [...rows, ...rows.reversed.skip(1)];
              final widths = [for (final s in specs) h * s.$1 * _screenRatio];
              final total = widths.fold(0.0, (a, b) => a + b) - overlap * (specs.length - 1);
              var x = (w - total) / 2;
              final lift = lifted ? 12.0 : 0.0;

              final placed = <(int depth, Widget)>[];
              for (var i = 0; i < specs.length; i++) {
                final (size, top) = specs[i];
                final depth = (i - specs.length ~/ 2).abs();
                placed.add((
                  depth,
                  AnimatedPositioned(
                    duration: duration,
                    curve: AppMotion.emphasized,
                    left: x,
                    top: h * top - lift,
                    width: widths[i],
                    height: h * size,
                    child: _Screen(screens[i]),
                  ),
                ));
                x += widths[i] - overlap;
              }
              // Outer screens first, so the middle one is drawn on top.
              placed.sort((a, b) => b.$1.compareTo(a.$1));
              return Stack(clipBehavior: Clip.hardEdge, children: [for (final p in placed) p.$2]);
            },
          ),
        ),
      ),
    );
  }
}

/// A screen with a soft shadow that follows its rounded phone frame.
class _Screen extends StatelessWidget {
  final String path;

  const _Screen(this.path);

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(path, fit: BoxFit.contain, excludeFromSemantics: true, gaplessPlayback: true);
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Transform.translate(
          offset: const Offset(0, 18),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(context.colors.ink.withValues(alpha: 0.22), BlendMode.srcIn),
              child: image,
            ),
          ),
        ),
        image,
      ],
    );
  }
}
