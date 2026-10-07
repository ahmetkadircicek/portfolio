import 'package:flutter/material.dart';
import 'package:portfolio/core/components/asset_image_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// An app's screenshots: one row on desktops, a grid of four on tablets and
/// two on phones. Never a sideways list.
class ScreenshotRow extends StatelessWidget {
  final List<String> paths;

  const ScreenshotRow({super.key, required this.paths});

  @override
  Widget build(BuildContext context) {
    Widget shot(String path) => ClipRRect(
          borderRadius: AppRadius.smAll,
          child: ColoredBox(
            color: context.colors.surface,
            child:
                AssetImageWidget(path, fit: BoxFit.cover, semanticLabel: 'App screenshot', decodeAtLayoutWidth: true),
          ),
        );

    if (context.isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.x4,
        children: [for (final p in paths) Expanded(child: shot(p))],
      );
    }

    final columns = context.isMobile ? 2 : 4;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - AppSpace.x4 * (columns - 1)) / columns;
        return Wrap(
          spacing: AppSpace.x4,
          runSpacing: AppSpace.x4,
          children: [for (final p in paths) SizedBox(width: width, child: shot(p))],
        );
      },
    );
  }
}
