import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:portfolio/core/l10n/html_lang.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Languages of the site, in switcher order.
enum AppLanguage {
  en('EN', 'English'),
  tr('TR', 'Türkçe');

  final String short;
  final String nativeName;
  const AppLanguage(this.short, this.nativeName);

  Locale get locale => Locale(name);

  /// Where the language's pages live: English at the root, Turkish under
  /// `/tr`.
  String get prefix => this == en ? '' : '/$name';

  /// [path] (`/`, `/projects/tunes`) in this language.
  String localize(String path) => path == '/' && prefix.isNotEmpty ? prefix : '$prefix$path';

  /// The language of [uri] and its path without the language prefix.
  static (AppLanguage, String) split(Uri uri) {
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    for (final language in values) {
      if (language != en && segments.isNotEmpty && segments.first == language.name) {
        return (language, '/${segments.skip(1).join('/')}');
      }
    }
    return (en, '/${segments.join('/')}');
  }
}

/// A text in every language of the site. Both are required, so a new text
/// cannot ship half translated.
class L {
  final String en;
  final String tr;

  const L(this.en, {required this.tr});

  /// Same text in every language, e.g. a product name.
  const L.same(String text)
      : en = text,
        tr = text;

  String of(AppLanguage language) => switch (language) {
        AppLanguage.en => en,
        AppLanguage.tr => tr,
      };
}

/// The active language, which is the language of the address: `/tr/...` is
/// Turkish, everything else English. The visitor's last
/// pick is remembered and only applied when the site opens at `/`.
class LanguageManager {
  LanguageManager._();

  static const _key = 'language';

  static final language = ValueNotifier(AppLanguage.en);

  /// The visitor's last pick in the language switch, if any.
  static AppLanguage? saved;

  /// Reads the remembered pick and starts in the language the site opens
  /// in, so the first frame is already in it.
  static Future<void> load() async {
    try {
      final name = (await SharedPreferences.getInstance()).getString(_key);
      saved = AppLanguage.values.where((l) => l.name == name).firstOrNull;
    } catch (_) {
      // Storage blocked: nothing remembered.
    }
    final start = Uri.parse(WidgetsBinding.instance.platformDispatcher.defaultRouteName);
    language.value = start.path == '/' ? saved ?? AppLanguage.en : AppLanguage.split(start).$1;
  }

  static Uri? _pending;

  /// Follows the address to [uri]. The router can announce a page while
  /// widgets build; the change then waits for the end of the frame.
  static void follow(Uri uri) {
    final scheduler = SchedulerBinding.instance;
    if (scheduler.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      if (_pending == null) {
        scheduler.addPostFrameCallback((_) {
          final latest = _pending!;
          _pending = null;
          follow(latest);
        });
      }
      _pending = uri;
      return;
    }
    final (next, _) = AppLanguage.split(uri);
    if (language.value == next) return;
    language.value = next;
    setHtmlLang(next.name);
  }

  /// Remembers [next] as the visitor's pick.
  static void choose(AppLanguage next) {
    saved = next;
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

  /// [text] in upper case by the page's language: Turkish keeps the dot
  /// on İ.
  String upper(String text) =>
      (language == AppLanguage.tr ? text.replaceAll('i', 'İ') : text).toUpperCase();
}
