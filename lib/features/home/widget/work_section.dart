import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/components/app_logo.dart';
import 'package:portfolio/core/components/feature_card.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/components/hover_link.dart';
import 'package:portfolio/core/components/page_frame.dart';
import 'package:portfolio/core/components/pill.dart';
import 'package:portfolio/core/components/reveal.dart';
import 'package:portfolio/core/components/section_header.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

String _number(int index) => (index + 1).toString().padLeft(2, '0');

/// Featured projects with their highlight cards, then the rest as an index.
class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = Projects.featured;
    final others = Projects.others;
    return PageFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Reveal(child: SectionHeader(title: 'Selected work', count: Projects.all.length.toString().padLeft(2, '0'))),
          for (final project in featured) _FeaturedProject(project: project, index: Projects.all.indexOf(project)),
          SizedBox(height: context.sectionGap),
          const Reveal(child: Eyebrow('More projects')),
          const SizedBox(height: AppSpace.x4),
          const Divider(height: 1, thickness: 1, color: AppColors.line),
          for (final project in others) ...[
            Reveal(child: _ProjectRow(project: project, index: Projects.all.indexOf(project))),
            const Divider(height: 1, thickness: 1, color: AppColors.line),
          ],
        ],
      ),
    );
  }
}

class _FeaturedProject extends StatelessWidget {
  final Project project;
  final int index;

  const _FeaturedProject({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow('${_number(index)}  —  ${project.category}'),
        const SizedBox(height: AppSpace.x6),
        Row(
          spacing: AppSpace.x4,
          children: [
            AppLogo(path: project.logo, size: 56),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(project.name.toUpperCase(), style: text.h2),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.x4),
        Text(project.subtitle, style: text.h3),
      ],
    );
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.summary, style: text.body.copyWith(color: AppColors.inkMuted)),
        const SizedBox(height: AppSpace.x4),
        Wrap(
          spacing: AppSpace.x6,
          runSpacing: AppSpace.x3,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Wrap(
              spacing: AppSpace.x2,
              children: [
                for (final status in project.statuses) Pill.status(status.label, color: status.color),
                Pill(project.builtWith),
              ],
            ),
            HoverLink(
              label: 'View case study',
              icon: LinkIcon.forward,
              onTap: () => context.go('/projects/${project.slug}'),
            ),
          ],
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.only(top: context.isMobile ? AppSpace.x16 : AppSpace.x24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Reveal(
            child: context.isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: AppSpace.x16,
                    children: [Expanded(flex: 5, child: title), Expanded(flex: 7, child: details)],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpace.x6,
                    children: [title, details],
                  ),
          ),
          SizedBox(height: context.isMobile ? AppSpace.x8 : AppSpace.x12),
          _FeatureGrid(features: project.features),
        ],
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  final List<ProjectFeature> features;

  const _FeatureGrid({required this.features});

  @override
  Widget build(BuildContext context) {
    // Phones show one landscape card per row; wider screens show portrait
    // cards, which suit the phone mockups.
    final columns = context.isDesktop ? 4 : (context.isTablet ? 2 : 1);
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpace.x6;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: AppSpace.x12,
          children: [
            for (var i = 0; i < features.length; i++)
              SizedBox(
                width: width,
                child: Reveal(
                  delay: Duration(milliseconds: 80 * (i % columns)),
                  child: FeatureCard(feature: features[i], aspectRatio: columns == 1 ? 4 / 3 : 3 / 4),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// One line of the project index; the whole row leads to the project page.
class _ProjectRow extends StatefulWidget {
  final Project project;
  final int index;

  const _ProjectRow({required this.project, required this.index});

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final text = context.text;
    final mobile = context.isMobile;
    final desktop = context.isDesktop;

    final name = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpace.x1,
      children: [
        Text(project.name.toUpperCase(), style: text.h2.copyWith(fontSize: mobile ? 20 : 24)),
        Text(project.subtitle, style: text.bodySmall.copyWith(color: AppColors.inkMuted)),
      ],
    );
    final statuses = Wrap(
      spacing: AppSpace.x2,
      runSpacing: AppSpace.x2,
      children: [for (final status in project.statuses) Pill.status(status.label, color: status.color)],
    );
    final arrow = AnimatedRotation(
      turns: _hovering ? -0.125 : 0,
      duration: AppMotion.base,
      curve: AppMotion.standard,
      child: const Icon(Icons.arrow_forward, size: 22, color: AppColors.ink),
    );

    return Semantics(
      link: true,
      label: '${project.name} — ${project.subtitle}',
      child: HoverDetector(
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.go('/projects/${project.slug}'),
            child: AnimatedContainer(
              duration: AppMotion.base,
              curve: AppMotion.standard,
              padding: EdgeInsets.symmetric(
                vertical: mobile ? AppSpace.x6 : AppSpace.x8,
                horizontal: _hovering ? AppSpace.x6 : 0,
              ),
              decoration: BoxDecoration(
                color: _hovering ? AppColors.surface : AppColors.surface.withValues(alpha: 0),
                borderRadius: AppRadius.mdAll,
              ),
              child: Row(
                spacing: mobile ? AppSpace.x4 : AppSpace.x6,
                children: [
                  if (!mobile) SizedBox(width: 32, child: Eyebrow(_number(widget.index))),
                  AppLogo(path: project.logo, size: mobile ? 48 : 56),
                  Expanded(
                    flex: 4,
                    child: mobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: AppSpace.x3,
                            children: [name, statuses],
                          )
                        : name,
                  ),
                  if (desktop)
                    Expanded(
                      flex: 5,
                      child: Text(project.summary, style: text.bodySmall.copyWith(color: AppColors.inkMuted)),
                    ),
                  if (!mobile) SizedBox(width: desktop ? 220 : 180, child: statuses),
                  arrow,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
