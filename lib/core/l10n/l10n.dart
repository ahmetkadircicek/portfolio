import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Languages of the site, in switcher order.
enum AppLanguage {
  en('EN', 'English'),
  tr('TR', 'Türkçe'),
  de('DE', 'Deutsch');

  final String short;
  final String nativeName;
  const AppLanguage(this.short, this.nativeName);

  Locale get locale => Locale(name);
}

/// A text in every language of the site. All three are required, so a new
/// text cannot ship half translated.
class L {
  final String en;
  final String tr;
  final String de;

  const L(this.en, {required this.tr, required this.de});

  /// Same text in every language, e.g. a product name.
  const L.same(String text)
      : en = text,
        tr = text,
        de = text;

  String of(AppLanguage language) => switch (language) {
        AppLanguage.en => en,
        AppLanguage.tr => tr,
        AppLanguage.de => de,
      };
}

/// The active language: the visitor's last pick, else the browser's
/// language, else English.
class LanguageManager {
  LanguageManager._();

  static const _key = 'language';

  static final language = ValueNotifier(AppLanguage.en);

  static Future<void> load() async {
    language.value = _fromBrowser();
    try {
      final saved = (await SharedPreferences.getInstance()).getString(_key);
      for (final l in AppLanguage.values) {
        if (l.name == saved) language.value = l;
      }
    } catch (_) {
      // Storage blocked: keep the browser's language.
    }
  }

  static AppLanguage _fromBrowser() {
    for (final locale in WidgetsBinding.instance.platformDispatcher.locales) {
      for (final l in AppLanguage.values) {
        if (l.name == locale.languageCode) return l;
      }
    }
    return AppLanguage.en;
  }

  static void set(AppLanguage next) {
    language.value = next;
    SharedPreferences.getInstance().then((p) => p.setString(_key, next.name)).ignore();
  }
}

extension LocalizedContext on BuildContext {
  /// The language the page is shown in.
  AppLanguage get language {
    final code = Localizations.localeOf(this).languageCode;
    return AppLanguage.values.firstWhere((l) => l.name == code, orElse: () => AppLanguage.en);
  }

  /// [text] in the page's language.
  String t(L text) => text.of(language);
}
