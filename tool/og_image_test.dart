// Renders the link preview images (1200×630) into build/web/og: the home
// card for each language and a card for every project in each language.
// Runs in tool/build_web.sh before tool/generate_site_test.dart, which
// points the pages at them:
//
//   flutter test tool/og_image_test.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/core/theme/theme_manager.dart';

import 'og.dart';

const size = Size(1200, 630);

/// First frame of the looping 3D shape. Tests only advance an animated
/// image when a frame is pumped, so it is decoded here instead.
late ui.Image shape;

/// The white card every preview sits on: the name and the address on top,
/// [child] below.
class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    return ColoredBox(
      color: colors.canvas,
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.x18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Profile.name, style: type.link.copyWith(fontSize: 24)),
                Text(context.upper(context.t(Copy.pageTitleRole)),
                    style: type.label.copyWith(fontSize: 16, color: colors.inkSubtle)),
              ],
            ),
            Expanded(child: child),
            Text('ahmetkadircicek.com.tr', style: type.label.copyWith(fontSize: 16, color: colors.inkSubtle)),
          ],
        ),
      ),
    );
  }
}

/// The hero in miniature: the quote over the shape.
class _HomeCard extends StatelessWidget {
  const _HomeCard();

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    return _Card(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(right: -40, child: Opacity(opacity: 0.35, child: RawImage(image: shape, width: 480, height: 480))),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Profile.quote.join(' '), style: type.quote.copyWith(fontSize: 150)),
              const SizedBox(height: AppSpace.x5),
              Text(Profile.quoteBy, style: type.label.copyWith(fontSize: 18, color: context.colors.inkSubtle)),
            ],
          ),
        ],
      ),
    );
  }
}

/// A project: its icon, name, descriptor and status.
class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard(this.project);

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    return _Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(160 * 0.22),
            child: Image.asset(project.logo, width: 160, height: 160),
          ),
          const SizedBox(width: AppSpace.x12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.upper(context.t(project.label)), style: type.label.copyWith(fontSize: 18, color: colors.inkSubtle)),
                const SizedBox(height: AppSpace.x4),
                Text(project.name, style: type.display.copyWith(fontSize: 128)),
                const SizedBox(height: AppSpace.x2),
                Text(context.t(project.descriptor),
                    style: type.descriptor.copyWith(fontSize: 44, color: colors.inkSubtle)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _loadFonts() async {
  final families = {
    'Instrument Serif': ['InstrumentSerif-Regular', 'InstrumentSerif-Italic'],
    'Instrument Sans': ['InstrumentSans-Regular', 'InstrumentSans-Medium', 'InstrumentSans-SemiBold'],
    'Geist Mono': ['GeistMono-Regular', 'GeistMono-Medium'],
  };
  for (final MapEntry(:key, :value) in families.entries) {
    final loader = FontLoader(key);
    for (final file in value) {
      loader.addFont(rootBundle.load('assets/fonts/$file.ttf'));
    }
    await loader.load();
  }
}

Future<void> _shoot(WidgetTester tester, AppLanguage language, Widget card, String file) async {
  final boundary = GlobalKey();
  await tester.pumpWidget(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeManager.light,
    locale: language.locale,
    supportedLocales: [for (final l in AppLanguage.values) l.locale],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: RepaintBoundary(key: boundary, child: Material(child: card)),
  ));
  await tester.runAsync(() async {
    for (final element in find.byType(Image).evaluate()) {
      await precacheImage((element.widget as Image).image, element);
    }
  });
  await tester.pump();
  await tester.runAsync(() async {
    final render = boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await render.toImage();
    final png = await image.toByteData(format: ui.ImageByteFormat.png);
    File('build/web/$file')
      ..createSync(recursive: true)
      ..writeAsBytesSync(png!.buffer.asUint8List());
  });
}

void main() {
  setUpAll(() async {
    await _loadFonts();
    final bytes = await rootBundle.load('assets/images/common/shape.webp');
    final codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List());
    shape = (await codec.getNextFrame()).image;
  });

  testWidgets('renders the link preview images', (tester) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    for (final language in AppLanguage.values) {
      await _shoot(tester, language, const _HomeCard(), ogFile(language));
      for (final project in work) {
        await _shoot(tester, language, _ProjectCard(project), ogFile(language, project.path));
      }
    }
    await tester.pumpWidget(const SizedBox());
  });
}
