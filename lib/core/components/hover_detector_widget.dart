import 'package:flutter/material.dart';
import 'package:portfolio/core/init/notifier/app_notifier.dart';
import 'package:provider/provider.dart';

class HoverDetector extends StatelessWidget {
  const HoverDetector({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        Provider.of<AppNotifier>(context, listen: false).toggleHover();
      },
      onExit: (event) {
        Provider.of<AppNotifier>(context, listen: false).toggleHover();
      },
      child: child,
    );
  }
}
