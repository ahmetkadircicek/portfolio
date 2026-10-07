import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

/// Type scale. Cardo (serif, wide tracking, upper case) carries headings;
/// Montserrat carries everything that is read or clicked. Three weights
/// only: 400 to read, 600 to stress or click, 700 for the serif.
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
    required Color ink,
  }) {
    TextStyle serif(double size, FontWeight weight, double tracking) => GoogleFonts.cardo(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: size * tracking,
          height: 1.1,
          color: ink,
        );
    TextStyle sans(double size, FontWeight weight, {double height = 1.6, double tracking = 0}) =>
        GoogleFonts.montserrat(
          fontSize: size,
          fontWeight: weight,
          height: height,
          letterSpacing: tracking,
          color: ink,
        );

    return AppText._(
      display: serif(display, FontWeight.w700, 0.145),
      h1: serif(h1, FontWeight.w700, 0.1),
      h2: serif(h2, FontWeight.w700, 0.18),
      h3: sans(h3, FontWeight.w600, height: 1.35),
      title: sans(16, FontWeight.w600, height: 1.4),
      bodyLarge: sans(bodyLarge, FontWeight.w400, height: 1.55),
      body: sans(16, FontWeight.w400),
      bodySmall: sans(14, FontWeight.w400, height: 1.55),
      label: sans(12, FontWeight.w600, height: 1.3, tracking: 1.4),
      link: sans(16, FontWeight.w600, height: 1.3),
    );
  }

  static AppText _sized(String size, Color ink) => switch (size) {
        'mobile' => _build(display: 30, h1: 24, h2: 20, h3: 16, bodyLarge: 18, ink: ink),
        'tablet' => _build(display: 60, h1: 32, h2: 22, h3: 20, bodyLarge: 18, ink: ink),
        _ => _build(display: 80, h1: 40, h2: 24, h3: 20, bodyLarge: 20, ink: ink),
      };

  static final _cache = <(String, Color), AppText>{};

  /// The set for a screen size ('mobile', 'tablet' or 'desktop') in [ink].
  static AppText of(String size, Color ink) => _cache[(size, ink)] ??= _sized(size, ink);
}
