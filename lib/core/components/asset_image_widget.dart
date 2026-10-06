import 'package:flutter/material.dart';

/// [Image.asset] that fades in once decoded instead of popping in, and shows
/// nothing (rather than a broken image) if the asset fails to load.
class AssetImageWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? semanticLabel;

  /// Decodes the image at the width it is laid out at instead of its full
  /// resolution. A 1400 px mockup shown 360 px wide on a phone would
  /// otherwise hold about 8 MB of GPU memory.
  final bool decodeAtLayoutWidth;

  const AssetImageWidget(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.semanticLabel,
    this.decodeAtLayoutWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!decodeAtLayoutWidth) return _buildImage(null);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!constraints.hasBoundedWidth) return _buildImage(null);
        final pixels = constraints.maxWidth * MediaQuery.devicePixelRatioOf(context);
        // Rounded up to 64 px steps so resizing the window does not decode
        // the image again for every pixel.
        return _buildImage((pixels / 64).ceil() * 64);
      },
    );
  }

  Widget _buildImage(int? cacheWidth) {
    return Image.asset(
      path,
      cacheWidth: cacheWidth,
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
