import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/contact_me/view/contact_form_view.dart';
import 'package:portfolio/features/home/view/home_view.dart';
import 'package:portfolio/features/not_found/not_found_view.dart';
import 'package:portfolio/features/entry/view/entry_view.dart';

/// Every page of the site, in English at the root and in the other
/// languages under their prefix (`/tr/projects`, `/de/contact`):
///
/// | Path | Page |
/// | --- | --- |
/// | `/` | landing page (`/home` leads here) |
/// | `/<collection>` | landing page opened at that section, e.g. `/projects` |
/// | `/<collection>/:slug` | one entry's page, e.g. `/experience/huawei` |
/// | `/contact` | contact form |
class AppRouter {
  AppRouter._();

  static const siteName = 'Ahmet Kadir Çiçek';

  static const homeTitle = '$siteName — Mobile Developer';

  static String homeTitleIn(AppLanguage language) => '$siteName — ${S.pageTitleRole.of(language)}';

  /// Browser tab title of the page at [uri], in its language. Set once above
  /// the router, so a page that is fading out can never write its own title
  /// last. A collection path is the home page opened at a section, so it
  /// keeps the home title.
  static String titleFor(Uri uri) {
    final (language, path) = AppLanguage.split(uri);
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();
    String page(String name) => '$name — $siteName';
    final home = homeTitleIn(language);
    if (segments.isEmpty) return home;
    if (path == '/contact') return page(S.contact.of(language));
    for (final collection in collections) {
      if (segments.first != collection.id) continue;
      if (segments.length == 1) return home;
      final entry = collection.bySlug(segments[1]);
      if (segments.length == 2 && entry != null) return page(entry.title.of(language));
    }
    return page(S.notFound.of(language));
  }

  /// Whether the site has not opened a page yet; the remembered language is
  /// applied only then.
  static var _opening = true;

  /// Lets the next navigation count as the site opening.
  @visibleForTesting
  static void reopen() => _opening = true;

  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const NotFoundView(),
    redirect: (context, state) {
      final opening = _opening;
      _opening = false;
      final saved = LanguageManager.saved;
      if (opening && state.uri.path == '/' && saved != null && saved != AppLanguage.en) return saved.prefix;
      return null;
    },
    routes: [
      // The old address of the landing page, still in links and bookmarks.
      GoRoute(path: '/home', redirect: (_, _) => '/'),
      for (final language in AppLanguage.values)
        GoRoute(
          path: language.localize('/'),
          builder: (context, state) => const HomeView(),
          routes: [
            // `<collection>` opens the home page at the collection's section,
            // `<collection>/<slug>` the entry's page; unknown slugs go back to
            // the section.
            for (final collection in collections)
              GoRoute(
                path: collection.id,
                builder: (context, state) => HomeView(startAt: collection.id),
                routes: [
                  GoRoute(
                    path: ':slug',
                    redirect: (context, state) => collection.bySlug(state.pathParameters['slug']) == null
                        ? language.localize(collection.path)
                        : null,
                    builder: (context, state) {
                      final entry = collection.bySlug(state.pathParameters['slug'])!;
                      return EntryView(collection: collection, entry: entry);
                    },
                  ),
                ],
              ),
            GoRoute(
              path: 'contact',
              builder: (context, state) => const ContactFormView(),
            ),
          ],
        ),
    ],
  )..routerDelegate.addListener(() => LanguageManager.follow(router.routerDelegate.currentConfiguration.uri));
}
