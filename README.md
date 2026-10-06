# Portfolio

Source of [ahmetkadircicek.com.tr](https://ahmetkadircicek.com.tr), a Flutter web app hosted on Firebase (project `portfolio-9e0f3`).

## Run locally

```sh
flutter pub get
flutter run -d chrome
```

## Build and deploy

```sh
firebase deploy --only hosting,firestore:rules
```

The hosting predeploy hook in `firebase.json` runs `flutter build web --release --wasm --pwa-strategy=none` and installs `tool/service-worker-cleanup.js` as `/flutter_service_worker.js`, so a plain deploy always ships the right build.

The site has no service worker. Versions before October 2026 installed Flutter's caching worker, which keeps serving the old app from its cache; `web/index.html` removes it on the next visit and the cleanup worker covers browsers that check for worker updates in the background.

`--wasm` produces both a WebAssembly and a JavaScript build. Browsers with WasmGC (recent Chrome, Edge, Firefox) load the smaller and faster Wasm renderer; others fall back to JavaScript automatically.

`firestore:rules` is only needed when `firestore.rules` changes. The first deploy needs a Firestore database: Firebase console → Firestore Database → Create database.

## Contact form

Messages are written to the Firestore `messages` collection and can be read in the Firebase console. `firestore.rules` only allows creating a message with the expected fields and sizes; nothing can be read, changed or deleted from the site.

To try the form without touching production:

```sh
flutter build web --release --wasm --dart-define=USE_FIRESTORE_EMULATOR=true
firebase emulators:start --only firestore --project portfolio-9e0f3
# serve build/web on any static server, open /contact and send a message
```

## Content

| What | Where |
| --- | --- |
| Home sections (Tunes, Vilsa, Sevkiyatvar) | `lib/features/home/widget/` |
| Project detail pages | `lib/features/project_details/view/` |
| CV | `web/ahmet-kadir-cicek-cv.pdf` (served as `/ahmet-kadir-cicek-cv.pdf`) |
| Link preview image | `web/og-image.jpg` (1200x630) |
| Text for search engines | hidden `<main>` in `web/index.html` — update it with the visible content |

Images are WebP and sized for their largest on-screen use: screenshots 720 px wide, mockups 1400 px (cards zoom 3x on hover), logos 256 px.
