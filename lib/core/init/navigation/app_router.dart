import 'package:go_router/go_router.dart';
import 'package:portfolio/core/components/site_nav.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/features/site/home_page.dart';
import 'package:portfolio/features/site/not_found_page.dart';
import 'package:portfolio/features/site/project_page.dart';

/// Every page of the site:
///
/// | Path | Page |
/// | --- | --- |
/// | `/` | home page |
/// | `/projects`, `/about`, `/contact` | home page opened at that section |
/// | `/projects/:slug` | a project's case study, e.g. `/projects/tunes` |
///
/// Older addresses (`/home`, `/experience/…`) lead to their place on the
/// home page; anything else is the not found page.
class AppRouter {
  AppRouter._();

  static const siteName = 'Ahmet Kadir Çiçek';

  static const homeTitle = '$siteName — Mobile Developer';

  static String homeTitleIn(AppLanguage language) => '$siteName — ${S.pageTitleRole.of(language)}';

  /// Browser tab title of the page at [uri]. Set once above the router, so
  /// a page that is fading out can never write its own title last.
  static String titleFor(Uri uri, [AppLanguage language = AppLanguage.en]) {
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    String page(String name) => '$name — $siteName';
    if (segments.isEmpty || segments.length == 1 && _sections.contains(segments.first)) {
      return homeTitleIn(language);
    }
    if (segments.length == 2 && segments.first == 'projects') {
      final project = projectBySlug(segments[1]);
      if (project != null) return page(project.name);
    }
    return page(S.notFound.of(language));
  }

  static const _sections = {'home', 'projects', 'about', 'contact', 'experience'};

  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(path: '/home', redirect: (context, state) => '/'),
      GoRoute(path: '/experience', redirect: (context, state) => HomeSection.about.path),
      GoRoute(path: '/experience/:slug', redirect: (context, state) => HomeSection.about.path),
      GoRoute(
        path: HomeSection.work.path,
        builder: (context, state) => const HomePage(startAt: HomeSection.work),
        routes: [
          GoRoute(
            path: ':slug',
            redirect: (context, state) =>
                projectBySlug(state.pathParameters['slug']) == null ? HomeSection.work.path : null,
            builder: (context, state) => ProjectPage(project: projectBySlug(state.pathParameters['slug'])!),
          ),
        ],
      ),
      GoRoute(path: HomeSection.about.path, builder: (context, state) => const HomePage(startAt: HomeSection.about)),
      GoRoute(
        path: HomeSection.contact.path,
        builder: (context, state) => const HomePage(startAt: HomeSection.contact),
      ),
    ],
  );
}
