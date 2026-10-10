import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/init/navigation/app_router.dart';

import 'core/theme/theme_manager.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageManager.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageManager.language,
      builder: (context, _) => MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: AppRouter.homeTitle,
        theme: ThemeManager.light,
        locale: LanguageManager.language.value.locale,
        supportedLocales: [for (final l in AppLanguage.values) l.locale],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        builder: (context, child) => _TabTitle(child: child!),
      ),
    );
  }
}

/// The one place the tab title is set: from the current address, after every
/// route change. Pages carry no title of their own, so a page fading out can
/// never leave its name on the tab.
class _TabTitle extends StatefulWidget {
  final Widget child;

  const _TabTitle({required this.child});

  @override
  State<_TabTitle> createState() => _TabTitleState();
}

class _TabTitleState extends State<_TabTitle> {
  final _delegate = AppRouter.router.routerDelegate;

  @override
  void initState() {
    super.initState();
    _delegate.addListener(_update);
    LanguageManager.language.addListener(_update);
    _update();
  }

  @override
  void dispose() {
    _delegate.removeListener(_update);
    LanguageManager.language.removeListener(_update);
    super.dispose();
  }

  void _update() => SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: AppRouter.titleFor(_delegate.currentConfiguration.uri),
      primaryColor: 0xFF1F2024));

  // Also on build: the app's own default title is written just above this
  // whenever the app rebuilds, and this must win.
  @override
  Widget build(BuildContext context) {
    _update();
    return widget.child;
  }
}
