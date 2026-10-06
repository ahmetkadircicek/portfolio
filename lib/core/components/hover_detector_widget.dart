import 'package:flutter/material.dart';
import 'package:portfolio/core/components/custom_cursor_widget.dart';
import 'package:portfolio/core/init/notifier/app_notifier.dart';
import 'package:provider/provider.dart';

/// Grows the custom cursor while the pointer is over [child], or shows the
/// system hand cursor where the custom cursor is not drawn.
class HoverDetector extends StatefulWidget {
  const HoverDetector({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<HoverDetector> createState() => _HoverDetectorState();
}

class _HoverDetectorState extends State<HoverDetector> {
  late final AppNotifier _notifier = context.read<AppNotifier>();
  bool _hovering = false;

  void _setHover(bool value) {
    _hovering = value;
    _notifier.setHover(value);
  }

  @override
  void dispose() {
    // MouseRegion does not report an exit when it is removed, e.g. after a
    // tap navigates away, so the cursor would stay enlarged.
    if (_hovering) _notifier.setHover(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: CustomCursorScope.isActive(context) ? MouseCursor.defer : SystemMouseCursors.click,
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: widget.child,
    );
  }
}
