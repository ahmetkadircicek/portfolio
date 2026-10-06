import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

import '../init/notifier/app_notifier.dart';

class CustomCursorWidget extends StatefulWidget {
  final Widget child;
  const CustomCursorWidget({
    super.key,
    required this.child,
  });

  @override
  State<CustomCursorWidget> createState() => _CustomCursorWidgetState();
}

class _CustomCursorWidgetState extends State<CustomCursorWidget> {
  Offset _pointerPosition = Offset.zero;
  final List<Offset> _trailPoints = [];
  late Timer _trailTimer;
  late int _trailDuration;

  @override
  void initState() {
    super.initState();
    _detectBrowser();
    _trailTimer = Timer.periodic(Duration(milliseconds: _trailDuration), (timer) {
      if (_trailPoints.isNotEmpty) {
        setState(() {
          _trailPoints.removeAt(0);
        });
      }
    });
  }

  void _detectBrowser() {
    final userAgent = html.window.navigator.userAgent;
    if (userAgent.contains('Chrome')) {
      _trailDuration = 7;
    } else if (userAgent.contains('Safari')) {
      _trailDuration = 14;
    } else if (userAgent.contains('Firefox')) {
      _trailDuration = 10;
    } else {
      _trailDuration = 10;
    }
  }

  @override
  void dispose() {
    _trailTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: (event) {
        setState(() {
          _pointerPosition = event.position;
          _trailPoints.add(_pointerPosition);

          if (_trailPoints.length > 80) {
            _trailPoints.removeAt(0);
          }
        });
      },
      child: Stack(
        children: [
          widget.child,
          CustomPaint(
            painter: CursorTrailPainter(
              context: context,
              trailPoints: _trailPoints,
              pointerPosition: _pointerPosition,
            ),
          ),
        ],
      ),
    );
  }
}

class CursorTrailPainter extends CustomPainter {
  final List<Offset> trailPoints;
  final Offset pointerPosition;
  final BuildContext context;

  CursorTrailPainter({
    required this.context,
    required this.trailPoints,
    required this.pointerPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trailPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Paint pointerPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (int i = 0; i < trailPoints.length - 1; i++) {
      canvas.drawLine(trailPoints[i], trailPoints[i + 1], trailPaint);
    }
    canvas.drawCircle(
      pointerPosition,
      Provider.of<AppNotifier>(context, listen: false).isHover ? 12 : 4,
      pointerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
