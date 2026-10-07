import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

class ThemeManager {
  ThemeManager._();

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.montserratTextTheme().apply(bodyColor: AppColors.ink, displayColor: AppColors.ink),
        scaffoldBackgroundColor: AppColors.canvas,
        splashFactory: NoSplash.splashFactory,
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
