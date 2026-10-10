import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/components/pressable.dart';
import 'package:portfolio/core/init/navigation/app_router.dart';
import 'package:portfolio/core/l10n/l10n.dart';
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

  test('the tab title follows the language of the address', () {
    final tunes = projects.entries.first;
    expect(AppRouter.titleFor(Uri.parse('/tr')), AppRouter.homeTitleIn(AppLanguage.tr));
    expect(AppRouter.titleFor(Uri.parse('/de/projects')), AppRouter.homeTitleIn(AppLanguage.de));
    expect(AppRouter.titleFor(Uri.parse('/tr/contact')), 'İletişim — ${AppRouter.siteName}');
    expect(AppRouter.titleFor(Uri.parse('/tr${projects.pathOf(tunes)}')), '${tunes.title.tr} — ${AppRouter.siteName}');
  });

  test('every language keeps the same paths under its prefix', () {
    for (final language in AppLanguage.values) {
      for (final path in ['/', '/contact', projects.pathOf(projects.entries.first)]) {
        final (back, rest) = AppLanguage.split(Uri.parse(language.localize(path)));
        expect((back, rest), (language, path));
      }
    }
  });

  testWidgets('a Turkish address shows the page in Turkish and its links stay Turkish', (tester) async {
    final entry = projects.entries.first;
    await _open(tester, '/tr${projects.pathOf(entry)}', desktop);
    expect(LanguageManager.language.value, AppLanguage.tr);
    expect(find.text(entry.subtitle.tr), findsWidgets);
    await tester.tap(find.text(projects.title.tr));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(_location, '/tr/projects');
    await _close(tester);
  });

  testWidgets('the language switch opens the same page in the next language', (tester) async {
    await _open(tester, '/contact', desktop);
    await tester.tap(find.text('EN'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(_location, '/tr/contact');
    expect(LanguageManager.saved, AppLanguage.tr);
    await tester.tap(find.text('TR'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(_location, '/de/contact');
    LanguageManager.saved = null;
    await _close(tester);
  });

  testWidgets('the remembered language applies only when the site opens at /', (tester) async {
    LanguageManager.saved = AppLanguage.de;
    addTearDown(() => LanguageManager.saved = null);
    AppRouter.reopen();
    await _open(tester, '/', desktop);
    expect(_location, '/de');
    AppRouter.router.go('/');
    await tester.pump();
    expect(_location, '/');
    AppRouter.reopen();
    AppRouter.router.go('/projects');
    await tester.pump();
    expect(_location, '/projects');
    await _close(tester);
  });

  testWidgets('links work from the keyboard and show where the focus is', (tester) async {
    await _open(tester, projects.pathOf(projects.entries.first), desktop);
    Finder ring() => find.descendant(of: find.byType(Pressable), matching: find.byType(DecoratedBox));
    final before = ring().evaluate().length;
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(ring().evaluate().length, before + 1);
    // The first stop is the name in the top bar, which leads home.
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(_location, '/');
    await _close(tester);
  });

  testWidgets('the old /home address opens the landing page at /', (tester) async {
    await _open(tester, '/home', desktop);
    expect(_location, '/');
    expect(find.byType(HomeView), findsOneWidget);
    await _close(tester);
  });

  testWidgets('coming back from an entry returns to the same place', (tester) async {
    await _open(tester, '/', desktop);
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
