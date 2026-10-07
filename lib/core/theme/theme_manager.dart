import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

class ThemeManager {
  ThemeManager._();

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.montserratTextTheme().apply(bodyColor: AppColors.ink, displayColor: AppColors.ink),
        scaffoldBackgroundColor: AppColors.canvas,
        splashFactory: NoSplash.splashFactory,
        // Pages fade into each other; nothing slides on a website.
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {for (final platform in TargetPlatform.values) platform: const _FadePageTransitionsBuilder()},
        ),
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        colorScheme: const ColorScheme.light(
          primary: AppColors.ink,
          onPrimary: AppColors.onInk,
          secondary: AppColors.surface,
          onSecondary: AppColors.ink,
          surface: AppColors.canvas,
          onSurface: AppColors.ink,
          error: AppColors.error,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.ink,
          selectionColor: AppColors.line,
          selectionHandleColor: AppColors.ink,
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
