import 'package:flutter/material.dart';
import 'package:portfolio/core/components/grid.dart';
import 'package:portfolio/core/components/pressable.dart';
import 'package:portfolio/core/components/screen_stage.dart';
import 'package:portfolio/core/components/site_nav.dart';
import 'package:portfolio/core/data/figures.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/features/site/parts.dart';
import 'package:portfolio/features/site/project_figures.dart';

/// A project's case study at `/projects/<slug>`: the title and facts, the
/// cover, the chapters, the screens, the technology and the way on to the
/// next project. The project's notebook (see figures.dart) adds its
/// diagrams after the second chapter and its tables inside chapters.
class ProjectPage extends StatelessWidget {
  final Project project;

  const ProjectPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final chapterGap = mobile ? AppSpace.x20 : AppSpace.x30;
    final notebook = notebookOf(project);
    return SitePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(project: project),
          SizedBox(height: mobile ? AppSpace.x8 : AppSpace.x14),
          PageColumn(
            child: ScreenStage(
              screens: mobile ? project.rowScreens : project.cover,
              aspectRatio: mobile ? 1 : 2,
              tint: project.color,
              radius: BorderRadius.circular(mobile ? 12 : 14),
            ),
          ),
          for (final (i, chapter) in project.chapters.indexed) ...[
            SizedBox(height: chapterGap),
            _Chapter(number: i + 1, chapter: chapter, table: notebook?.tables[i]),
            if (i == 1 && notebook != null) ...[
              SizedBox(height: mobile ? AppSpace.x6 : AppSpace.x12),
              PageColumn(child: NotebookFigures(notebook: notebook)),
            ],
          ],
          SizedBox(height: chapterGap),
          _Gallery(project: project),
          SizedBox(height: chapterGap),
          _Technology(project: project),
          SizedBox(height: mobile ? AppSpace.x24 : AppSpace.x40),
          _Next(project: nextProject(project)),
          const ContactBand(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Project project;

  const _Header({required this.project});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final mobile = context.isMobile;
    final number = (work.indexOf(project) + 1).toString().padLeft(2, '0');
    final iconSize = mobile ? 56.0 : 72.0;

    final facts = [
      (Copy.role, Text(context.t(project.role), style: type.bodySmall)),
      (Copy.platform, Text(context.t(project.platform), style: type.bodySmall)),
      (
        Copy.status,
        project.repo == null
            ? Text(context.t(project.status), style: type.bodySmall)
            : TextLink(
                label: '${context.t(project.status)} ↗',
                to: project.repo!,
                style: type.bodySmall.copyWith(color: colors.ink),
              ),
      ),
      (Copy.stack, Text(project.stack, style: type.bodySmall)),
    ];

    return PageColumn(
      child: Padding(
        padding: EdgeInsets.only(top: mobile ? AppSpace.x10 : AppSpace.x24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Pressable(
              to: HomeSection.work.path,
              builder: (context, hovered, _) => Align(
                alignment: Alignment.centerLeft,
                widthFactor: 1,
                child: MonoLabel('← ${context.t(Copy.work)} / $number', color: hovered ? colors.ink : null),
              ),
            ),
            SizedBox(height: mobile ? AppSpace.x5 : AppSpace.x8),
            ClipRRect(
              borderRadius: BorderRadius.circular(iconSize * 0.22),
              child: Image.asset(project.logo, width: iconSize, height: iconSize, excludeFromSemantics: true),
            ),
            SizedBox(height: mobile ? AppSpace.x4 : AppSpace.x7),
            Semantics(
              header: true,
              child: mobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(project.name, style: type.display),
                        Text(context.t(project.descriptor),
                            style: type.display.copyWith(fontSize: 40, fontStyle: FontStyle.italic, color: colors.inkSubtle)),
                      ],
                    )
                  : Text.rich(
                      TextSpan(children: [
                        TextSpan(text: '${project.name} '),
                        TextSpan(
                          text: context.t(project.descriptor),
                          style: TextStyle(fontStyle: FontStyle.italic, color: colors.inkSubtle),
                        ),
                      ]),
                      style: type.display.copyWith(fontSize: 120),
                    ),
            ),
            SizedBox(height: mobile ? AppSpace.x4 : AppSpace.x7),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: Text(context.t(project.lede),
                  style: type.lead.copyWith(fontSize: mobile ? 22 : 30, color: colors.inkMuted)),
            ),
            SizedBox(height: mobile ? AppSpace.x8 : AppSpace.x14),
            DecoratedBox(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.line))),
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpace.x5),
                child: LayoutBuilder(
                  builder: (context, box) {
                    final columns = mobile ? 2 : 4;
                    final width = (box.maxWidth - AppSpace.x6 * (columns - 1)) / columns;
                    return Wrap(
                      spacing: AppSpace.x6,
                      runSpacing: AppSpace.x4,
                      children: [
                        for (final (label, value) in facts)
                          SizedBox(
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [MonoLabel(context.t(label)), const SizedBox(height: 6), value],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chapter extends StatelessWidget {
  final int number;
  final Chapter chapter;
  final ChapterTable? table;

  const _Chapter({required this.number, required this.chapter, this.table});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final label = MonoLabel('${number.toString().padLeft(2, '0')} — ${context.t(chapter.label)}');
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(header: true, child: Text(context.t(chapter.lead), style: type.lead)),
        for (final paragraph in chapter.body) ...[
          const SizedBox(height: AppSpace.x5),
          Text(context.t(paragraph), style: type.body.copyWith(color: context.colors.inkMuted)),
        ],
        if (table != null) ...[const SizedBox(height: AppSpace.x8), ChapterTableView(table!)],
      ],
    );
    return PageColumn(
      child: context.isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [label, const SizedBox(height: AppSpace.x3), body],
            )
          : GridRow(cells: [
              GridCell(start: 1, span: 3, child: label),
              GridCell(start: 4, span: 8, child: body),
            ]),
    );
  }
}

class _Gallery extends StatelessWidget {
  final Project project;

  const _Gallery({required this.project});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final mobile = context.isMobile;
    final columns = mobile ? 2 : (project.screens.length == 6 ? 3 : 4);
    return PageColumn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: Copy.screens, detail: L.same('${project.screens.length}')),
          SizedBox(height: mobile ? AppSpace.x6 : AppSpace.x10),
          LayoutBuilder(
            builder: (context, box) {
              final gap = mobile ? AppSpace.x4 : (columns == 3 ? AppSpace.x12 : AppSpace.x6);
              final width = (box.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: mobile ? AppSpace.x8 : AppSpace.x14,
                children: [
                  for (final screen in project.screens)
                    SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(screen.image, width: width, semanticLabel: context.t(screen.title)),
                          const SizedBox(height: AppSpace.x3),
                          Text(context.t(screen.title), style: type.bodySmall.copyWith(fontWeight: FontWeight.w500)),
                          Text(context.t(screen.caption), style: type.caption.copyWith(color: colors.inkMuted)),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Technology extends StatelessWidget {
  final Project project;

  const _Technology({required this.project});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final mobile = context.isMobile;
    final list = DecoratedBox(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.line))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (group, tools) in project.technology)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.x2),
              child: mobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.upper(context.t(group)), style: type.note.copyWith(color: colors.inkSubtle)),
                        Text(tools, style: type.bodySmall),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(context.upper(context.t(group)), style: type.note.copyWith(color: colors.inkSubtle)),
                        ),
                        const SizedBox(width: AppSpace.x6),
                        Expanded(child: Text(tools, style: type.bodySmall)),
                      ],
                    ),
            ),
        ],
      ),
    );
    return PageColumn(
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [MonoLabel(context.t(Copy.technology)), const SizedBox(height: AppSpace.x3), list],
            )
          : GridRow(cells: [
              GridCell(start: 1, span: 3, child: MonoLabel(context.t(Copy.technology))),
              GridCell(start: 4, span: 9, child: list),
            ]),
    );
  }
}

