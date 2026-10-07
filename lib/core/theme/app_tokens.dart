import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

/// Design tokens. Every color, size, radius and duration on the site comes
/// from here; widgets never use raw values.

class AppColors {
  AppColors._();

  // Neutrals
  static const ink = Color(0xFF1F2024);
  static const inkMuted = Color(0xB81F2024); // 72 %
  static const inkSubtle = Color(0x9E1F2024); // 62 %, still 4.5:1 on white
  static const line = Color(0x1A1F2024); // 10 %
  static const canvas = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF3F2F7);
  static const surfaceHover = Color(0xFFEAE9F0);
  static const onInk = Color(0xFFFFFFFF);
  static const onInkMuted = Color(0xB3FFFFFF);

  // Project status
  static const statusReady = Color(0xFF2E7D32);
  static const statusProgress = Color(0xFFC24100);
  static const statusEarly = Color(0xFF1565C0);
  static const statusArchive = Color(0xFF6A1B9A);

  static const error = Color(0xFFC62828);
}

/// 4 pt spacing scale.
class AppSpace {
  AppSpace._();

  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x6 = 24;
  static const double x8 = 32;
  static const double x12 = 48;
  static const double x16 = 64;
  static const double x24 = 96;
  static const double x32 = 128;
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
}
