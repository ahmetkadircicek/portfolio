import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

class ThemeManager {
  ThemeManager._();

  static final light = _build(AppPalette.light, Brightness.light);

  static ThemeData _build(AppPalette p, Brightness brightness) => ThemeData(
        brightness: brightness,
        extensions: [p],
        textTheme: GoogleFonts.montserratTextTheme(ThemeData(brightness: brightness).textTheme)
            .apply(bodyColor: p.ink, displayColor: p.ink),
        scaffoldBackgroundColor: p.canvas,
        splashFactory: NoSplash.splashFactory,
        // Pages fade into each other; nothing slides on a website.
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {for (final platform in TargetPlatform.values) platform: const _FadePageTransitionsBuilder()},
        ),
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: p.ink,
          onPrimary: p.onInk,
          secondary: p.surface,
          onSecondary: p.ink,
          surface: p.canvas,
          onSurface: p.ink,
          error: p.error,
          onError: p.canvas,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: p.ink,
          selectionColor: p.line,
          selectionHandleColor: p.ink,
        ),
      );
}

/// A plain cross-fade between pages.
class _FadePageTransitionsBuilder extends PageTransitionsBuilder {
  const _FadePageTransitionsBuilder();

  @override
  Duration get transitionDuration => AppMotion.slow;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: CurvedAnimation(parent: animation, curve: AppMotion.standard), child: child);
  }
}
