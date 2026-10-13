import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/init/navigation/app_router.dart';
import 'package:portfolio/main.dart';

import 'home_page_test.dart' show loadSiteFonts;

Future<void> _open(WidgetTester tester, String path) async {
  tester.view.physicalSize = const Size(1440, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  AppRouter.router.go(path);
  await tester.pumpWidget(const MyApp());
  await tester.pump(const Duration(seconds: 3));
}

Future<void> _close(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 3));
}

String get _location => AppRouter.router.routerDelegate.currentConfiguration.uri.toString();

void main() {
  setUpAll(loadSiteFonts);

  testWidgets('/ opens the home page and /home leads there', (tester) async {
    await _open(tester, '/home');
    expect(_location, '/');
    expect(find.text('Say hello.'), findsOneWidget);
    await _close(tester);
  });

  testWidgets('old experience pages lead to about', (tester) async {
    await _open(tester, '/experience/huawei');
    expect(_location, '/about');
    await _close(tester);
  });

  for (final project in work) {
    testWidgets('${project.path} shows the case study', (tester) async {
      await _open(tester, project.path);
      expect(_location, project.path);
      expect(find.text(project.chapters.first.lead.en), findsOneWidget);
      await _close(tester);
    });
  }

  testWidgets('removed projects and unknown slugs lead to the work', (tester) async {
    await _open(tester, '/projects/travelai');
    expect(_location, '/projects');
    await _close(tester);
  });

  testWidgets('an unknown address shows the not found page', (tester) async {
    await _open(tester, '/nope');
    expect(find.text('Nothing here.'), findsOneWidget);
    await _close(tester);
  });

  test('tab titles', () {
    expect(AppRouter.titleFor(Uri.parse('/')), AppRouter.homeTitle);
    expect(AppRouter.titleFor(Uri.parse('/about')), AppRouter.homeTitle);
    expect(AppRouter.titleFor(Uri.parse('/projects/tunes')), 'Tunes — ${AppRouter.siteName}');
  });
}
