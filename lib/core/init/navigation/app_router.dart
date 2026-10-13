import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/components/site_nav.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/features/site/home_page.dart';
import 'package:portfolio/features/site/not_found_page.dart';
import 'package:portfolio/features/site/project_page.dart';

/// Every page of the site, in English at the root and in Turkish under
/// `/tr` (`/tr/projects/tunes`):
///
/// | Path | Page |
/// | --- | --- |
/// | `/` | home page |
/// | `/projects`, `/about`, `/contact` | home page opened at that section |
/// | `/projects/:slug` | a project's case study, e.g. `/projects/tunes` |
///
/// Older addresses lead to their place: `/home` to the home page,
/// `/experience/…` to about, and the German pages under `/de` to the English
/// ones. Anything else is the not found page.
class AppRouter {
  AppRouter._();

  static const siteName = Profile.name;

  static const homeTitle = '$siteName — Mobile Developer';

  static String homeTitleIn(AppLanguage language) => '$siteName — ${Copy.pageTitleRole.of(language)}';

  /// Browser tab title of the page at [uri], in its language. Set once above
  /// the router, so a page that is fading out can never write its own title
  /// last.
  static String titleFor(Uri uri) {
    final (language, path) = AppLanguage.split(uri);
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();
    String page(String name) => '$name — $siteName';
    if (segments.isEmpty || segments.length == 1 && _sections.contains(segments.first)) {
      return homeTitleIn(language);
    }
    if (segments.length == 2 && segments.first == 'projects') {
      final project = projectBySlug(segments[1]);
      if (project != null) return page(project.name);
    }
    return page(Copy.notFound.of(language));
  }

  static const _sections = {'home', 'projects', 'about', 'contact', 'experience'};

  /// Whether the site has not opened a page yet; the remembered language is
  /// applied only then.
  static var _opening = true;

  /// Lets the next navigation count as the site opening.
  @visibleForTesting
  static void reopen() => _opening = true;

  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const NotFoundPage(),
    redirect: (context, state) {
      final opening = _opening;
      _opening = false;
      final segments = state.uri.pathSegments.where((s) => s.isNotEmpty).toList();
      if (segments.firstOrNull == 'de') return '/${segments.skip(1).join('/')}';
      final saved = LanguageManager.saved;
      if (opening && state.uri.path == '/' && saved != null && saved != AppLanguage.en) return saved.prefix;
      return null;
    },
    routes: [
      for (final language in AppLanguage.values) ...[
        GoRoute(path: language.localize('/home'), redirect: (_, _) => language.localize('/')),
        GoRoute(path: language.localize('/experience'), redirect: (_, _) => language.localize(HomeSection.about.path)),
        GoRoute(
          path: language.localize('/experience/:slug'),
          redirect: (_, _) => language.localize(HomeSection.about.path),
        ),
        GoRoute(
          path: language.localize('/'),
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: HomeSection.work.path.substring(1),
              builder: (context, state) => const HomePage(startAt: HomeSection.work),
              routes: [
                GoRoute(
                  path: ':slug',
                  redirect: (context, state) => projectBySlug(state.pathParameters['slug']) == null
                      ? language.localize(HomeSection.work.path)
                      : null,
                  builder: (context, state) => ProjectPage(project: projectBySlug(state.pathParameters['slug'])!),
                ),
              ],
            ),
            for (final section in [HomeSection.about, HomeSection.contact])
              GoRoute(
                path: section.path.substring(1),
                builder: (context, state) => HomePage(startAt: section),
              ),
          ],
        ),
      ],
    ],
  )..routerDelegate.addListener(() => LanguageManager.follow(router.routerDelegate.currentConfiguration.uri));
}
