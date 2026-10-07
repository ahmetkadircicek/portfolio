import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:portfolio/core/components/asset_image_widget.dart';
import 'package:portfolio/core/components/pill.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// A project highlight: a mockup on a gradient with a label, then its title
/// and description. On desktop the card tilts toward the mouse and the
/// mockup zooms in on hover.
class FeatureCard extends StatelessWidget {
  final ProjectFeature feature;
  final double aspectRatio;

  const FeatureCard({super.key, required this.feature, this.aspectRatio = 4 / 3});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(aspectRatio: aspectRatio, child: _FeatureImage(feature: feature)),
        const SizedBox(height: AppSpace.x4),
        Text(feature.title, style: text.title),
        const SizedBox(height: AppSpace.x1),
        Text(feature.description, style: text.bodySmall.copyWith(color: AppColors.inkMuted)),
      ],
    );
  }
}

class _FeatureImage extends StatefulWidget {
  final ProjectFeature feature;

  const _FeatureImage({required this.feature});

  @override
  State<_FeatureImage> createState() => _FeatureImageState();
}

class _FeatureImageState extends State<_FeatureImage> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    // Tilt and hover zoom are mouse effects. On touch screens the tilt would
    // also follow the gyroscope and fight with scrolling.
    final interactive = context.isDesktop;
    final feature = widget.feature;
    final card = MouseRegion(
      onEnter: interactive ? (_) => setState(() => _hovering = true) : null,
      onExit: interactive ? (_) => setState(() => _hovering = false) : null,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: feature.colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.line),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpace.x4),
              child: AnimatedScale(
                scale: interactive && _hovering ? 3.0 : 1.0,
                duration: AppMotion.slow,
                curve: AppMotion.emphasized,
                child: AssetImageWidget(
                  feature.image,
                  fit: BoxFit.contain,
                  semanticLabel: '${feature.title} — ${feature.label}',
                  // Desktop keeps full resolution for the 3x hover zoom.
                  decodeAtLayoutWidth: !interactive,
                ),
              ),
            ),
            Positioned(
              top: AppSpace.x4,
              right: AppSpace.x4,
              child: Pill(feature.label, style: PillStyle.onImage),
            ),
          ],
        ),
      ),
    );

    if (!interactive) return card;
    return Tilt(
      borderRadius: AppRadius.mdAll,
      shadowConfig: const ShadowConfig(color: AppColors.surface),
      lightConfig: const LightConfig(disable: true),
      // Mouse only: touch tilting on wide tablets would swallow scroll drags.
      tiltConfig: const TiltConfig(angle: 3, enableGestureSensors: false, enableGestureTouch: false),
      child: card,
    );
  }
}
