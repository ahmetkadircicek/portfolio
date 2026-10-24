# Portfolio

**Live: [ahmetkadircicek.com.tr](https://ahmetkadircicek.com.tr)**

![Less, but better. — Ahmet Kadir Çiçek](docs/preview.png)

Portfolio of Ahmet Kadir Çiçek, mobile developer. A Flutter web app compiled to WebAssembly, in English and Turkish, hosted on Firebase Hosting (project `portfolio-9e0f3`).

## Run locally

```sh
flutter pub get
flutter run -d chrome
```

## Build and deploy

GitHub Actions deploys the site; nothing needs to run locally.

| Event | Workflow | Result |
| --- | --- | --- |
| Pull request | `.github/workflows/firebase-hosting-pull-request.yml` | analyze, test, build, then a Firebase preview channel; the preview URL is posted on the pull request and expires after 7 days |
| Push to `main` | `.github/workflows/firebase-hosting-merge.yml` | analyze, test, build, then the live site |

Both use the `FIREBASE_SERVICE_ACCOUNT_PORTFOLIO_9E0F3` repository secret, created by `firebase init hosting:github`. The Flutter version is pinned in both workflows; change it there together with your local SDK.

`tool/build_web.sh` is the one build command: `flutter build web --release --wasm --no-web-resources-cdn --pwa-strategy=none`, then `tool/service-worker-cleanup.js` installed as `/flutter_service_worker.js`, then the generated files below. To deploy by hand:

```sh
tool/build_web.sh && firebase deploy --only hosting
```

The site no longer uses Firestore. `firestore.rules` still holds the old contact form's rules; the workflows do not deploy them (`firebase deploy --only firestore:rules`).

The site has no service worker. Versions before October 2026 installed Flutter's caching worker, which keeps serving the old app from its cache; `web/index.html` removes it on the next visit and the cleanup worker covers browsers that check for worker updates in the background.

`--wasm` produces both a WebAssembly and a JavaScript build. Browsers with WasmGC (recent Chrome, Edge, Firefox) load the smaller and faster Wasm renderer; others fall back to JavaScript automatically.

Flutter draws to a canvas that search engines, link previews and language models cannot read, so the build adds plain files for them, all from the site's data:

| Step | Writes |
| --- | --- |
| `tool/og_image_test.dart` | a 1200×630 link preview image per project and a home card, per language, in `og/` |
| `tool/generate_site_test.dart` | an HTML file per page and language (`tr/projects/tunes.html`) with its title, description, canonical, hreflang, link preview tags and JSON-LD, and the page as hidden text; `sitemap.xml` with every language; `llms.txt` |

They run as tests because the data uses `dart:ui`. The parts of `web/index.html` they replace sit between `page:head` and `page:body` markers. `docs/preview.png` is a copy of `og/en/home.png`.

Pages are in English at `/` and in Turkish under `/tr`; the address decides the language. The German pages that once lived under `/de` lead to the English ones, and the old `/home` and `/experience` addresses to their place on the home page.

## Content

Every text is in English and Turkish (`L` in `lib/core/l10n/l10n.dart`); a text without both does not compile. The design is the "Portfolyo yenileme" canvas.

| What | Where |
| --- | --- |
| Projects: texts, chapters, screens, technology; adding one to `work` adds its home row and its page at `/projects/<slug>` | `lib/core/data/work.dart` |
| A project's figures and tables (the engineer's notebook on its page) | `lib/core/data/figures.dart` |
| About, experience, skills, links and the interface texts | `lib/core/data/profile.dart` |
| Design tokens (colors, spacing, radius, motion, breakpoints, grid) | `lib/core/theme/app_tokens.dart` |
| Type (Instrument Serif speaks, Instrument Sans is read, Geist Mono states facts) | `lib/core/theme/app_type.dart` |
| Home page, project page, figures, not found page | `lib/features/site/` |
| Navigation and the language switch | `lib/core/components/site_nav.dart` |
| CV | `web/ahmet-kadir-cicek-cv.pdf` (served as `/ahmet-kadir-cicek-cv.pdf`) |
| Link preview images, page texts for search engines, sitemap | generated at build time from the data (see Build and deploy) |

Images are WebP and sized for their largest on-screen use: screenshots about 720 px wide and trimmed to the phone frame (`tool/trim_screens.py`), logos 256 px. Fonts ship in `assets/fonts/`; Montserrat loads only when a Tunes figure shows it.

Widgets take every color from `context.colors`; raw colors live only in the theme and the data (`test/theme_tokens_test.dart`).
