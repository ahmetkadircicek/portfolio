import 'package:flutter/widgets.dart';

/// The redesign's type system: three families with one job each.
///
/// - Instrument Serif speaks: the quote, titles and lead sentences.
/// - Instrument Sans is read: body text, navigation and links.
/// - Geist Mono states facts: labels, numbers and metadata, in upper case.
///
/// Sizes step down on tablets and phones; get the set for the current width
/// with `context.type`.
class AppType {
  /// "Less, but better." and other single statements; italic.
  final TextStyle quote;

  /// Page titles such as a project name or "Say hello.".
  final TextStyle display;

  /// A project's name in a list.
  final TextStyle heading;

  /// The intro paragraph under the hero.
  final TextStyle intro;

  /// The opening sentence of a section.
  final TextStyle lead;

  /// The italic line after a name, e.g. "AI Song Maker".
  final TextStyle descriptor;

  final TextStyle body;
  final TextStyle bodySmall;
  final TextStyle caption;

  /// Navigation and text links.
  final TextStyle link;

  /// Upper-case mono label, e.g. `WORK` or `01 — THE IDEA`.
  final TextStyle label;

  /// Smaller mono text inside figures and meta rows.
  final TextStyle note;

  const AppType._({
    required this.quote,
    required this.display,
    required this.heading,
    required this.intro,
    required this.lead,
    required this.descriptor,
    required this.body,
    required this.bodySmall,
    required this.caption,
    required this.link,
    required this.label,
    required this.note,
  });

  static const serif = 'Instrument Serif';
  static const sans = 'Instrument Sans';
  static const mono = 'Geist Mono';

  static AppType _build({
    required double quote,
    required double display,
    required double heading,
    required double intro,
    required double lead,
    required double descriptor,
    required double body,
    required double small,
    required double label,
    required Color ink,
  }) {
    TextStyle style(String family, double size, double height,
            {double tracking = 0, FontWeight weight = FontWeight.w400, FontStyle? fontStyle}) =>
        TextStyle(
          fontFamily: family,
          fontSize: size,
          height: height,
          letterSpacing: size * tracking,
          fontWeight: weight,
          fontStyle: fontStyle,
          color: ink,
        );

    return AppType._(
      quote: style(serif, quote, 1, tracking: -0.02, fontStyle: FontStyle.italic),
      display: style(serif, display, 0.95, tracking: -0.025),
      heading: style(serif, heading, 1.02, tracking: -0.015),
      intro: style(serif, intro, 1.26, tracking: -0.005),
      lead: style(serif, lead, 1.3, tracking: -0.005),
      descriptor: style(serif, descriptor, 1.2, fontStyle: FontStyle.italic),
      body: style(sans, body, 1.7),
      bodySmall: style(sans, small, 1.55),
      caption: style(sans, small - 1, 1.5),
      link: style(sans, small, 1.3, weight: FontWeight.w500),
      label: style(mono, label, 1.4, tracking: 0.04),
      note: style(mono, label - 1, 1.5, tracking: 0.02),
    );
  }

  static AppType _sized(String size, Color ink) => switch (size) {
        'mobile' => _build(
            quote: 52, display: 64, heading: 34, intro: 26, lead: 24, descriptor: 22,
            body: 16, small: 14, label: 11, ink: ink),
        'tablet' => _build(
            quote: 88, display: 88, heading: 36, intro: 30, lead: 28, descriptor: 22,
            body: 17, small: 15, label: 12, ink: ink),
        _ => _build(
            quote: 112, display: 112, heading: 40, intro: 34, lead: 30, descriptor: 22,
            body: 17, small: 15, label: 12, ink: ink),
      };

  static final _cache = <(String, Color), AppType>{};

  /// The set for a screen size ('mobile', 'tablet' or 'desktop') in [ink].
  static AppType of(String size, Color ink) => _cache[(size, ink)] ??= _sized(size, ink);
}
