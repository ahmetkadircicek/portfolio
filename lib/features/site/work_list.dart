import 'package:flutter/material.dart';
import 'package:portfolio/core/components/grid.dart';
import 'package:portfolio/core/components/pressable.dart';
import 'package:portfolio/core/components/screen_stage.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/features/site/parts.dart';

/// The home page's work section: one row per project. On wide screens the
/// text stays in view while its image scrolls past; on phones the image
/// comes first.
class WorkList extends StatelessWidget {
  const WorkList({super.key});

  @override
  Widget build(BuildContext context) {
    return PageColumn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: Copy.work, detail: Copy.workRange),
          for (final (i, project) in work.indexed)
            DecoratedBox(
              decoration: BoxDecoration(
                border: i == work.length - 1 ? null : Border(bottom: BorderSide(color: context.colors.line)),
              ),
              child: _Row(project: project, number: i + 1),
            ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final Project project;
  final int number;

  const _Row({required this.project, required this.number});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final text = _Text(project: project, number: number, showLink: mobile);

    final image = Pressable(
      to: project.path,
      semanticLabel: '${context.t(Copy.viewProject)}: ${project.name}',
      radius: AppRadius.mdAll,
      builder: (context, hovered, focused) {
        final lifted = hovered || focused;
        return Stack(
          children: [
            ExcludeSemantics(
              child: ScreenStage(
                screens: project.rowScreens,
                aspectRatio: mobile ? 1 : 16 / 9,
                lifted: lifted,
                radius: BorderRadius.circular(mobile ? 12 : 14),
              ),
            ),
            if (!mobile)
              Positioned(
                top: AppSpace.x5,
                right: AppSpace.x5,
                child: _ViewPill(visible: lifted),
              ),
          ],
        );
      },
    );

    if (mobile) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSpace.x7, bottom: AppSpace.x10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [image, const SizedBox(height: AppSpace.x5), text],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.x10),
      child: LayoutBuilder(
        builder: (context, box) => Stack(
          children: [
            GridRow(cells: [GridCell(start: 4, span: 9, child: image)]),
            // The text column takes the row's height from the image and
            // keeps the text in view inside it.
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: GridRow.spanWidth(box.maxWidth, 3),
              child: _StickyTop(child: text),
            ),
          ],
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final Project project;
  final int number;
  final bool showLink;

  const _Text({required this.project, required this.number, required this.showLink});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final mobile = context.isMobile;
    final note = type.note.copyWith(color: colors.inkSubtle);
    final meta = [
      context.t(project.label),
      context.t(project.platform).split(' · ').first.replaceAll(' & ', ' / ').replaceAll(' ve ', ' / '),
      context.t(project.platform).split(' · ').last,
    ];

    final name = Semantics(
      header: true,
      child: Pressable(
        to: project.path,
        builder: (context, hovered, _) => Align(
          alignment: Alignment.centerLeft,
          widthFactor: 1,
          child: mobile
              ? Text.rich(
                  TextSpan(children: [
                    TextSpan(text: '${project.name} '),
                    TextSpan(
                      text: context.t(project.descriptor),
                      style: type.descriptor.copyWith(color: colors.inkSubtle),
                    ),
                  ]),
                  style: type.heading.copyWith(decoration: hovered ? TextDecoration.underline : null),
                )
              : Text(project.name,
                  style: type.heading.copyWith(decoration: hovered ? TextDecoration.underline : null)),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number.toString().padLeft(2, '0'), style: note),
        const SizedBox(height: AppSpace.x2),
        name,
        if (!mobile) ...[
          const SizedBox(height: AppSpace.x1),
          Text(context.t(project.descriptor), style: type.descriptor.copyWith(color: colors.inkMuted)),
        ],
        const SizedBox(height: AppSpace.x3),
        Text(context.t(project.summary), style: type.bodySmall.copyWith(color: colors.inkMuted)),
        const SizedBox(height: AppSpace.x3),
        if (mobile)
          Text(meta.join(' · '), style: note)
        else
          for (final line in meta) Text(line, style: note),
        if (showLink)
          Pressable(
            to: project.path,
            builder: (context, _, __) => Align(
              alignment: Alignment.centerLeft,
              widthFactor: 1,
              child: Text('${context.t(Copy.viewProject)} →'.toUpperCase(), style: type.label.copyWith(color: colors.ink)),
            ),
          ),
      ],
    );
  }
}

/// The dark "View project →" pill that appears over the image on hover.
class _ViewPill extends StatelessWidget {
  final bool visible;

  const _ViewPill({required this.visible});

  @override
  Widget build(BuildContext context) {
    final duration = context.reduceMotion ? Duration.zero : const Duration(milliseconds: 300);
    return ExcludeSemantics(
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: duration,
        child: AnimatedSlide(
          offset: visible ? Offset.zero : const Offset(0, -0.3),
          duration: duration,
          curve: AppMotion.emphasized,
          child: DecoratedBox(
            decoration: BoxDecoration(color: context.colors.ink, borderRadius: AppRadius.pillAll),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.x4, vertical: 10),
              child: Text('${context.t(Copy.viewProject)} →'.toUpperCase(),
                  style: context.type.label.copyWith(color: context.colors.onInk)),
            ),
          ),
        ),
      ),
    );
  }
}

/// Keeps [child] at the top of the viewport (under the navigation) while
/// its box scrolls past, without leaving the box.
class _StickyTop extends StatefulWidget {
  final Widget child;

  const _StickyTop({required this.child});

  @override
  State<_StickyTop> createState() => _StickyTopState();
}

class _StickyTopState extends State<_StickyTop> {
  static const _offset = AppLayout.navHeight + AppSpace.x10;
  final _childKey = GlobalKey();
  final _shift = ValueNotifier(0.0);
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (position != _position) {
      _position?.removeListener(_update);
      _position = position?..addListener(_update);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _update());
  }

  void _update() {
    if (!mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    final child = _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || child == null || !box.hasSize || !child.hasSize || !box.attached) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final room = box.size.height - child.size.height;
    _shift.value = (_offset - top).clamp(0.0, room < 0 ? 0.0 : room);
  }

  @override
  void dispose() {
    _position?.removeListener(_update);
    _shift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _shift,
      builder: (context, shift, child) => Stack(
        clipBehavior: Clip.none,
        children: [Positioned(left: 0, right: 0, top: shift, child: child!)],
      ),
      child: KeyedSubtree(key: _childKey, child: widget.child),
    );
  }
}