/// The grey band that leads on to the next project; the last one leads
/// back to the first.
class _Next extends StatelessWidget {
  final Project project;

  const _Next({required this.project});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final mobile = context.isMobile;
    final first = project == work.first;
    final number = (work.indexOf(project) + 1).toString().padLeft(2, '0');

    return ColoredBox(
      color: colors.surface,
      child: Pressable(
        to: project.path,
        builder: (context, hovered, _) {
          final text = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MonoLabel('${context.t(first ? Copy.backToStart : Copy.nextProject)} — $number'),
              const SizedBox(height: AppSpace.x4),
              Text(project.name, style: type.display.copyWith(fontSize: mobile ? 56 : 96)),
              const SizedBox(height: AppSpace.x2),
              Text('${context.t(project.descriptor)} →', style: type.descriptor.copyWith(
                fontSize: mobile ? 22 : 30,
                color: colors.inkMuted,
                decoration: hovered ? TextDecoration.underline : null,
              )),
            ],
          );
          final stage = SizedBox(
            height: mobile ? 280 : 360,
            child: ScreenStage(
              screens: project.rowScreens,
              aspectRatio: mobile ? 390 / 280 : 16 / 9,
              lifted: hovered,
              radius: BorderRadius.zero,
            ),
          );
          return Padding(
            padding: EdgeInsets.only(top: mobile ? AppSpace.x12 : AppSpace.x20),
            child: mobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [PageColumn(child: text), const SizedBox(height: AppSpace.x6), stage],
                  )
                : PageColumn(
                    child: GridRow(crossAxisAlignment: CrossAxisAlignment.end, cells: [
                      GridCell(start: 1, span: 5, child: Padding(padding: const EdgeInsets.only(bottom: AppSpace.x20), child: text)),
                      GridCell(start: 6, span: 7, child: stage),
                    ]),
                  ),
          );
        },
      ),
    );
  }
}
