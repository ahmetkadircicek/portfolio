import 'package:portfolio/core/data/entry.dart';
import 'package:portfolio/core/l10n/l10n.dart';

/// Work history, newest first, taken from the CV. Adding an entry here adds
/// its row on the home page and its page at `/experience/<slug>`.
const experience = Collection(
  id: 'experience',
  title: L('Experience', tr: 'Deneyim'),
  entries: [
    Entry(
      slug: 'huawei',
      title: L('Mobile Developer', tr: 'Mobil Geliştirici'),
      subtitle: L('Huawei Türkiye R&D Center', tr: 'Huawei Türkiye Ar-Ge Merkezi'),
      label: L('Dec 2025 — Present', tr: 'Ara 2025 — Günümüz'),
      summary: L(
        'I build HarmonyOS watch apps in ArkTS and JS and stay with partner teams until their app is live.',
        tr: 'ArkTS ve JS ile HarmonyOS saat uygulamaları geliştiriyorum, partner ekiplerin uygulaması yayına çıkana kadar yanlarındayım.',
      ),
      overview: L(
        'I develop watch apps on both HarmonyOS platforms and support the partner teams building on them, from the first integration to the store release.',
        tr: 'İki HarmonyOS platformunda da saat uygulamaları geliştiriyorum. Bu platformlarda uygulama geliştiren partner ekipleri ilk entegrasyondan mağaza yayınına kadar destekliyorum.',
      ),
      points: [
        L(
          'Smart wearables in ArkTS with declarative ArkUI and the Stage model; lite wearables in HML/CSS/JS, which only runs a restricted ES6 subset.',
          tr: 'Akıllı saatler için deklaratif ArkUI ve Stage modeliyle ArkTS; lite saatler için yalnızca kısıtlı bir ES6 alt kümesini çalıştıran HML/CSS/JS.',
        ),
        L(
          'Kits I use and support every day: Wear Engine, Health Service Kit, Health Kit Cloud REST, Location Kit, Background Tasks and Core File Kit.',
          tr: 'Her gün kullandığım ve desteğini verdiğim kitler: Wear Engine, Health Service Kit, Health Kit Cloud REST, Location Kit, Background Tasks ve Core File Kit.',
        ),
        L(
          'I talk to partner developers directly, review their integration, debug it on real devices and stay with them until the app is live.',
          tr: 'Partner geliştiricilerle doğrudan çalışıyorum; entegrasyonlarını inceliyor, gerçek cihazlarda hata ayıklıyor ve uygulama yayına çıkana kadar destek veriyorum.',
        ),
        L(
          'I track down undocumented runtime behaviour on devices and feed the fixes back into the documentation developers actually read.',
          tr: 'Cihazlarda dokümante edilmemiş davranışları tespit edip düzeltmeleri geliştiricilerin okuduğu dokümantasyona geri kazandırıyorum.',
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
      title: L('Freelance Mobile Developer', tr: 'Freelance Mobil Geliştirici'),
      subtitle: L(
        'Independent client projects',
        tr: 'Bağımsız müşteri projeleri',
      ),
      label: L.same('2024 — 2025'),
      summary: L(
        'Flutter apps from the first requirement to the store, with push notifications that keep drivers and operators up to date.',
        tr: 'İlk ihtiyaçtan mağazaya kadar Flutter uygulamaları; sürücüleri ve operasyon ekiplerini anlık bildirimlerle güncel tutan sistemler.',
      ),
      overview: L(
        'I designed, built and shipped Flutter apps for logistics and transportation clients, each from the first requirement to the store release.',
        tr: 'Lojistik ve taşımacılık müşterileri için Flutter uygulamaları tasarlayıp geliştirdim ve yayına aldım; her birini ilk ihtiyaçtan mağaza yayınına kadar yürüttüm.',
      ),
      points: [
        L(
          'Built push notification infrastructure with OneSignal and FCM for instant status updates and critical alerts in the field.',
          tr: 'Sahadaki ekiplere anlık durum güncellemeleri ve kritik uyarılar için OneSignal ve FCM ile bildirim altyapısı kurdum.',
        ),
        L(
          'Ran versioning and staged rollouts, then handled feedback, crash reports and fixes after release.',
          tr: 'Sürüm yönetimini ve kademeli yayını yürüttüm; yayın sonrası geri bildirimleri, çökme raporlarını ve düzeltmeleri üstlendim.',
        ),
        L(
          'Worked directly with clients on scope, timelines and maintenance.',
          tr: 'Kapsam, teslim takvimi ve bakım konularında müşterilerle doğrudan çalıştım.',
        ),
      ],
      tags: ['Flutter', 'Dart', 'OneSignal', 'FCM', 'Staged rollout'],
    ),
    Entry(
      slug: 'ibb',
      title: L('Mobile Developer Intern', tr: 'Mobil Geliştirici Stajyer'),
      subtitle: L(
        'Istanbul Metropolitan Municipality',
        tr: 'İstanbul Büyükşehir Belediyesi',
      ),
      label: L('Jul 2024 — Sep 2024', tr: 'Tem 2024 — Eyl 2024'),
      summary: L(
        'Built a Flutter app end to end with NFC, AI features and push notifications inside a public-sector release process.',
        tr: 'Kamu kurumu yayın süreçleri içinde NFC, yapay zekâ özellikleri ve bildirimler içeren bir Flutter uygulamasını baştan sona geliştirdim.',
      ),
      overview: L(
        'I contributed to Flutter development at the municipality and built one app end to end, from the first line to the release.',
        tr: 'Belediyede Flutter geliştirmeye katkı verdim ve bir uygulamayı ilk satırından yayınına kadar geliştirdim.',
      ),
      points: [
        L(
          'Worked hands-on with NFC, AI-assisted features and push notification integration.',
          tr: 'NFC, yapay zekâ destekli özellikler ve bildirim entegrasyonu üzerinde bizzat çalıştım.',
        ),
        L(
          'Learned corporate release processes, regulatory requirements and user data handling; used Git and wrote test scenarios.',
          tr: 'Kurumsal yayın süreçlerini, mevzuat gerekliliklerini ve kullanıcı verisinin nasıl ele alındığını öğrendim; Git kullandım, test senaryoları yazdım.',
        ),
      ],
      logo: 'assets/images/experience/ibb.png',
      tags: ['Flutter', 'Dart', 'NFC', 'Push notifications', 'Git'],
    ),
  ],
);
