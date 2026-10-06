import 'package:go_router/go_router.dart';
import 'package:portfolio/features/contact_me/view/contact_form_view.dart';
import 'package:portfolio/features/home/view/home_view.dart';
import 'package:portfolio/features/not_found/not_found_view.dart';
import 'package:portfolio/features/policies/desktop_tunes_gdpr_view.dart';
import 'package:portfolio/features/project_details/view/projects_view.dart';
import 'package:portfolio/features/splash/splash_view.dart';

class AppRouter {
  AppRouter._();

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
      GoRoute(
        path: '/projects',
        builder: (context, state) => const ProjectsView(),
        routes: [
          GoRoute(
            path: ':slug',
            redirect: (context, state) =>
                ProjectsView.slugs.contains(state.pathParameters['slug']) ? null : '/projects',
            builder: (context, state) => ProjectsView(initialSlug: state.pathParameters['slug']),
          ),
        ],
      ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => const ContactFormView(),
      ),
      GoRoute(
        path: '/tunes/gdpr',
        builder: (context, state) => const TunesGDPRView(),
      ),
    ],
  );
}
