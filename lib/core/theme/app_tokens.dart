import 'package:flutter/material.dart';

/// Design tokens. Every color, size, radius and duration on the site comes
/// from here; widgets never use raw values.

/// Every color on the site. Widgets read it with `context.colors`, never a raw color, so anything new works
/// in both modes without extra effort (test/theme_tokens_test.dart checks).
class AppPalette extends ThemeExtension<AppPalette> {
  // Neutrals
  final Color ink;
  final Color inkMuted; // 72 %
  final Color inkSubtle; // 62 %, still 4.5:1 on canvas
  final Color line; // 10 %
  final Color canvas;
  final Color surface;
  final Color surfaceHover;
  final Color onInk;
  final Color onInkMuted;

  // The closing block on the home page.
  final Color block;
  final Color onBlock;
  final Color onBlockMuted;

  // Project status
  final Color statusReady;
  final Color statusProgress;
  final Color statusEarly;
  final Color statusArchive;

  final Color error;

  /// Keyboard focus ring; on dark blocks the ring takes [onBlock].
  final Color focus;

  const AppPalette({
    required this.ink,
    required this.inkMuted,
    required this.inkSubtle,
    required this.line,
    required this.canvas,
    required this.surface,
    required this.surfaceHover,
    required this.onInk,
    required this.onInkMuted,
    required this.block,
    required this.onBlock,
    required this.onBlockMuted,
    required this.statusReady,
    required this.statusProgress,
    required this.statusEarly,
    required this.statusArchive,
    required this.error,
    required this.focus,
  });

  static const light = AppPalette(
    ink: Color(0xFF1F2024),
    inkMuted: Color(0xB81F2024),
    inkSubtle: Color(0x9E1F2024),
    line: Color(0x1A1F2024),
    canvas: Color(0xFFFFFFFF),
    surface: Color(0xFFF3F2F7),
    surfaceHover: Color(0xFFEAE9F0),
    onInk: Color(0xFFFFFFFF),
    onInkMuted: Color(0xB3FFFFFF),
    block: Color(0xFF1F2024),
    onBlock: Color(0xFFFFFFFF),
    onBlockMuted: Color(0xB3FFFFFF),
    statusReady: Color(0xFF2E7D32),
    statusProgress: Color(0xFFC24100),
    statusEarly: Color(0xFF1565C0),
    statusArchive: Color(0xFF6A1B9A),
    error: Color(0xFFC62828),
    focus: Color(0xFF1F2024),
  );

  @override
  AppPalette copyWith() => this;

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      ink: l(ink, other.ink),
      inkMuted: l(inkMuted, other.inkMuted),
      inkSubtle: l(inkSubtle, other.inkSubtle),
      line: l(line, other.line),
      canvas: l(canvas, other.canvas),
      surface: l(surface, other.surface),
      surfaceHover: l(surfaceHover, other.surfaceHover),
      onInk: l(onInk, other.onInk),
      onInkMuted: l(onInkMuted, other.onInkMuted),
      block: l(block, other.block),
      onBlock: l(onBlock, other.onBlock),
      onBlockMuted: l(onBlockMuted, other.onBlockMuted),
      statusReady: l(statusReady, other.statusReady),
      statusProgress: l(statusProgress, other.statusProgress),
      statusEarly: l(statusEarly, other.statusEarly),
      statusArchive: l(statusArchive, other.statusArchive),
      error: l(error, other.error),
      focus: l(focus, other.focus),
    );
  }
}

/// 4 pt spacing scale.
class AppSpace {
  AppSpace._();

  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x5 = 20;
  static const double x6 = 24;
  static const double x7 = 28;
  static const double x8 = 32;
  static const double x10 = 40;
  static const double x12 = 48;
  static const double x14 = 56;
  static const double x16 = 64;
  static const double x18 = 72;
  static const double x20 = 80;
  static const double x24 = 96;
  static const double x30 = 120;
  static const double x32 = 128;
  static const double x40 = 160;
}

class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double pill = 999;

  static const smAll = BorderRadius.all(Radius.circular(sm));
  static const mdAll = BorderRadius.all(Radius.circular(md));
  static const lgAll = BorderRadius.all(Radius.circular(lg));
  static const pillAll = BorderRadius.all(Radius.circular(pill));
}

/// The site's one shadow: a wide, faint ambient layer and a thin contact
/// layer. Anything that lifts off the page uses it; there is no second level.
class AppShadow {
  AppShadow._();

  static const soft = [
    BoxShadow(color: Color(0x0F1F2024), blurRadius: 40, offset: Offset(0, 16), spreadRadius: -12), // ink 6 %
    BoxShadow(color: Color(0x0A1F2024), blurRadius: 3, offset: Offset(0, 1)), // ink 4 %
  ];

  /// Same layers fully transparent, so [soft] can animate in and out.
  static final none = [for (final s in soft) s.copyWith(color: s.color.withValues(alpha: 0))];
}

/// The keyboard focus ring: a line around the focused control with a gap,
/// following its shape.
class AppFocus {
  AppFocus._();

  static const double width = 2;
  static const double gap = 3;
}

class AppMotion {
  AppMotion._();

  static const fast = Duration(milliseconds: 150);
  static const base = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 500);
  static const reveal = Duration(milliseconds: 700);

  static const standard = Curves.easeOutCubic;
  static const emphasized = Cubic(0.2, 0, 0, 1);
}

class AppBreakpoints {
  AppBreakpoints._();

  /// Up to and including this width is a phone.
  static const double mobile = 650;

  /// From this width on is a desktop.
  static const double desktop = 1024;
}

class AppLayout {
  AppLayout._();

  /// Content never grows wider than this.
  static const double maxWidth = 1360;

  /// Width of long-form text such as project overviews.
  static const double readingWidth = 720;

  /// The redesign's content column: at most this wide with the gutter, on a
  /// grid of [columns] separated by [columnGap].
  static const double pageWidth = 1200;
  static const int columns = 12;
  static const double columnGap = 24;

  /// Height of the global navigation bar.
  static const double navHeight = 52;
}
