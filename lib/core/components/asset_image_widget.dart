import 'package:flutter/material.dart';

/// [Image.asset] that fades in once decoded instead of popping in, and shows
/// nothing (rather than a broken image) if the asset fails to load.
class AssetImageWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? semanticLabel;

  const AssetImageWidget(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
      gaplessPlayback: true,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: child,
        );
      },
      errorBuilder: (context, error, stackTrace) => SizedBox(width: width, height: height),
    );
  }
}
