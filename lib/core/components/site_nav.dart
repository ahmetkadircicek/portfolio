import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/components/pressable.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:url_launcher/link.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// The home page's sections the navigation leads to.
enum HomeSection {
  work('/projects'),
  about('/about'),
  contact('/contact');

  /// Address that opens the home page at this section.
  final String path;
  const HomeSection(this.path);

  L get title => switch (this) {
        work => Copy.work,
        about => Copy.about,
        contact => Copy.contact,
      };
}

/// Every page's frame: the content scrolls under a sticky [SiteNav], which
/// draws its hairline once the page has moved.
class SitePage extends StatefulWidget {
  final Widget child;

  /// The page's own controller, e.g. to scroll to a section; one is made
  /// when null.
  final ScrollController? controller;

  /// Set on the home page so the links scroll instead of navigating.
  final void Function(HomeSection section)? onSection;

  const SitePage({super.key, required this.child, this.controller, this.onSection});

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  ScrollController? _own;
  ScrollController get _controller => widget.controller ?? (_own ??= ScrollController());
  final _scrolled = ValueNotifier(false);

  @override
  void dispose() {
    _own?.dispose();
    _scrolled.dispose();
    super.dispose();
  }

  bool _onScroll(ScrollNotification n) {
    if (n.depth == 0) _scrolled.value = n.metrics.pixels > 0;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.canvas,
      child: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            // Primary, so space, arrows and Page Up/Down scroll the page.
            child: PrimaryScrollController(
              controller: _controller,
              child: SingleChildScrollView(
                primary: true,
                padding: const EdgeInsets.only(top: AppLayout.navHeight),
                child: widget.child,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder(
              valueListenable: _scrolled,
              builder: (context, scrolled, _) => SiteNav(scrolled: scrolled, onSection: widget.onSection),
            ),
          ),
        ],
      ),
    );
  }
}

/// The global navigation: the name on the left; on wide screens the
/// sections and the language, on phones a Menu that opens them in large
/// serif type.
class SiteNav extends StatefulWidget {
  final bool scrolled;
  final void Function(HomeSection section)? onSection;

  const SiteNav({super.key, this.scrolled = false, this.onSection});

  @override
  State<SiteNav> createState() => _SiteNavState();
}

class _SiteNavState extends State<SiteNav> {
  bool _open = false;

  void _go(HomeSection section) {
    setState(() => _open = false);
    widget.onSection?.call(section);
  }

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final colors = context.colors;
    final type = context.type;
    final gutter = context.gutter;

    final bar = SizedBox(
      height: AppLayout.navHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: gutter),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppLayout.pageWidth - 2 * 48),
            child: Row(
              children: [
                Pressable(
                  to: '/',
                  builder: (context, hovered, _) => Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 1,
                    child: Text(Profile.name, style: type.link.copyWith(fontSize: 15)),
                  ),
                ),
                const Spacer(),
                if (mobile)
                  Pressable(
                    isButton: true,
                    onTap: () => setState(() => _open = !_open),
                    builder: (context, _, _) => Center(
                      widthFactor: 1,
                      child: Text(context.upper(context.t(_open ? Copy.close : Copy.menu)),
                          style: type.label.copyWith(color: colors.ink)),
                    ),
                  )
                else ...[
                  for (final section in HomeSection.values) ...[
                    _NavLink(section: section, onSection: widget.onSection == null ? null : _go),
                    const SizedBox(width: AppSpace.x8),
                  ],
                  const _LanguageToggle(),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.canvas.withValues(alpha: 0.97),
        border: Border(
          bottom: BorderSide(color: widget.scrolled || _open ? colors.line : colors.line.withValues(alpha: 0)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          bar,
          AnimatedSize(
            duration: context.reduceMotion ? Duration.zero : AppMotion.base,
            curve: AppMotion.standard,
            alignment: Alignment.topCenter,
            child: mobile && _open ? _Menu(onSection: widget.onSection == null ? null : _go) : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final HomeSection section;
  final void Function(HomeSection section)? onSection;

  const _NavLink({required this.section, this.onSection});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Pressable(
      to: onSection == null ? section.path : null,
      onTap: onSection == null ? null : () => onSection!(section),
      builder: (context, hovered, _) => Center(
        widthFactor: 1,
        child: Text(
          context.t(section.title),
          style: context.type.link.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: hovered ? colors.ink : colors.inkMuted,
          ),
        ),
      ),
    );
  }
}

/// Shows the other language and switches to it.
class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle();

  @override
  Widget build(BuildContext context) {
    final current = context.language;
    final other = AppLanguage.values.firstWhere((l) => l != current);
    // The same page in the other language, as a real link.
    final uri = GoRouter.maybeOf(context)?.routerDelegate.currentConfiguration.uri ?? Uri(path: '/');
    final (_, path) = AppLanguage.split(uri);
    return Link(
      uri: Uri.parse(other.localize(path)),
      builder: (context, follow) => Pressable(
        isButton: true,
        semanticLabel: other.nativeName,
        onTap: () {
          LanguageManager.choose(other);
          follow?.call();
        },
        builder: (context, hovered, _) => Center(
          widthFactor: 1,
          child: Text(other.short,
              style: context.type.label.copyWith(color: hovered ? context.colors.ink : context.colors.inkMuted)),
        ),
      ),
    );
  }
}

/// The phone menu: the sections in large serif type, then the CV and the
/// language.
class _Menu extends StatelessWidget {
  final void Function(HomeSection section)? onSection;

  const _Menu({this.onSection});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final link = type.display.copyWith(fontSize: 40, height: 1);
    return Padding(
      padding: EdgeInsets.fromLTRB(context.gutter, AppSpace.x4, context.gutter, AppSpace.x6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final section in HomeSection.values)
            DecoratedBox(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.line))),
              child: Pressable(
                to: onSection == null ? section.path : null,
                onTap: onSection == null ? null : () => onSection!(section),
                builder: (context, _, _) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpace.x2),
                  child: Text(context.t(section.title), style: link),
                ),
              ),
            ),
          const SizedBox(height: AppSpace.x4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Pressable(
                to: Profile.cv,
                builder: (context, _, _) => Center(
                  widthFactor: 1,
                  child: Text(context.upper('${context.t(Copy.cv)} ↗'), style: type.label.copyWith(color: colors.ink)),
                ),
              ),
              const _LanguageToggle(),
            ],
          ),
        ],
      ),
    );
  }
}
