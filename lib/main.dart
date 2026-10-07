import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:portfolio/core/components/custom_cursor_widget.dart';
import 'package:portfolio/core/init/navigation/app_router.dart';
import 'package:provider/provider.dart';

import 'core/init/notifier/provider_manager.dart';
import 'core/theme/theme_manager.dart';

void main() {
  usePathUrlStrategy();

  runApp(
    MultiProvider(
      providers: ProviderManager.instance.providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Ahmet Kadir Çiçek — Mobile Developer',
      theme: ThemeManager.theme,
      builder: (context, child) => CustomCursorWidget(child: child!),
    );
  }
}
