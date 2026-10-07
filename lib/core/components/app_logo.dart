import 'package:flutter/material.dart';
import 'package:portfolio/core/components/asset_image_widget.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// A project's app icon with the iOS-like corner radius.
class AppLogo extends StatelessWidget {
  final String path;
  final double size;

  const AppLogo({super.key, required this.path, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(size * 0.25),
        border: Border.all(color: AppColors.line),
      ),
      child: AssetImageWidget(path, fit: BoxFit.cover, width: size, height: size),
    );
  }
}
