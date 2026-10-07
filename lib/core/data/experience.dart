import 'package:portfolio/core/data/entry.dart';

/// Work history, newest first, taken from the CV. Adding an entry here adds
/// its row on the home page and its page at `/experience/<slug>`.
const experience = Collection(
  id: 'experience',
  title: 'Experience',
  entries: [
    Entry(
      slug: 'huawei',
      title: 'Mobile Developer',
      subtitle: 'Huawei Türkiye R&D Center',
      label: 'Dec 2025 — Present',
      summary:
          'HarmonyOS watch apps in ArkTS and JS, built on Wear Engine, Health and Location kits. I work directly with partner developers until their app is live.',
      overview:
          'I develop watch apps on both HarmonyOS platforms and support the partner teams who build on them, from their first integration to the store release.',
      points: [
        'Develop watch apps on both HarmonyOS platforms: smart wearables in ArkTS with declarative ArkUI and the Stage model, and lite wearables in the HML/CSS/JS framework, which runs only a restricted ES6 subset.',
        'Kits I use and support day to day: Wear Engine (watch-to-phone P2P messaging, device discovery, connection state), Health Service Kit (on-device workout and health data), Health Kit Cloud REST, Location Kit, Background Tasks, Core File Kit.',
        'Support customer teams end to end: talk to their developers directly, review their integration, debug it on real devices, and stay with them until the app is live.',
        'Debug on physical devices, isolate undocumented runtime behaviour, and feed the corrections back into the documentation developers actually read.',
        'Back each role in the delivery chain with the part of the process that belongs to it, from development and build through to store release.',
      ],
      logo: 'assets/images/experience/huawei.png',
      tags: [
        'HarmonyOS',
        'ArkTS',
        'ArkUI',
        'HML/CSS/JS',
        'Wear Engine',
        'Health Service Kit',
        'Location Kit',
        'DevEco Studio'
      ],
    ),
    Entry(
      slug: 'freelance',
      title: 'Freelance Mobile Developer',
      subtitle: 'Logistics and transportation clients',
      label: '2024 — 2025',
      summary:
          'Flutter apps taken from first requirement to store release, with push notifications that keep drivers and operators up to date.',
      overview:
          'I designed, built and shipped Flutter apps for logistics and transportation clients, each one from the first requirement to the store release.',
      points: [
        'Designed, built and shipped Flutter apps for logistics and transportation clients, each one from first requirement to store release.',
        'Built push notification infrastructure (OneSignal, FCM) delivering instant status updates and critical alerts to drivers and operators in the field.',
        'Ran versioning and staged rollout, then handled post-release feedback, crash reports and fixes.',
        'Worked directly with clients on scope, delivery timelines and maintenance.',
      ],
      tags: ['Flutter', 'Dart', 'OneSignal', 'FCM', 'Staged rollout'],
    ),
    Entry(
      slug: 'ibb',
      title: 'Mobile Software Intern',
      subtitle: 'İstanbul Metropolitan Municipality',
      label: 'Jul 2024 — Sep 2024',
      summary:
          'Built a Flutter app end to end with NFC, AI-assisted features and push notifications, inside a public-sector release process.',
      overview:
          'I contributed to Flutter development at the municipality and built one app end to end, from the first line to the release.',
      points: [
        'Contributed to Flutter development and built one app end to end, from first line to release.',
        'Worked hands-on with NFC, AI-assisted features and push notification integration.',
        'Learned corporate release processes, regulatory requirements and user data handling; used Git and contributed to test scenarios.',
      ],
      logo: 'assets/images/experience/ibb.png',
      tags: ['Flutter', 'Dart', 'NFC', 'Push notifications', 'Git'],
    ),
  ],
);
