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

  /// Forgets the remembered scroll position and open sections.
  @visibleForTesting
  static void forgetPosition() {
    _HomeViewState._savedOffset = null;
    _HomeViewState._savedOpen.clear();
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();

  /// Where the visitor was and which sections were open, kept for the
  /// session so coming back from an entry lands in the same place.
  static double? _savedOffset;
  static final _savedOpen = <String, bool>{};

  /// The compact top bar. It slides in as the hero leaves the screen, stays
  /// for about a screen of further scrolling down, then tucks away until the
  /// visitor scrolls up again.
  final _barVisible = ValueNotifier(false);
  double _lastOffset = 0;
  double _shownAt = 0;
  final _heroKey = GlobalKey();

  /// False once the hero has scrolled away: its looping shape then stops
  /// decoding frames instead of burning the main thread off-screen.
  final _heroVisible = ValueNotifier(true);
  final _keys = {for (final c in collections) c.id: GlobalKey()};
  late final _open = {
    for (final c in collections) c.id: ValueNotifier(_savedOpen[c.id] ?? c.id == widget.startAt),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    for (final MapEntry(:key, :value) in _open.entries) {
      value.addListener(() => _savedOpen[key] = value.value);
    }
    final saved = _savedOffset;
    final start = widget.startAt;
    if (saved != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _restore(saved));
    } else if (start != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _jumpTo(start));
    }
  }

  /// Returns to [offset] once the page is tall enough to hold it.
  void _restore(double offset, [int attempt = 0]) {
    if (!mounted || !_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (!position.hasContentDimensions) {
      if (attempt < 30) {
        WidgetsBinding.instance
          ..addPostFrameCallback((_) => _restore(offset, attempt + 1))
          ..scheduleFrame();
      }
      return;
    }
    if (position.maxScrollExtent >= offset || attempt >= 30) {
      _lastOffset = offset.clamp(0, position.maxScrollExtent);
      _shownAt = _lastOffset;
      _scrollController.jumpTo(_lastOffset);
    } else {
      WidgetsBinding.instance
        ..addPostFrameCallback((_) => _restore(offset, attempt + 1))
        ..scheduleFrame();
    }
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
    _savedOffset = offset;
    final heroBox = _heroKey.currentContext?.findRenderObject() as RenderBox?;
    _heroVisible.value = offset < (heroBox?.size.height ?? double.infinity);
    final delta = offset - _lastOffset;
    if (delta.abs() < 6) return;
    _lastOffset = offset;

    final heroHeight = heroBox?.size.height ?? MediaQuery.sizeOf(context).height;
    final line = heroHeight - 80;
    if (offset < line) {
      _barVisible.value = false;
    } else if (delta < 0) {
      // Scrolling back up: always offer the bar.
      _barVisible.value = true;
      _shownAt = offset;
    } else if (!_barVisible.value && offset - delta < line) {
      // Just passed the hero: bring the bar in.
      _barVisible.value = true;
      _shownAt = offset;
    } else if (_barVisible.value && offset - _shownAt > MediaQuery.sizeOf(context).height) {
      // Still going down a screen later: get out of the way.
      _barVisible.value = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _barVisible.dispose();
    _heroVisible.dispose();
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
          // Each section is its own layer, so scrolling moves painted layers
          // instead of repainting the whole page every frame.
          RepaintBoundary(
            child: ValueListenableBuilder(
              valueListenable: _heroVisible,
              builder: (context, visible, hero) => TickerMode(enabled: visible, child: hero!),
              child: HeroSection(key: _heroKey, onShowWork: () => _show(collections.first.id)),
            ),
          ),
          for (final c in collections)
            Padding(
              key: _keys[c.id],
              padding: EdgeInsets.only(top: gap),
              child: RepaintBoundary(child: CollectionSection(collection: c, open: _open[c.id]!)),
            ),
          SizedBox(height: gap),
          const RepaintBoundary(child: CapabilitiesSection()),
          SizedBox(height: gap),
          RepaintBoundary(child: ContactCtaSection(onBackToTop: _backToTop)),
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

/// The site header on a near-opaque strip with a hairline below. No blur:
/// a backdrop blur re-renders everything under it on each scroll frame.
class _TopBar extends StatelessWidget {
  final VoidCallback onHome;

  const _TopBar({required this.onHome});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.canvas.withValues(alpha: 0.97),
        border: Border(bottom: BorderSide(color: context.colors.line)),
      ),
      child: SiteHeader(onHome: onHome, compact: true),
    );
  }
}
