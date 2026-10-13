import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/components/screen_stage.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/theme/theme_manager.dart';

void main() {
  Future<void> pump(WidgetTester tester, double width, Widget stage) async {
    tester.view.physicalSize = Size(width, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      theme: ThemeManager.light,
      home: Scaffold(body: Center(child: SizedBox(width: width - 32, child: stage))),
    ));
  }

  for (final project in work) {
    for (final width in [390.0, 1440.0]) {
      testWidgets('${project.slug} lays out its row and cover at $width', (tester) async {
        await pump(tester, width, ScreenStage(screens: project.rowScreens, tint: null));
        expect(tester.takeException(), isNull);
        await pump(tester, width, ScreenStage(screens: project.cover, aspectRatio: 2, tint: project.color, lifted: true));
        await tester.pump(const Duration(seconds: 1));
        expect(tester.takeException(), isNull);
        expect(find.byType(Image), findsWidgets);
      });
    }
  }
}
