import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:portfolio/core/init/navigation/app_router.dart';
import 'package:portfolio/main.dart';

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
  GoogleFonts.config.allowRuntimeFetching = false;

  const desktop = Size(1440, 900);

  for (final collection in collections) {
    final title = collection.title.toUpperCase();

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
        expect(find.text(entry.title.toUpperCase()), findsOneWidget);
        await tester.tap(find.text('All ${collection.title.toLowerCase()}'));
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
      expect(AppRouter.titleFor(Uri.parse(collection.pathOf(entry))), '${entry.title} — ${AppRouter.siteName}');
    }
  });
}
