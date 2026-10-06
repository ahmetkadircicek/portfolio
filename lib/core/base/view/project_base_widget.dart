import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/components/asset_image_widget.dart';
import 'package:portfolio/core/components/base_container_widget.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/features/home/model/card_model.dart';

import '../../constants/padding_constants.dart';

/// A home page project section: title and pitch on one side, four feature
/// cards on the other. Phones and tablets stack the two.
class ProjectBaseView extends StatelessWidget {
  final CardModel project;
  final List<CardModel> features;

  /// Route segment of the project's details page, e.g. `tunes`.
  final String slug;

  const ProjectBaseView({
    super.key,
    required this.project,
    required this.features,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    if (!context.isDesktop) return _buildCompact(context);

    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        margin: PaddingConstants.symmetricVerticalLarge * 2 + PaddingConstants.symmetricHorizontalLarge * 2,
        child: Row(
          spacing: 80,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: HeaderSection(project: project, slug: slug)),
            Expanded(flex: 7, child: ContentGrid(features: features)),
          ],
        ),
      ),
    );
  }

  Widget _buildCompact(BuildContext context) {
    final mobile = context.isMobile;
    return Padding(
      padding: mobile
          ? const EdgeInsets.fromLTRB(16, 32, 16, 16)
          : PaddingConstants.symmetricVerticalLarge + PaddingConstants.symmetricHorizontalLarge * 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          HeaderSection(project: project, slug: slug),
          if (mobile)
            for (final feature in features) _FeatureCard(feature: feature)
          else
            for (var i = 0; i < features.length; i += 2)
              Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final feature in features.skip(i).take(2)) Expanded(child: _FeatureCard(feature: feature)),
                ],
              ),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final CardModel project;
  final String slug;

  const HeaderSection({
    super.key,
    required this.project,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    return Padding(
      padding: PaddingConstants.symmetricVerticalMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.go('/projects/$slug'),
            child: HoverDetector(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: context.secondary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: AssetImageWidget(
                      project.imagePath,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  context.spacerFixedWidth(8),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        project.title,
                        style: GoogleFonts.cardo(
                          fontSize: mobile ? 26 : 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: mobile ? 4 : 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          context.spacerFixedHeight(16),
          Text(
            project.subtitle,
            style: GoogleFonts.montserrat(
              fontSize: 32 * 0.6,
              fontWeight: FontWeight.normal,
            ),
          ),
          context.spacerFixedHeight(8),
          Text(
            project.description,
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ContentGrid extends StatelessWidget {
  final List<CardModel> features;

  const ContentGrid({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        for (var i = 0; i < features.length; i += 2)
          Expanded(
            child: Row(
              spacing: 16,
              children: [
                for (final feature in features.skip(i).take(2)) Expanded(child: _FeatureCard(feature: feature)),
              ],
            ),
          ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final CardModel feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    // Desktop cards share the viewport height; elsewhere the image keeps the
    // proportions the desktop cards have at 1440x900.
    final desktop = context.isDesktop;
    final image = BaseContainer(
      firstColor: feature.firstColor,
      secondColor: feature.secondColor,
      topRightText: feature.category,
      child: AssetImageWidget(
        feature.imagePath,
        width: double.infinity,
        fit: BoxFit.contain,
        semanticLabel: '${feature.title} — ${feature.subtitle}',
        // Desktop keeps full resolution for the 3x hover zoom.
        decodeAtLayoutWidth: !desktop,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (desktop) Expanded(child: image) else AspectRatio(aspectRatio: 1.45, child: image),
        const SizedBox(height: 16),
        Text(
          feature.title,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          feature.description,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          maxLines: desktop ? 3 : null,
          overflow: desktop ? TextOverflow.ellipsis : null,
        ),
      ],
    );
  }
}
