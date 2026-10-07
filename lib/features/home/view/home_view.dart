import 'package:flutter/material.dart';
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
  final _keys = {for (final c in collections) c.id: GlobalKey()};
  late final _open = {for (final c in collections) c.id: ValueNotifier(c.id == widget.startAt)};

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _scrollController.dispose();
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
    return Material(
      color: AppColors.canvas,
      child: SingleChildScrollView(
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
      ),
    );
  }
}
