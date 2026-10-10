import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/init/navigation/app_router.dart';
import 'package:portfolio/features/entry/widget/highlight_deck.dart';
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

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  // Phone layouts are measured with the site's own fonts, as in main.dart;
  // the wider test font would overflow rows that fit on a real phone.
  setUpAll(() async {
    GoogleFonts.montserrat(fontWeight: FontWeight.w400);
    GoogleFonts.montserrat(fontWeight: FontWeight.w600);
    GoogleFonts.cardo(fontWeight: FontWeight.w700);
    await GoogleFonts.pendingFonts();
  });

  final entry = projects.entries.firstWhere((e) => e.highlights.isNotEmpty);
  final path = projects.pathOf(entry);
  final title = find.textContaining(entry.title.en.toUpperCase(), findRichText: true).first;
  final deck = find.byType(HighlightDeck);
  final overview = find.text(entry.overview.en);

  for (final (name, size) in [('phone', const Size(375, 812)), ('tablet', const Size(800, 1024))]) {
    testWidgets('on a $name the title leads, then the images, then the text', (tester) async {
      await _open(tester, path, size);
      final titleTop = tester.getTopLeft(title).dy;
      final deckTop = tester.getTopLeft(deck).dy;
      expect(titleTop, lessThan(deckTop));
      expect(tester.getBottomLeft(deck).dy, lessThan(tester.getTopLeft(overview).dy));
      await _close(tester);
    });
  }

  testWidgets('on a desktop the text and the images sit side by side', (tester) async {
    await _open(tester, path, const Size(1440, 900));
    expect(tester.getTopLeft(overview).dx, lessThan(tester.getTopLeft(deck).dx));
    await _close(tester);
  });
}
