import 'package:flutter/material.dart';
import 'package:portfolio/core/components/asset_image_widget.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

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
        decoration: BoxDecoration(color: AppColors.ink, borderRadius: radius),
        child: Icon(Icons.code, color: AppColors.onInk, size: size * 0.4, semanticLabel: 'Freelance'),
      );
    }
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: radius,
        border: Border.all(color: AppColors.line),
      ),
      child: AssetImageWidget(path, fit: BoxFit.cover, width: size, height: size),
    );
  }
}
