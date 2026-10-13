import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio/core/components/grid.dart';
import 'package:portfolio/core/components/pressable.dart';
import 'package:portfolio/core/components/site_nav.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/features/site/about_section.dart';
import 'package:portfolio/features/site/parts.dart';
import 'package:portfolio/features/site/work_list.dart';

/// The redesigned home page: the quote over the shape, the intro, the work,
/// about and the contact band. [startAt] opens it scrolled to a section.
class HomePage extends StatefulWidget {
  final HomeSection? startAt;

  const HomePage({super.key, this.startAt});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ScrollController();
  final _keys = {for (final s in HomeSection.values) s: GlobalKey()};

  @override
  void initState() {
    super.initState();
    final start = widget.startAt;
    if (start != null) WidgetsBinding.instance.addPostFrameCallback((_) => _show(start, animate: false));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show(HomeSection section, {bool animate = true}) {
    // Under a project page this page is built but not laid out.
    if (!mounted || ModalRoute.isCurrentOf(context) == false) return;
    final box = _keys[section]?.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize || !_controller.hasClients) return;
    final position = _controller.position;
    final target = (position.pixels + box.localToGlobal(Offset.zero).dy - AppLayout.navHeight)
        .clamp(0.0, position.maxScrollExtent);
    if (!animate || context.reduceMotion) {
      _controller.jumpTo(target);
    } else {
      _controller.animateTo(target, duration: const Duration(milliseconds: 900), curve: AppMotion.emphasized);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gap = context.isMobile ? AppSpace.x24 + AppSpace.x4 : AppSpace.x40;
    return SitePage(
      controller: _controller,
      onSection: _show,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RepaintBoundary(child: _Hero(controller: _controller, onDown: () => _show(HomeSection.work))),
          SizedBox(height: context.isMobile ? AppSpace.x18 : AppSpace.x30),
          const _Intro(),
          SizedBox(key: _keys[HomeSection.work], height: gap),
          const RepaintBoundary(child: WorkList()),
          SizedBox(key: _keys[HomeSection.about], height: gap),
          const RepaintBoundary(child: AboutSection()),
          SizedBox(height: gap),
          KeyedSubtree(
            key: _keys[HomeSection.contact],
            child: ContactBand(
              onTop: () => _controller.animateTo(0,
                  duration: context.reduceMotion ? const Duration(milliseconds: 1) : const Duration(milliseconds: 900),
                  curve: AppMotion.emphasized),
            ),
          ),
        ],
      ),
    );
  }
}

/// The first screen: Dieter Rams' words over Ahmet's shape, the arrow down
/// and the facts row on the bottom edge.
class _Hero extends StatelessWidget {
  final ScrollController controller;
  final VoidCallback onDown;

  const _Hero({required this.controller, required this.onDown});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final height = math.max(context.height - AppLayout.navHeight, mobile ? 640.0 : 680.0);
    final shape = mobile ? 340.0 : 640.0;
    final colors = context.colors;

    return SizedBox(
      height: height,
      child: PageColumn(
        child: Stack(
          children: [
            // The shape drifts a little slower than the page.
            Positioned.fill(
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  final offset = controller.hasClients && !context.reduceMotion ? controller.offset * 0.3 : 0.0;
                  return Transform.translate(offset: Offset(0, offset), child: child);
                },
                child: Align(
                  alignment: const Alignment(0, -0.25),
                  child: ExcludeSemantics(
                    child: Image.asset(
                      'assets/images/common/shape.webp',
                      width: shape,
                      height: shape,
                      opacity: const AlwaysStoppedAnimation(0.35),
                      gaplessPlayback: true,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: mobile ? 170 : 120,
              child: const Center(child: _Quote()),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Pressable(
                    onTap: onDown,
                    semanticLabel: context.t(Copy.toWork),
                    isButton: true,
                    builder: (context, hovered, _) => Center(
                      child: Icon(Icons.south, size: 22, color: hovered ? colors.ink : colors.inkSubtle),
                    ),
                  ),
                  const SizedBox(height: AppSpace.x2),
                  const _Facts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Less, but better." arriving word by word, and who said it.
class _Quote extends StatefulWidget {
  const _Quote();

  @override
  State<_Quote> createState() => _QuoteState();
}

class _QuoteState extends State<_Quote> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      _controller.value = 1;
    } else if (!_controller.isAnimating && _controller.value == 0) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _rise(double start, Widget child) {
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Interval(start, math.min(start + 0.375, 1), curve: AppMotion.emphasized),
    );
    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(curve),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    const starts = [0.125, 0.27, 0.42];
    return Semantics(
      label: '${Profile.quote.join(' ')} ${Profile.quoteBy}',
      excludeSemantics: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final (i, word) in Profile.quote.indexed) ...[
                  if (i > 0) Text(' ', style: type.quote),
                  _rise(starts[i], Text(word, style: type.quote)),
                ],
              ],
            ),
          ),
          SizedBox(height: context.isMobile ? AppSpace.x4 : AppSpace.x7),
          _rise(0.625, Text(Profile.quoteBy, style: type.bodySmall.copyWith(color: context.colors.inkSubtle))),
        ],
      ),
    );
  }
}

/// Role, base and current workplace on the hero's bottom edge.
class _Facts extends StatelessWidget {
  const _Facts();

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final mobile = context.isMobile;
    final value = type.bodySmall.copyWith(height: 1.4);

    return DecoratedBox(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.line))),
      child: Padding(
        padding: EdgeInsets.only(top: mobile ? AppSpace.x3 : AppSpace.x5, bottom: mobile ? AppSpace.x6 : AppSpace.x8),
        child: mobile
            ? Column(
                children: [
                  for (final (label, text) in Profile.facts)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          SizedBox(width: 96, child: MonoLabel(context.t(label))),
                          Expanded(child: Text(context.t(text), style: value)),
                        ],
                      ),
                    ),
                ],
              )
            : Row(
                children: [
                  for (final (i, (label, text)) in Profile.facts.indexed)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: switch (i) {
                          0 => CrossAxisAlignment.start,
                          1 => CrossAxisAlignment.center,
                          _ => CrossAxisAlignment.end,
                        },
                        children: [
                          MonoLabel(context.t(label)),
                          const SizedBox(height: 6),
                          Text(context.t(text), style: value),
                        ],
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

/// The intro on the grid: the first sentence in ink, the rest muted.
class _Intro extends StatelessWidget {
  const _Intro();

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final (first, rest) = Profile.intro;
    final text = Text.rich(
      TextSpan(children: [
        TextSpan(text: '${context.t(first)} '),
        TextSpan(text: context.t(rest), style: TextStyle(color: context.colors.inkSubtle)),
      ]),
      style: type.intro,
    );
    return PageColumn(
      child: context.isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [MonoLabel(context.t(Copy.intro)), const SizedBox(height: AppSpace.x3), text],
            )
          : GridRow(cells: [
              GridCell(start: 1, span: 3, child: Padding(padding: const EdgeInsets.only(top: 12), child: MonoLabel(context.t(Copy.intro)))),
              GridCell(start: 4, span: 8, child: text),
            ]),
    );
  }
}
