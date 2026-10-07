import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Widgets take every color from `context.colors`, so each new screen works
/// in light and dark mode. Raw colors live only in the theme and the data.
void main() {
  test('no raw colors outside the theme and data', () {
    final raw = RegExp(r'Color\(0x|Colors\.(?!transparent)\w');
    final offenders = [
      for (final file in Directory('lib').listSync(recursive: true).whereType<File>())
        if (file.path.endsWith('.dart') &&
            !file.path.startsWith('lib/core/theme/') &&
            !file.path.startsWith('lib/core/data/') &&
            raw.hasMatch(file.readAsStringSync()))
          file.path,
    ];
    expect(offenders, isEmpty, reason: 'Use context.colors instead of raw colors.');
  });
}
