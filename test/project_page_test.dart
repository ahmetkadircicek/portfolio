import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/theme/theme_manager.dart';
import 'package:portfolio/features/site/project_page.dart';

import 'home_page_test.dart' show loadSiteFonts;

void main() {
  setUpAll(loadSiteFonts);

  for (final project in work) {
    for (final width in [320.0, 1440.0]) {
      testWidgets('${project.slug} page lays out at $width', (tester) async {
        tester.view.physicalSize = Size(width, 900);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(MaterialApp(theme: ThemeManager.light, home: ProjectPage(project: project)));
        await tester.pump(const Duration(seconds: 1));
        for (var i = 0; i < 16; i++) {
          await tester.drag(find.byType(Scrollable).first, const Offset(0, -800));
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(tester.takeException(), isNull);
        expect(find.text(project.chapters.first.lead.en), findsOneWidget);
      });
    }
  }
}
