import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/core/components/site_header.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/features/home/widget/capabilities_section.dart';
import 'package:portfolio/features/home/widget/collection_section.dart';
import 'package:portfolio/features/home/widget/contact_cta_section.dart';
import 'package:portfolio/features/home/widget/hero_section.dart';

class HomeView extends StatefulWidget {
  /// Id of the collection to open and start scrolled to; used by the
  /// `/<collection>` routes, where entry pages lead back to.
  final String? startAt;

  const HomeView({super.key, this.startAt});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();

  /// The compact top bar: hidden over the hero, then shown while scrolling
  /// up and tucked away while scrolling down, as on Apple's sites.
  final _barVisible = ValueNotifier(false);
  double _lastOffset = 0;
  final _keys = {for (final c in collections) c.id: GlobalKey()};
  late final _open = {for (final c in collections) c.id: ValueNotifier(c.id == widget.startAt)};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final start = widget.startAt;
    if (start != null) WidgetsBinding.instance.addPostFrameCallback((_) => _jumpTo(start));
  }

  /// Starts the page at a section. During a page transition the section may
  /// not be laid out yet; then it tries again on the next frames.
  void _jumpTo(String id, [int attempt = 0]) {
    if (!mounted) return;
    final box = _keys[id]?.currentContext?.findRenderObject();
    if (box is RenderBox && box.hasSize) {
      Scrollable.ensureVisible(_keys[id]!.currentContext!);
    } else if (attempt < 30) {
      WidgetsBinding.instance
        ..addPostFrameCallback((_) => _jumpTo(id, attempt + 1))
        ..scheduleFrame();
    }
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final delta = offset - _lastOffset;
    if (offset < MediaQuery.sizeOf(context).height * 0.6) {
      _barVisible.value = false;
    } else if (delta.abs() > 6) {
      _barVisible.value = delta < 0;
    } else {
      return;
    }
    _lastOffset = offset;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _barVisible.dispose();
    for (final notifier in _open.values) {
      notifier.dispose();
    }
    super.dispose();
  }

  Duration get _scrollDuration => context.reduceMotion ? Duration.zero : const Duration(milliseconds: 900);

  void _show(String id) {
    _open[id]!.value = true;
    Scrollable.ensureVisible(_keys[id]!.currentContext!, duration: _scrollDuration, curve: AppMotion.emphasized);
  }

  void _backToTop() => _scrollController.animateTo(0, duration: _scrollDuration, curve: AppMotion.emphasized);

  @override
  Widget build(BuildContext context) {
    final gap = context.sectionGap;
    final page = SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeroSection(onShowWork: () => _show(collections.first.id)),
          for (final c in collections)
            Padding(
              key: _keys[c.id],
              padding: EdgeInsets.only(top: gap),
              child: CollectionSection(collection: c, open: _open[c.id]!),
            ),
          SizedBox(height: gap),
          const CapabilitiesSection(),
          SizedBox(height: gap),
          ContactCtaSection(onBackToTop: _backToTop),
        ],
      ),
    );

    return Material(
      color: context.colors.canvas,
      child: Stack(
        children: [
          page,
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder(
              valueListenable: _barVisible,
              builder: (context, visible, bar) => AnimatedSlide(
                offset: visible ? Offset.zero : const Offset(0, -1),
                duration: AppMotion.base,
                curve: AppMotion.standard,
                child: IgnorePointer(ignoring: !visible, child: bar),
              ),
              child: _TopBar(onHome: _backToTop),
            ),
          ),
        ],
      ),
    );
  }
}

/// The site header over a frosted strip of the page, with a hairline below.
class _TopBar extends StatelessWidget {
  final VoidCallback onHome;

  const _TopBar({required this.onHome});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.canvas.withValues(alpha: 0.8),
            border: Border(bottom: BorderSide(color: context.colors.line)),
          ),
          child: SiteHeader(onHome: onHome, compact: true),
        ),
      ),
    );
  }
}
