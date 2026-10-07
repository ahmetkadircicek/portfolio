import 'package:flutter/widgets.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/features/contact_me/view/contact_form_view.dart';
import 'package:portfolio/features/home/view/home_view.dart';
import 'package:portfolio/features/not_found/not_found_view.dart';
import 'package:portfolio/features/policies/desktop_tunes_gdpr_view.dart';
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
/// | `/tunes/gdpr` | Desktop Tunes privacy policy |
class AppRouter {
  AppRouter._();

  static const siteName = 'Ahmet Kadir Çiçek';

  /// Browser tab title of a page.
  static Widget titled(String? page, Widget child) => Title(
      title: page == null ? '$siteName — Mobile Developer' : '$page — $siteName', color: AppColors.ink, child: child);

  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) => titled('Page not found', const NotFoundView()),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => titled(null, const SplashView()),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => titled(null, const HomeView()),
      ),
      // `/<collection>` opens the home page at the collection's section,
      // `/<collection>/<slug>` the entry's page; unknown slugs go back to the
      // section.
      for (final collection in collections)
        GoRoute(
          path: collection.path,
          builder: (context, state) => titled(collection.title, HomeView(startAt: collection.id)),
          routes: [
            GoRoute(
              path: ':slug',
              redirect: (context, state) =>
                  collection.bySlug(state.pathParameters['slug']) == null ? collection.path : null,
              builder: (context, state) {
                final entry = collection.bySlug(state.pathParameters['slug'])!;
                return titled(entry.title, EntryView(collection: collection, entry: entry));
              },
            ),
          ],
        ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => titled('Contact', const ContactFormView()),
      ),
      GoRoute(
        path: '/tunes/gdpr',
        builder: (context, state) => titled('Desktop Tunes Privacy Policy', const TunesGDPRView()),
      ),
    ],
  );
}
