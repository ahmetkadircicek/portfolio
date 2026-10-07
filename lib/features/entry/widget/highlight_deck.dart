import 'package:flutter/material.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/components/asset_image_widget.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/components/pill.dart';
import 'package:portfolio/core/data/entry.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// An entry's highlights as a stack of cards: the front one shows in full,
/// the next two peek out above it. Tapping the front card brings the next
/// one forward; the dots below jump to any card.
class HighlightDeck extends StatefulWidget {
  final List<Highlight> slides;

  const HighlightDeck({super.key, required this.slides});

  @override
  State<HighlightDeck> createState() => _HighlightDeckState();
}

class _HighlightDeckState extends State<HighlightDeck> {
  int _index = 0;
  bool _hovering = false;

  int get _count => widget.slides.length;
  Highlight _at(int offset) => widget.slides[(_index + offset) % _count];

  void _show(int index) {
    setState(() => _index = index % _count);
    _warmUp();
  }

  /// Decodes the images one step ahead and one behind, so paging never waits
  /// on a decode. The front and the two cards behind it are already on screen.
  void _warmUp() {
    if (_count < 4) return;
    for (final offset in [3, _count - 1]) {
      precacheImage(AssetImage(_at(offset).image), context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _warmUp();
  }

  @override
  Widget build(BuildContext context) {
    if (_count == 0) return const SizedBox.shrink();
    final mobile = context.isMobile;
    final peek = mobile ? AppSpace.x4 : AppSpace.x6;
    final artHeight = mobile ? 260.0 : 400.0;
    final frontHeight = artHeight + (mobile ? 120.0 : 140.0);
    final duration = context.reduceMotion ? Duration.zero : AppMotion.base;

    // The cards behind are blank and take no project colors until they come
    // to the front; each step back is a shade lighter.
    Widget back(double scale, double top, double fade) => Positioned(
          top: top,
          left: 0,
          right: 0,
          height: frontHeight,
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: _Card(child: ColoredBox(color: Color.lerp(context.colors.surface, context.colors.canvas, fade)!)),
          ),
        );

    final slide = _at(0);
    final front = Semantics(
      button: true,
      label: context.t(S.nextImage),
      child: HoverDetector(
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: () => _show(_index + 1),
            child: AnimatedSlide(
              offset: Offset(0, _hovering ? -6 / frontHeight : 0),
              duration: duration,
              curve: AppMotion.standard,
              child: _Card(
                shadow: true,
                child: AnimatedSwitcher(
                  duration: duration,
                  child: _FrontContent(
                    key: ValueKey(_index),
                    slide: slide,
                    counter: '${_index + 1} / $_count',
                    artHeight: artHeight,
                    hovering: _hovering,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpace.x2,
      children: [
        SizedBox(
          height: frontHeight + peek * 2,
          child: Stack(
            children: [
              if (_count > 2) back(0.84, 0, 0.7),
              if (_count > 1) back(0.92, peek, 0.35),
              Positioned(top: peek * 2, left: 0, right: 0, height: frontHeight, child: front),
            ],
          ),
        ),
        if (_count > 1)
          // Many slides: the dots shrink to fit instead of overflowing.
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < _count; i++)
                  Semantics(
                    button: true,
                    selected: i == _index,
                    label: context.t(S.show(context.t(widget.slides[i].title))),
                    child: HoverDetector(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _show(i),
                        child: SizedBox(
                          width: 32,
                          height: 44,
                          child: Center(
                            child: AnimatedContainer(
                              duration: duration,
                              curve: AppMotion.emphasized,
                              width: i == _index ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: i == _index ? context.colors.ink : context.colors.ink.withValues(alpha: 0.2),
                                borderRadius: AppRadius.pillAll,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final bool shadow;

  const _Card({required this.child, this.shadow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.canvas,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: context.colors.line),
        boxShadow: shadow ? AppShadow.soft : null,
      ),
      child: child,
    );
  }
}

class _FrontContent extends StatelessWidget {
  final Highlight slide;
  final String counter;
  final double artHeight;
  final bool hovering;

  const _FrontContent({
    super.key,
    required this.slide,
    required this.counter,
    required this.artHeight,
    required this.hovering,
  });

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: artHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: slide.colors.isEmpty ? [context.colors.surface, context.colors.surfaceHover] : slide.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: _ZoomArt(slide: slide, counter: counter),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.x6, vertical: AppSpace.x4),
            child: Row(
              spacing: AppSpace.x4,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpace.x1,
                    children: [
                      Text(context.t(slide.title), style: text.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(
                        context.t(slide.description),
                        style: text.bodySmall.copyWith(color: context.colors.inkMuted),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: AppMotion.fast,
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: hovering ? context.colors.ink : context.colors.surface,
                    shape: BoxShape.circle,
                  ),
                  child:
                      Icon(Icons.arrow_forward, size: 18, color: hovering ? context.colors.onInk : context.colors.ink),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// The front card's image. On desktop it zooms in on hover, onto the part
/// under the mouse, and follows the mouse; the labels step aside meanwhile.
class _ZoomArt extends StatefulWidget {
  final Highlight slide;
  final String counter;

  const _ZoomArt({required this.slide, required this.counter});

  @override
  State<_ZoomArt> createState() => _ZoomArtState();
}

class _ZoomArtState extends State<_ZoomArt> {
  bool _zoomed = false;
  Alignment _focus = Alignment.center;

  void _follow(Offset position) {
    final size = context.size;
    if (size == null || size.isEmpty) return;
    setState(() {
      _zoomed = true;
      _focus = Alignment(
        (position.dx / size.width * 2 - 1).clamp(-1.0, 1.0),
        (position.dy / size.height * 2 - 1).clamp(-1.0, 1.0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final interactive = context.isDesktop && !context.reduceMotion;
    final zoomed = interactive && _zoomed;
    Widget pill(String text) => AnimatedOpacity(
          opacity: zoomed ? 0 : 1,
          duration: AppMotion.base,
          curve: AppMotion.standard,
          child: Pill(text, style: PillStyle.onImage),
        );

    return MouseRegion(
      onEnter: interactive ? (event) => _follow(event.localPosition) : null,
      onHover: interactive ? (event) => _follow(event.localPosition) : null,
      onExit: interactive ? (_) => setState(() => _zoomed = false) : null,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpace.x6),
              child: AnimatedScale(
                scale: zoomed ? 2.5 : 1,
                alignment: _focus,
                duration: AppMotion.slow,
                curve: AppMotion.emphasized,
                child: AssetImageWidget(widget.slide.image,
                    fit: BoxFit.contain, semanticLabel: context.t(widget.slide.title)),
              ),
            ),
            Positioned(top: AppSpace.x4, left: AppSpace.x4, child: pill(context.t(widget.slide.label))),
            Positioned(top: AppSpace.x4, right: AppSpace.x4, child: pill(widget.counter)),
          ],
        ),
      ),
    );
  }
}
