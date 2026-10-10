// Renders the link preview images (1200×630) into build/web/og: the home
// card for each language and a card for every entry in each language. Runs
// in tool/build_web.sh before tool/generate_site_test.dart, which points the
// pages at them:
//
//   flutter test tool/og_image_test.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/components/app_logo.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:portfolio/core/data/entry.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/core/theme/theme_manager.dart';

import 'og.dart';

const size = Size(1200, 630);
const avatar = 'assets/images/common/profile.jpg';

/// First frame of the looping 3D shape. Tests only advance an animated
/// image when a frame is pumped, so it is decoded here instead.
late ui.Image shape;

/// The rounded surface every card sits on, with the name in the corner.
class _Card extends StatelessWidget {
  final Widget child;
  final bool footer;

  const _Card({required this.child, this.footer = true});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.canvas,
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.x6),
        child: DecoratedBox(
          decoration: BoxDecoration(color: context.colors.surface, borderRadius: BorderRadius.circular(AppRadius.lg)),
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.x12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: child),
                if (footer)
                  Row(
                    children: [
                      const CircleAvatar(radius: 28, backgroundImage: AssetImage(avatar)),
                      const SizedBox(width: AppSpace.x4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ahmet Kadir Çiçek', style: context.text.title),
                            Text(context.t(S.role), style: context.text.bodySmall.copyWith(color: context.colors.inkMuted)),
                          ],
                        ),
                      ),
                      Text('ahmetkadircicek.com.tr', style: context.text.link),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The hero in miniature: avatar, signature and the motto over the shape.
class _HomeCard extends StatelessWidget {
  const _HomeCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      footer: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RawImage(image: shape, width: 420, height: 420),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(radius: 48, backgroundImage: AssetImage(avatar)),
              const SizedBox(height: AppSpace.x6),
              Image.asset('assets/images/common/signature.webp', width: 160, excludeFromSemantics: true),
              Text('MAKE IT SIMPLE', style: context.text.display.copyWith(fontSize: 72)),
              const SizedBox(height: AppSpace.x3),
              Text(
                context.t(S.heroLine),
                textAlign: TextAlign.center,
                style: context.text.bodyLarge.copyWith(color: context.colors.inkMuted),
              ),
              const SizedBox(height: AppSpace.x6),
              Text('Ahmet Kadir Çiçek — ${context.t(S.role)}', style: context.text.title),
            ],
          ),
        ],
      ),
    );
  }
}

/// An entry: its logo, label, title and subtitle.
class _EntryCard extends StatelessWidget {
  final Entry entry;

  const _EntryCard(this.entry);

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          AppLogo(path: entry.logo, size: 168),
          const SizedBox(width: AppSpace.x12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.t(entry.label).toUpperCase(),
                    style: context.text.label.copyWith(color: context.colors.inkMuted)),
                const SizedBox(height: AppSpace.x3),
                Text(context.t(entry.title).toUpperCase(), style: context.text.h1.copyWith(fontSize: 52)),
                const SizedBox(height: AppSpace.x3),
                Text(context.t(entry.subtitle), style: context.text.bodyLarge.copyWith(color: context.colors.inkMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _loadFonts() async {
  Future<ByteData> font(String file) => rootBundle.load('assets/google_fonts/$file');
  await (FontLoader('Montserrat')
        ..addFont(font('Montserrat-Regular.ttf'))
        ..addFont(font('Montserrat-SemiBold.ttf')))
      .load();
  await (FontLoader('Cardo')..addFont(font('Cardo-Bold.ttf'))).load();
  await (FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
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
    for (final element in find.byType(CircleAvatar).evaluate()) {
      await precacheImage((element.widget as CircleAvatar).backgroundImage!, element);
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
      for (final collection in collections) {
        for (final entry in collection.entries) {
          await _shoot(tester, language, _EntryCard(entry), ogFile(language, collection.pathOf(entry)));
        }
      }
    }
    await tester.pumpWidget(const SizedBox());
  });
}
