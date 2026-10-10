import 'package:portfolio/core/l10n/l10n.dart';

/// Where the link preview image of a page lives in build/web: every entry
/// has its own card, every other page shows the home card of its language.
/// Written by tool/og_image_test.dart, used by tool/generate_site_test.dart.
String ogFile(AppLanguage language, [String? entryPath]) => 'og/${language.name}${entryPath ?? '/home'}.png';
