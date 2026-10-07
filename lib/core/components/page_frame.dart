import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Centers [child] in the content column: at most [AppLayout.maxWidth] wide,
/// with the page gutter on both sides.
class PageFrame extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const PageFrame({super.key, required this.child, this.maxWidth = AppLayout.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.gutter),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
