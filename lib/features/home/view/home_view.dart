import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/features/home/widget/capabilities_section.dart';
import 'package:portfolio/features/home/widget/contact_cta_section.dart';
import 'package:portfolio/features/home/widget/hero_section.dart';
import 'package:portfolio/features/home/widget/work_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();
  final _workKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Duration get _scrollDuration => context.reduceMotion ? Duration.zero : const Duration(milliseconds: 900);

  void _showWork() => Scrollable.ensureVisible(
        _workKey.currentContext!,
        duration: _scrollDuration,
        curve: AppMotion.emphasized,
      );

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
            HeroSection(onShowWork: _showWork),
            SizedBox(height: gap / 2),
            Padding(
              key: _workKey,
              padding: EdgeInsets.only(top: gap / 2),
              child: const WorkSection(),
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
