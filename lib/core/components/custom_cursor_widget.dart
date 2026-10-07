import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/init/notifier/app_notifier.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:provider/provider.dart';

/// Replaces the system cursor with a small circle and a fading trail on
/// desktop widths.
///
/// Only the cursor overlay repaints on mouse moves; the page underneath is
/// never rebuilt. The ticker that shortens the trail runs only while there is
/// a trail to shorten.
class CustomCursorWidget extends StatefulWidget {
  final Widget child;
  const CustomCursorWidget({
    super.key,
    required this.child,
  });

  @override
  State<CustomCursorWidget> createState() => _CustomCursorWidgetState();
}

class _CustomCursorWidgetState extends State<CustomCursorWidget> with SingleTickerProviderStateMixin {
  static const _maxTrailLength = 80;
  static const _trailPointLifetime = Duration(microseconds: 7000);

  final _cursor = _CursorState();
  late final Ticker _ticker = createTicker(_onTick);
  Duration _lastTick = Duration.zero;
  Duration _pending = Duration.zero;

  void _onHover(PointerHoverEvent event) {
    _cursor.move(event.position, _maxTrailLength);
    if (!_ticker.isActive) {
      _lastTick = Duration.zero;
      _pending = Duration.zero;
      _ticker.start();
    }
  }

  void _onTick(Duration elapsed) {
    _pending += elapsed - _lastTick;
    _lastTick = elapsed;
    final expired = _pending.inMicroseconds ~/ _trailPointLifetime.inMicroseconds;
    if (expired == 0) return;
    _pending -= _trailPointLifetime * expired;
    if (!_cursor.shrink(expired)) _ticker.stop();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _cursor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active = context.isDesktop;
    // The tree shape stays the same on every width so crossing the desktop
    // breakpoint never rebuilds the navigator underneath.
    return CustomCursorScope(
      active: active,
      child: MouseRegion(
        cursor: active ? SystemMouseCursors.none : MouseCursor.defer,
        onHover: active ? _onHover : null,
        onExit: (_) => _cursor.hide(),
        child: Stack(
          children: [
            widget.child,
            Positioned.fill(
              child: IgnorePointer(
                child: active
                    ? RepaintBoundary(
                        child: CustomPaint(
                          painter: _CursorTrailPainter(
                            cursor: _cursor,
                            hover: context.read<AppNotifier>(),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tells [HoverDetector] whether the custom cursor is drawn, so it can show
/// the system hand cursor when it is not.
class CustomCursorScope extends InheritedWidget {
  final bool active;
  const CustomCursorScope({super.key, required this.active, required super.child});

  static bool isActive(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CustomCursorScope>()?.active ?? false;

  @override
  bool updateShouldNotify(CustomCursorScope oldWidget) => active != oldWidget.active;
}

class _CursorState extends ChangeNotifier {
  final Queue<Offset> trail = Queue();
  Offset? pointer;

  void move(Offset position, int maxLength) {
    pointer = position;
    trail.add(position);
    while (trail.length > maxLength) {
      trail.removeFirst();
    }
    notifyListeners();
  }

  /// Drops the [count] oldest points. Returns false once the trail is gone.
  bool shrink(int count) {
    for (var i = 0; i < count && trail.isNotEmpty; i++) {
      trail.removeFirst();
    }
    notifyListeners();
    return trail.isNotEmpty;
  }

  void hide() {
    pointer = null;
    trail.clear();
    notifyListeners();
  }
}

class _CursorTrailPainter extends CustomPainter {
  final _CursorState cursor;
  final AppNotifier hover;

  _CursorTrailPainter({required this.cursor, required this.hover}) : super(repaint: Listenable.merge([cursor, hover]));

  // Each stroke is drawn twice, white under ink, so the cursor stays visible
  // on dark sections too.
  static final Paint _trailPaint = Paint()
    ..color = AppColors.ink
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    ..strokeJoin = StrokeJoin.round;

  static final Paint _trailHalo = Paint()
    ..color = AppColors.onInkMuted
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5
    ..strokeJoin = StrokeJoin.round;

  static final Paint _pointerPaint = Paint()
    ..color = AppColors.ink
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  static final Paint _pointerHalo = Paint()
    ..color = AppColors.onInkMuted
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
    final pointer = cursor.pointer;
    if (pointer == null) return;

    if (cursor.trail.length > 1) {
      final path = Path();
      final points = cursor.trail.iterator..moveNext();
      path.moveTo(points.current.dx, points.current.dy);
      while (points.moveNext()) {
        path.lineTo(points.current.dx, points.current.dy);
      }
      canvas
        ..drawPath(path, _trailHalo)
        ..drawPath(path, _trailPaint);
    }
    final radius = hover.isHover ? 14.0 : 4.0;
    canvas
      ..drawCircle(pointer, radius, _pointerHalo)
      ..drawCircle(pointer, radius, _pointerPaint);
  }

  @override
  bool shouldRepaint(covariant _CursorTrailPainter oldDelegate) =>
      oldDelegate.cursor != cursor || oldDelegate.hover != hover;
}
