import 'package:flutter/material.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/components/asset_image_widget.dart';

/// An entry's logo as an app icon with the iOS-like corner radius. Without
/// a [path], e.g. for freelance work, it draws a code mark.
class AppLogo extends StatelessWidget {
  final String? path;
  final double size;

  const AppLogo({super.key, required this.path, required this.size});

  @override
  Widget build(BuildContext context) {
    final path = this.path;
    final radius = BorderRadius.circular(size * 0.25);
    if (path == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: context.colors.ink, borderRadius: radius),
        child: Icon(Icons.code, color: context.colors.onInk, size: size * 0.4, semanticLabel: context.t(S.freelance)),
      );
    }
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: radius,
        border: Border.all(color: context.colors.line),
      ),
      child: AssetImageWidget(path, fit: BoxFit.cover, width: size, height: size),
    );
  }
}
