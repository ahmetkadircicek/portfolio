import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static ThemeManager? _instance;
  static ThemeManager get instance {
    _instance ??= ThemeManager._init();
    return _instance!;
  }

  ThemeManager._init();

  ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          primary: Colors.white,
          surface: Colors.white,
          secondary: const Color(0xFFF3F2F7),
          onPrimary: const Color(0xFF1F2024),
        ),
      );
}
