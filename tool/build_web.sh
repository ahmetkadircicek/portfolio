#!/bin/sh
# Release build of the site into build/web, the folder Firebase Hosting serves.
set -e
flutter build web --release --wasm --no-web-resources-cdn --pwa-strategy=none
# The site has no service worker; this one removes the caching worker that
# versions before October 2026 installed.
cp tool/service-worker-cleanup.js build/web/flutter_service_worker.js
