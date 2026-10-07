import 'package:web/web.dart' as web;

/// Tells the browser, screen readers and translators which language the page
/// is in.
void setHtmlLang(String code) => web.document.documentElement?.setAttribute('lang', code);
