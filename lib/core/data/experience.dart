import 'package:portfolio/core/data/entry.dart';
import 'package:portfolio/core/l10n/l10n.dart';

/// Work history, newest first, taken from the CV. Adding an entry here adds
/// its row on the home page and its page at `/experience/<slug>`.
const experience = Collection(
  id: 'experience',
  title: L('Experience', tr: 'Deneyim', de: 'Berufserfahrung'),
  entries: [
    Entry(
      slug: 'huawei',
      title: L('Mobile Developer', tr: 'Mobil Geliştirici', de: 'Mobile Developer'),
      subtitle: L('Huawei Türkiye R&D Center', tr: 'Huawei Türkiye Ar-Ge Merkezi', de: 'Huawei Türkiye F&E-Zentrum'),
      label: L('Dec 2025 — Present', tr: 'Ara 2025 — Günümüz', de: 'Dez. 2025 — heute'),
      summary: L(
        'I build HarmonyOS watch apps in ArkTS and JS and stay with partner teams until their app is live.',
        tr: 'ArkTS ve JS ile HarmonyOS saat uygulamaları geliştiriyorum, partner ekiplerin uygulaması yayına çıkana kadar yanlarındayım.',
        de: 'Ich entwickle HarmonyOS-Watch-Apps in ArkTS und JS und begleite Partnerteams bis zum Go-live ihrer App.',
      ),
      overview: L(
        'I develop watch apps on both HarmonyOS platforms and support the partner teams building on them, from the first integration to the store release.',
        tr: 'İki HarmonyOS platformunda da saat uygulamaları geliştiriyorum. Bu platformlarda uygulama geliştiren partner ekipleri ilk entegrasyondan mağaza yayınına kadar destekliyorum.',
        de: 'Ich entwickle Watch-Apps für beide HarmonyOS-Plattformen und unterstütze Partnerteams von der ersten Integration bis zum Store-Release.',
      ),
      points: [
        L(
          'Smart wearables in ArkTS with declarative ArkUI and the Stage model; lite wearables in HML/CSS/JS, which only runs a restricted ES6 subset.',
          tr: 'Akıllı saatler için deklaratif ArkUI ve Stage modeliyle ArkTS; lite saatler için yalnızca kısıtlı bir ES6 alt kümesini çalıştıran HML/CSS/JS.',
          de: 'Smart Wearables in ArkTS mit deklarativem ArkUI und dem Stage-Modell; Lite Wearables in HML/CSS/JS, das nur eine eingeschränkte ES6-Teilmenge unterstützt.',
        ),
        L(
          'Kits I use and support every day: Wear Engine, Health Service Kit, Health Kit Cloud REST, Location Kit, Background Tasks and Core File Kit.',
          tr: 'Her gün kullandığım ve desteğini verdiğim kitler: Wear Engine, Health Service Kit, Health Kit Cloud REST, Location Kit, Background Tasks ve Core File Kit.',
          de: 'Kits, mit denen ich täglich arbeite und für die ich Support leiste: Wear Engine, Health Service Kit, Health Kit Cloud REST, Location Kit, Background Tasks und Core File Kit.',
        ),
        L(
          'I talk to partner developers directly, review their integration, debug it on real devices and stay with them until the app is live.',
          tr: 'Partner geliştiricilerle doğrudan çalışıyorum; entegrasyonlarını inceliyor, gerçek cihazlarda hata ayıklıyor ve uygulama yayına çıkana kadar destek veriyorum.',
          de: 'Ich stimme mich direkt mit den Entwicklern der Partner ab, prüfe ihre Integration, debugge auf echten Geräten und bleibe dran, bis die App live ist.',
        ),
        L(
          'I track down undocumented runtime behaviour on devices and feed the fixes back into the documentation developers actually read.',
          tr: 'Cihazlarda dokümante edilmemiş davranışları tespit edip düzeltmeleri geliştiricilerin okuduğu dokümantasyona geri kazandırıyorum.',
          de: 'Ich spüre undokumentiertes Laufzeitverhalten auf Geräten auf und lasse die Korrekturen in die Dokumentation einfließen, die Entwickler wirklich lesen.',
        ),
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
      title: L('Freelance Mobile Developer', tr: 'Freelance Mobil Geliştirici', de: 'Freiberuflicher Mobile Developer'),
      subtitle: L(
        'Independent client projects',
        tr: 'Bağımsız müşteri projeleri',
        de: 'Selbstständige Kundenprojekte',
      ),
      label: L.same('2024 — 2025'),
      summary: L(
        'Flutter apps from the first requirement to the store, with push notifications that keep drivers and operators up to date.',
        tr: 'İlk ihtiyaçtan mağazaya kadar Flutter uygulamaları; sürücüleri ve operasyon ekiplerini anlık bildirimlerle güncel tutan sistemler.',
        de: 'Flutter-Apps von der ersten Anforderung bis in den Store, mit Push-Benachrichtigungen für Fahrer und Disponenten.',
      ),
      overview: L(
        'I designed, built and shipped Flutter apps for logistics and transportation clients, each from the first requirement to the store release.',
        tr: 'Lojistik ve taşımacılık müşterileri için Flutter uygulamaları tasarlayıp geliştirdim ve yayına aldım; her birini ilk ihtiyaçtan mağaza yayınına kadar yürüttüm.',
        de: 'Für Kunden aus Logistik und Transport habe ich Flutter-Apps konzipiert, entwickelt und veröffentlicht, jeweils von der ersten Anforderung bis zum Store-Release.',
      ),
      points: [
        L(
          'Built push notification infrastructure with OneSignal and FCM for instant status updates and critical alerts in the field.',
          tr: 'Sahadaki ekiplere anlık durum güncellemeleri ve kritik uyarılar için OneSignal ve FCM ile bildirim altyapısı kurdum.',
          de: 'Push-Infrastruktur mit OneSignal und FCM für sofortige Statusmeldungen und kritische Hinweise im Außendienst aufgebaut.',
        ),
        L(
          'Ran versioning and staged rollouts, then handled feedback, crash reports and fixes after release.',
          tr: 'Sürüm yönetimini ve kademeli yayını yürüttüm; yayın sonrası geri bildirimleri, çökme raporlarını ve düzeltmeleri üstlendim.',
          de: 'Versionierung und Staged Rollouts verantwortet, nach dem Release Feedback, Crash-Reports und Bugfixes übernommen.',
        ),
        L(
          'Worked directly with clients on scope, timelines and maintenance.',
          tr: 'Kapsam, teslim takvimi ve bakım konularında müşterilerle doğrudan çalıştım.',
          de: 'Direkte Abstimmung mit Kunden zu Umfang, Zeitplan und Wartung.',
        ),
      ],
      tags: ['Flutter', 'Dart', 'OneSignal', 'FCM', 'Staged rollout'],
    ),
    Entry(
      slug: 'ibb',
      title: L('Mobile Developer Intern', tr: 'Mobil Geliştirici Stajyer', de: 'Praktikant Mobile Development'),
      subtitle: L(
        'Istanbul Metropolitan Municipality',
        tr: 'İstanbul Büyükşehir Belediyesi',
        de: 'Stadtverwaltung Istanbul (IBB)',
      ),
      label: L('Jul 2024 — Sep 2024', tr: 'Tem 2024 — Eyl 2024', de: 'Juli 2024 — Sept. 2024'),
      summary: L(
        'Built a Flutter app end to end with NFC, AI features and push notifications inside a public-sector release process.',
        tr: 'Kamu kurumu yayın süreçleri içinde NFC, yapay zekâ özellikleri ve bildirimler içeren bir Flutter uygulamasını baştan sona geliştirdim.',
        de: 'Eine Flutter-App mit NFC, KI-Funktionen und Push-Benachrichtigungen komplett umgesetzt, im Release-Prozess einer Behörde.',
      ),
      overview: L(
        'I contributed to Flutter development at the municipality and built one app end to end, from the first line to the release.',
        tr: 'Belediyede Flutter geliştirmeye katkı verdim ve bir uygulamayı ilk satırından yayınına kadar geliştirdim.',
        de: 'Ich habe bei der Stadtverwaltung an der Flutter-Entwicklung mitgearbeitet und eine App von der ersten Zeile bis zum Release umgesetzt.',
      ),
      points: [
        L(
          'Worked hands-on with NFC, AI-assisted features and push notification integration.',
          tr: 'NFC, yapay zekâ destekli özellikler ve bildirim entegrasyonu üzerinde bizzat çalıştım.',
          de: 'Praktische Arbeit mit NFC, KI-gestützten Funktionen und der Integration von Push-Benachrichtigungen.',
        ),
        L(
          'Learned corporate release processes, regulatory requirements and user data handling; used Git and wrote test scenarios.',
          tr: 'Kurumsal yayın süreçlerini, mevzuat gerekliliklerini ve kullanıcı verisinin nasıl ele alındığını öğrendim; Git kullandım, test senaryoları yazdım.',
          de: 'Einblick in Release-Prozesse, regulatorische Anforderungen und den Umgang mit Nutzerdaten; Arbeit mit Git und Testszenarien.',
        ),
      ],
      logo: 'assets/images/experience/ibb.png',
      tags: ['Flutter', 'Dart', 'NFC', 'Push notifications', 'Git'],
    ),
  ],
);
