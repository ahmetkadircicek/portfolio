import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/components/custom_cursor_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/utils/performance_logger.dart';
import 'package:portfolio/features/contact_me/view/contact_form_view.dart';
import 'package:portfolio/features/home/view/home_view.dart';
import 'package:portfolio/features/project_details/view/projects_view.dart';
import 'package:portfolio/mobile_device_detected_view.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'features/splash/splash_view.dart';
import 'core/init/notifier/provider_manager.dart';
import 'core/theme/theme_manager.dart';
import 'features/policies/desktop_tunes_gdpr_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final logger = PerformanceLogger.instance;

  logger.startOperation('AppInitialization');

  logger.startOperation('FirebaseInitialization');
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyA7NHbZIK-NHEed6SA0NP6dIboMUlx8L_c",
        authDomain: "portfolio-9e0f3.firebaseapp.com",
        projectId: "portfolio-9e0f3",
        storageBucket: "portfolio-9e0f3.appspot.com",
        messagingSenderId: "558468121651",
        appId: "1:558468121651:web:7a0f5d555b3f661864cf46",
        measurementId: "G-FN8X2ENSK2"),
  );
  logger.endOperation('FirebaseInitialization');

  setPathUrlStrategy();

  logger.logMessage('Uygulama başlatılıyor...');

  runApp(
    MultiProvider(
      providers: [
        ...ProviderManager.instance.providers,
      ],
      child: const MyApp(),
    ),
  );

  logger.endOperation('AppInitialization');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
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
          path: '/tunes/gdpr',
          builder: (context, state) => const TunesGDPRView(),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => const ProjectsView(),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactFormView(),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Ahmet Kadir ÇIÇEK Portfolio',
      theme: ThemeManager.instance.theme,
      builder: (context, child) {
        if (context.isMobile || context.isTablet) {
          return const MobileDeviceDetectedView();
        }

        if (context.isDesktop) {
          return CustomCursorWidget(
            child: child!,
          );
        }
        return child!;
      },
    );
  }
}
