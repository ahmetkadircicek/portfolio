import 'package:flutter/material.dart';
import 'package:portfolio/core/components/app_logo.dart';
import 'package:portfolio/core/components/asset_image_widget.dart';
import 'package:portfolio/core/components/hover_link.dart';
import 'package:portfolio/core/components/page_frame.dart';
import 'package:portfolio/core/components/pill.dart';
import 'package:portfolio/core/components/reveal.dart';
import 'package:portfolio/core/components/section_header.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

/// One project page: title, status, overview, facts and screenshots.
class CaseStudy extends StatelessWidget {
  final Project project;
  final int index;

  const CaseStudy({super.key, required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    return SingleChildScrollView(
      child: PageFrame(
        child: Padding(
          padding: EdgeInsets.only(top: mobile ? AppSpace.x6 : AppSpace.x12, bottom: context.sectionGap),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Reveal(child: _Title(project: project, index: index)),
              SizedBox(height: mobile ? AppSpace.x8 : AppSpace.x12),
              const Divider(height: 1, thickness: 1, color: AppColors.line),
              SizedBox(height: mobile ? AppSpace.x8 : AppSpace.x12),
              Reveal(child: _Body(project: project)),
              SizedBox(height: mobile ? AppSpace.x12 : AppSpace.x16),
              const Eyebrow('Screens'),
              const SizedBox(height: AppSpace.x4),
              _Screenshots(project: project),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final Project project;
  final int index;

  const _Title({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final mobile = context.isMobile;
    final count = Projects.all.length.toString().padLeft(2, '0');
    final number = (index + 1).toString().padLeft(2, '0');
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow('$number / $count  —  ${project.category}'),
        const SizedBox(height: AppSpace.x3),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Semantics(header: true, child: Text(project.name.toUpperCase(), style: text.h1)),
        ),
        const SizedBox(height: AppSpace.x2),
        Text(project.subtitle, style: text.h3.copyWith(color: AppColors.inkMuted, fontWeight: FontWeight.w400)),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpace.x6,
      children: [
        if (mobile) ...[
          AppLogo(path: project.logo, size: 72),
          heading,
        ] else
          Row(
            spacing: AppSpace.x8,
            children: [AppLogo(path: project.logo, size: 112), Expanded(child: heading)],
          ),
        Wrap(
          spacing: AppSpace.x6,
          runSpacing: AppSpace.x3,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Wrap(
              spacing: AppSpace.x2,
              children: [for (final s in project.statuses) Pill.status(s.label, color: s.color)],
            ),
            if (project.repositoryUrl != null)
              HoverLink(
                label: 'View on GitHub',
                icon: LinkIcon.external,
                style: text.bodySmall.copyWith(fontWeight: FontWeight.w500),
                onTap: () => launchUrl(Uri.parse(project.repositoryUrl!), webOnlyWindowName: '_blank'),
              ),
          ],
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final Project project;

  const _Body({required this.project});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final overview = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Eyebrow('Overview'),
        const SizedBox(height: AppSpace.x4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppLayout.readingWidth),
          child: Text(project.overview, style: text.bodyLarge.copyWith(color: AppColors.inkMuted, height: 1.7)),
        ),
      ],
    );
    final facts = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpace.x6,
      children: [
        _Fact(label: 'Category', child: Text(project.category, style: text.body)),
        _Fact(label: 'Built with', child: Text(project.builtWith, style: text.body)),
        _Fact(
          label: 'Technologies',
          child: Wrap(
            spacing: AppSpace.x2,
            runSpacing: AppSpace.x2,
            children: [for (final t in project.technologies) Pill(t)],
          ),
        ),
      ],
    );

    if (!context.isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpace.x12,
        children: [overview, facts],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpace.x16,
      children: [Expanded(flex: 7, child: overview), Expanded(flex: 4, child: facts)],
    );
  }
}

class _Fact extends StatelessWidget {
  final String label;
  final Widget child;

  const _Fact({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(label),
        const SizedBox(height: AppSpace.x2),
        child,
        const SizedBox(height: AppSpace.x6),
        const Divider(height: 1, thickness: 1, color: AppColors.line),
      ],
    );
  }
}

class _Screenshots extends StatelessWidget {
  final Project project;

  const _Screenshots({required this.project});

  @override
  Widget build(BuildContext context) {
    // A grid instead of a sideways list, so swiping still changes projects.
    final columns = context.isDesktop ? project.screenshots.length : (context.isMobile ? 2 : 4);
    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = context.isDesktop ? AppSpace.x4 : AppSpace.x3;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < project.screenshots.length; i++)
              SizedBox(
                width: width,
                child: Reveal(
                  delay: Duration(milliseconds: 60 * (i % columns)),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.mdAll,
                      border: Border.all(color: AppColors.line),
                    ),
                    child: AssetImageWidget(
                      project.screenshots[i],
                      fit: BoxFit.cover,
                      semanticLabel: '${project.name} screenshot ${i + 1}',
                      decodeAtLayoutWidth: true,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
