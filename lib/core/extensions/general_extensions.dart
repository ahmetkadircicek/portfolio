import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_text.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/core/theme/app_type.dart';

extension BuildContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  bool get isMobile => width <= AppBreakpoints.mobile;
  bool get isDesktop => width >= AppBreakpoints.desktop;
  bool get isTablet => !isMobile && !isDesktop;

  /// Type scale for the current width.
  AppText get text => AppText.of(isDesktop ? 'desktop' : (isTablet ? 'tablet' : 'mobile'), colors.ink);

  /// The redesign's type scale (serif, sans and mono) for the current width.
  AppType get type => AppType.of(isDesktop ? 'desktop' : (isTablet ? 'tablet' : 'mobile'), colors.ink);

  /// Colors of the active light or dark theme.
  AppPalette get colors => Theme.of(this).extension<AppPalette>()!;

  /// Horizontal page padding.
  double get gutter => isDesktop ? AppSpace.x12 : (isTablet ? AppSpace.x8 : AppSpace.x4);

  /// Space between two page sections.
  double get sectionGap => isDesktop ? AppSpace.x24 : (isTablet ? AppSpace.x16 : AppSpace.x12);

  /// True when the visitor asked the system for less motion.
  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);
}
