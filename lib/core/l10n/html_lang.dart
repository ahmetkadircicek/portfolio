// Sets `<html lang>` in the browser; does nothing elsewhere (tests, VM).
export 'html_lang_stub.dart' if (dart.library.js_interop) 'html_lang_web.dart';
