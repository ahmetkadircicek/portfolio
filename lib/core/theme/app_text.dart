import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Type scale. Cardo (serif, wide tracking, upper case) carries headings;
/// Montserrat carries everything that is read or clicked.
///
/// Sizes step down on tablets and phones; get the set for the current width
/// with `context.text`.
class AppText {
  final TextStyle display;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle title;
  final TextStyle bodyLarge;
  final TextStyle body;
  final TextStyle bodySmall;
  final TextStyle label;
  final TextStyle link;

  const AppText._({
    required this.display,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.title,
    required this.bodyLarge,
    required this.body,
    required this.bodySmall,
    required this.label,
    required this.link,
  });

  static AppText _build({
    required double display,
    required double h1,
    required double h2,
    required double h3,
    required double bodyLarge,
  }) {
    TextStyle serif(double size, FontWeight weight, double tracking) => GoogleFonts.cardo(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: size * tracking,
          height: 1.1,
          color: AppColors.ink,
        );
    TextStyle sans(double size, FontWeight weight, {double height = 1.6, double tracking = 0}) =>
        GoogleFonts.montserrat(
          fontSize: size,
          fontWeight: weight,
          height: height,
          letterSpacing: tracking,
          color: AppColors.ink,
        );

    return AppText._(
      display: serif(display, FontWeight.w900, 0.145),
      h1: serif(h1, FontWeight.w700, 0.1),
      h2: serif(h2, FontWeight.w700, 0.18),
      h3: sans(h3, FontWeight.w600, height: 1.35),
      title: sans(16, FontWeight.w600, height: 1.4),
      bodyLarge: sans(bodyLarge, FontWeight.w400, height: 1.55),
      body: sans(16, FontWeight.w400),
      bodySmall: sans(14, FontWeight.w400, height: 1.55),
      label: sans(12, FontWeight.w600, height: 1.3, tracking: 1.4),
      link: sans(16, FontWeight.w500, height: 1.3),
    );
  }

  static final mobile = _build(display: 44, h1: 34, h2: 26, h3: 18, bodyLarge: 17);
  static final tablet = _build(display: 72, h1: 48, h2: 30, h3: 20, bodyLarge: 18);
  static final desktop = _build(display: 96, h1: 64, h2: 32, h3: 20, bodyLarge: 20);
}
