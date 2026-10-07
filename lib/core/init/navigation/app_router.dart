import 'package:portfolio/core/data/collections.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/contact_me/view/contact_form_view.dart';
import 'package:portfolio/features/home/view/home_view.dart';
import 'package:portfolio/features/not_found/not_found_view.dart';
import 'package:portfolio/features/entry/view/entry_view.dart';
import 'package:portfolio/features/splash/splash_view.dart';

/// Every page of the site:
///
/// | Path | Page |
/// | --- | --- |
/// | `/` | splash, then `/home` |
/// | `/home` | landing page |
/// | `/<collection>` | landing page opened at that section, e.g. `/projects` |
/// | `/<collection>/:slug` | one entry's page, e.g. `/experience/huawei` |
/// | `/contact` | contact form |
class AppRouter {
  AppRouter._();

  static const siteName = 'Ahmet Kadir Çiçek';

  static const homeTitle = '$siteName — Mobile Developer';

  /// Browser tab title of the page at [uri]. Set once above the router, so
  /// a page that is fading out can never write its own title last. A
  /// collection path is the home page opened at a section, so it keeps the
  /// home title.
  static String titleFor(Uri uri) {
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    String page(String name) => '$name — $siteName';
    if (segments.isEmpty || uri.path == '/home') return homeTitle;
    if (uri.path == '/contact') return page('Contact');
    for (final collection in collections) {
      if (segments.first != collection.id) continue;
      if (segments.length == 1) return homeTitle;
      final entry = collection.bySlug(segments[1]);
      if (segments.length == 2 && entry != null) return page(entry.title);
    }
    return page('Page not found');
  }

  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const NotFoundView(),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeView(),
      ),
      // `/<collection>` opens the home page at the collection's section,
      // `/<collection>/<slug>` the entry's page; unknown slugs go back to the
      // section.
      for (final collection in collections)
        GoRoute(
          path: collection.path,
          builder: (context, state) => HomeView(startAt: collection.id),
          routes: [
            GoRoute(
              path: ':slug',
              redirect: (context, state) =>
                  collection.bySlug(state.pathParameters['slug']) == null ? collection.path : null,
              builder: (context, state) {
                final entry = collection.bySlug(state.pathParameters['slug'])!;
                return EntryView(collection: collection, entry: entry);
              },
            ),
          ],
        ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => const ContactFormView(),
      ),
    ],
  );
}
