#!/bin/sh
# Release build of the site into build/web, the folder Firebase Hosting serves.
set -e
flutter build web --release --wasm --no-web-resources-cdn --pwa-strategy=none
# The site has no service worker; this one removes the caching worker that
# versions before October 2026 installed.
cp tool/service-worker-cleanup.js build/web/flutter_service_worker.js
# Link preview images, then a static page per route and language,
# sitemap.xml and llms.txt, all from the site's data (see the files).
flutter test tool/og_image_test.dart
flutter test tool/generate_site_test.dart
