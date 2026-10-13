import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/data/profile.dart';

/// The loader in web/index.html greets visitors before the app runs, so it
/// carries its own copy of the greeting and its own asset paths.
void main() {
  final html = File('web/index.html').readAsStringSync();

  test('the loader greets in every language with the app\'s texts', () {
    for (final language in AppLanguage.values) {
      for (final text in [L.same(Profile.name), Copy.pageTitleRole]) {
        expect(html, contains(text.of(language).replaceAll("'", "\\'")), reason: language.name);
      }
    }
  });

  test('the loader\'s files ship with the app', () {
    // Flutter serves a bundled asset `x` at `assets/x`.
    final paths = RegExp(r'assets/(assets/[\w/.-]+)').allMatches(html).map((m) => m[1]!).toSet();
    expect(paths, isNotEmpty);
    for (final path in paths) {
      expect(File(path).existsSync(), isTrue, reason: path);
    }
  });
}
