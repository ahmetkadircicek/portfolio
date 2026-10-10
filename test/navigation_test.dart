import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/init/navigation/app_router.dart';
import 'package:portfolio/features/home/view/home_view.dart';
import 'package:portfolio/main.dart';
// ignore: implementation_imports
import 'package:url_launcher/src/link.dart' as link;

Future<void> _open(WidgetTester tester, String path, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  AppRouter.router.go(path);
  await tester.pumpWidget(const MyApp());
  await tester.pump(const Duration(seconds: 2));
}

/// Removes the app and lets its pending reveal delays run out.
Future<void> _close(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 10));
}

String get _location => AppRouter.router.routerDelegate.currentConfiguration.uri.toString();

void main() {
  const desktop = Size(1440, 900);

  setUp(HomeView.forgetPosition);

  // In the browser a link's address reaches the router through the engine;
  // tests have no engine, so hand it over directly.
  link.pushRouteToFrameworkFunction = (_, route) async {
    AppRouter.router.go(route);
    return ByteData(0);
  };

  for (final collection in collections) {
    final title = collection.title.en.toUpperCase();

    testWidgets('${collection.path} opens the home page at its section', (tester) async {
      await _open(tester, collection.path, desktop);
      expect(_location, collection.path);
      expect(find.textContaining(title, findRichText: true), findsWidgets);
      await _close(tester);
    });

    testWidgets('an unknown slug in ${collection.path} leads to the section', (tester) async {
      await _open(tester, '${collection.path}/nope', desktop);
      expect(_location, collection.path);
      await _close(tester);
    });

    // Every entry gets a page from its data alone.
    for (final entry in collection.entries) {
      testWidgets('${collection.pathOf(entry)} shows the entry and leads back', (tester) async {
        await _open(tester, collection.pathOf(entry), desktop);
        expect(find.text(entry.title.en.toUpperCase()), findsOneWidget);
        await tester.tap(find.text('All ${collection.title.en.toLowerCase()}'));
        await tester.pump();
        await tester.pump(const Duration(seconds: 2));
        expect(_location, collection.path);
        await _close(tester);
      });
    }
  }

  test('the tab title is the site name on the home page and its sections', () {
    expect(AppRouter.titleFor(Uri.parse('/')), AppRouter.homeTitle);
    for (final collection in collections) {
      expect(AppRouter.titleFor(Uri.parse(collection.path)), AppRouter.homeTitle);
      final entry = collection.entries.first;
      expect(AppRouter.titleFor(Uri.parse(collection.pathOf(entry))), '${entry.title.en} — ${AppRouter.siteName}');
    }
  });

  testWidgets('coming back from an entry returns to the same place', (tester) async {
    await _open(tester, '/home', desktop);
    final scrollable = find.byType(Scrollable).first;
    final project = projects.entries.first;
    final row = find.text(project.title.en.toUpperCase());
    await tester.ensureVisible(row);
    await tester.pump(const Duration(seconds: 1));
    final before = tester.state<ScrollableState>(scrollable).position.pixels;
    expect(before, greaterThan(0));
    await tester.tap(row);
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(_location, projects.pathOf(project));
    await tester.tap(find.text('All projects'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    expect(tester.state<ScrollableState>(find.byType(Scrollable).first).position.pixels, before);
    await _close(tester);
  });
}
