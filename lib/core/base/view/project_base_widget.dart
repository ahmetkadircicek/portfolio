import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/components/base_container_widget.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/features/home/model/card_model.dart';

import '../../constants/padding_constants.dart';

class ProjectBaseView extends StatelessWidget {
  final CardModel project;
  final List<CardModel> features;

  const ProjectBaseView({
    super.key,
    required this.project,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        margin: PaddingConstants.symmetricVerticalLarge * 2 + PaddingConstants.symmetricHorizontalLarge * 2,
        child: Row(
          spacing: 80,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: HeaderSection(project: project)),
            Expanded(flex: 7, child: ContentGrid(features: features)),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final CardModel project;

  const HeaderSection({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConstants.symmetricVerticalMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.go('/projects'),
            child: HoverDetector(
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: context.secondary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      project.imagePath,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  context.spacerFixedWidth(8),
                  Text(
                    project.title,
                    style: GoogleFonts.cardo(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 6,
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
        Expanded(
          child: Row(
            spacing: 16,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BaseContainer(
                        firstColor: features[0].firstColor,
                        secondColor: features[0].secondColor,
                        topRightText: features[0].category,
                        child: Image.asset(
                          features[0].imagePath,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      features[0].title,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      features[0].description,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BaseContainer(
                        firstColor: features[1].firstColor,
                        secondColor: features[1].secondColor,
                        topRightText: features[1].category,
                        child: Image.asset(
                          features[1].imagePath,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      features[1].title,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      features[1].description,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            spacing: 16,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BaseContainer(
                        firstColor: features[2].firstColor,
                        secondColor: features[2].secondColor,
                        topRightText: features[2].category,
                        child: Image.asset(
                          features[2].imagePath,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      features[2].title,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      features[2].description,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BaseContainer(
                        firstColor: features[3].firstColor,
                        secondColor: features[3].secondColor,
                        topRightText: features[3].category,
                        child: Image.asset(
                          features[3].imagePath,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      features[3].title,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      features[3].description,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
