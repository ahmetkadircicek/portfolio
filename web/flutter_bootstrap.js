{{flutter_js}}
{{flutter_build_config}}

// No service worker: a portfolio does not need offline support, and Flutter's
// worker delays the first visit and can keep serving an old build after a
// deploy. tool/service-worker-cleanup.js removes the one older visits installed.
_flutter.loader.load();
