import 'package:flutter/material.dart';

/// Shows the hand cursor while the pointer is over [child].
class HoverDetector extends StatelessWidget {
  const HoverDetector({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: child,
    );
  }
}
