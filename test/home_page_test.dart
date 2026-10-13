import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/theme/theme_manager.dart';
import 'package:portfolio/features/site/home_page.dart';

/// Loads the site's real fonts; the test font's square glyphs are wider and
/// would overflow rows that fit on a real phone.
Future<void> loadSiteFonts() async {
  final families = {
    'Instrument Serif': ['InstrumentSerif-Regular', 'InstrumentSerif-Italic'],
    'Instrument Sans': ['InstrumentSans-Regular', 'InstrumentSans-Medium', 'InstrumentSans-SemiBold'],
    'Geist Mono': ['GeistMono-Regular', 'GeistMono-Medium'],
  };
  for (final MapEntry(:key, :value) in families.entries) {
    final loader = FontLoader(key);
    for (final file in value) {
      final bytes = File('assets/fonts/$file.ttf').readAsBytesSync();
      loader.addFont(Future.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }
}

void main() {
  setUpAll(loadSiteFonts);

  for (final width in [320.0, 390.0, 1024.0, 1440.0]) {
    testWidgets('the new home page lays out at $width', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(MaterialApp(theme: ThemeManager.light, home: const HomePage()));
      await tester.pump(const Duration(seconds: 3));
      expect(tester.takeException(), isNull);
      for (final project in work) {
        expect(find.textContaining(project.name, findRichText: true), findsWidgets);
      }
      // Scroll through the whole page so every section lays out.
      for (var i = 0; i < 12; i++) {
        await tester.drag(find.byType(Scrollable).first, const Offset(0, -800));
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 3));
    });
  }
}
