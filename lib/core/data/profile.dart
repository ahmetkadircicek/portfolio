import 'package:portfolio/core/l10n/l10n.dart';

/// Everything the redesigned home page says about Ahmet besides the
/// projects, and the site-wide copy around it. Every sentence was confirmed
/// by him; add nothing that he has not.
class Profile {
  Profile._();

  static const name = 'Ahmet Kadir Çiçek';
  static const email = 'ahmetkadircicek@icloud.com';
  static const linkedin = 'https://linkedin.com/in/akadircicek';
  static const github = 'https://github.com/ahmetkadircicek';
  static const medium = 'https://medium.com/@akadircicek';
  static const source = 'https://github.com/ahmetkadircicek/portfolio';
  static const cv = '/ahmet-kadir-cicek-cv.pdf';

  // Hero: Dieter Rams' words, in English in every language.
  static const quote = ['Less,', 'but', 'better.'];
  static const quoteBy = '— Dieter Rams';

  /// The facts row at the bottom of the hero: label, value.
  static const facts = [
    (L('Role', tr: 'Rol'), L('Mobile Developer', tr: 'Mobil Geliştirici')),
    (L('Based in', tr: 'Konum'), L('Istanbul, Türkiye', tr: 'İstanbul, Türkiye')),
    (L('Currently', tr: 'Şu an'), L('Huawei Türkiye R&D Center', tr: 'Huawei Türkiye Ar-Ge Merkezi')),
  ];

  /// The intro under the hero: the first sentence in ink, the rest muted.
  static const intro = (
    L(
      'I like taking an app from a rough idea to a working product on my own: research, design and code.',
      tr: 'Bir uygulamayı ham bir fikirden çalışan bir ürüne tek başıma taşımayı seviyorum: araştırma, tasarım ve kod.',
    ),
    L(
      'I care most about the details of the interface.',
      tr: 'En çok arayüzün detaylarını önemsiyorum.',
    ),
  );

  // About: Huawei in two parts.
  static const huaweiLead = L(
    'At Huawei’s R&D Center my work has two parts: Health Kit, and supporting the teams that build with it, end to end.',
    tr: 'Huawei Ar-Ge Merkezi’nde işim iki parçadan oluşuyor: Health Kit ve onunla uygulama geliştiren ekiplere uçtan uca destek.',
  );
  static const huaweiParts = [
    (
      L('01 — Health Kit', tr: '01 — Health Kit'),
      L(
        'Health Service Kit for workout and health data on HarmonyOS watches, and Health Kit’s cloud REST APIs. I use both every day on real devices, and when they behave differently from the documentation, I get the docs corrected.',
        tr: 'HarmonyOS saatlerde antrenman ve sağlık verisi için Health Service Kit ve Health Kit’in bulut REST API’leri. İkisini de her gün gerçek cihazlarda kullanıyorum; dokümantasyondan farklı davrandıklarında dokümanların düzeltilmesini sağlıyorum.',
      ),
    ),
    (
      L('02 — End-to-end support', tr: '02 — Uçtan uca destek'),
      L(
        'I work with customer teams from their first integration to release: talking to their developers directly, reviewing their integration, debugging it on real devices and staying with them until their app is live.',
        tr: 'Müşteri ekipleriyle ilk entegrasyondan yayına kadar çalışıyorum: geliştiricileriyle doğrudan konuşuyor, entegrasyonlarını inceliyor, gerçek cihazlarda hata ayıklıyor ve uygulamaları yayına çıkana kadar yanlarında oluyorum.',
      ),
    ),
  ];

  /// Period, place, role.
  static const experience = [
    (L('Dec 2025 — Present', tr: 'Ara 2025 — Günümüz'), L('Huawei Türkiye R&D Center', tr: 'Huawei Türkiye Ar-Ge Merkezi'),
        L('Mobile Developer', tr: 'Mobil Geliştirici')),
    (L.same('2024 — 2025'), L('Freelance', tr: 'Freelance'), L('Mobile Developer', tr: 'Mobil Geliştirici')),
    (L('Jul — Sep 2024', tr: 'Tem — Eyl 2024'), L('Istanbul Metropolitan Municipality', tr: 'İstanbul Büyükşehir Belediyesi'),
        L('Mobile Software Intern', tr: 'Mobil Yazılım Stajyeri')),
  ];

  static const education = (
    L.same('2021 — 2025'),
    L.same('İstanbul Sabahattin Zaim University'),
    L('BSc Software Engineering', tr: 'Yazılım Mühendisliği, lisans'),
  );

  static const skills = [
    (L('Languages', tr: 'Diller'), 'Swift, Dart, TypeScript / ArkTS, JavaScript, Python'),
    (L.same('iOS'), 'SwiftUI, UIKit, Xcode'),
    (L.same('Cross-platform'), 'Flutter, Provider, MVVM'),
    (L.same('HarmonyOS'), 'ArkTS / ArkUI, HML/CSS/JS, DevEco Studio'),
    (L('Huawei kits', tr: 'Huawei kitleri'),
        'Wear Engine, Health Service Kit, Health Kit Cloud, Location Kit, Background Tasks'),
    (L('Backend & data', tr: 'Backend ve veri'), 'Firebase, REST, GraphQL, FCM, OneSignal'),
  ];
}

/// Interface text of the redesigned site.
class Copy {
  Copy._();

  // Navigation
  static const work = L('Work', tr: 'Projeler');
  static const about = L('About', tr: 'Hakkımda');
  static const contact = L('Contact', tr: 'İletişim');
  static const menu = L('Menu', tr: 'Menü');
  static const close = L('Close', tr: 'Kapat');
  static const cv = L('CV', tr: 'CV');
  static const downloadCv = L('Download CV', tr: 'CV’yi indir');
  static const toWork = L('Scroll to the work', tr: 'Projelere in');

  // Sections
  static const intro = L('Intro', tr: 'Giriş');
  static const workRange = L('Four apps, 2024 — 2025', tr: 'Dört uygulama, 2024 — 2025');
  static const aboutRange = L('Work, education, skills', tr: 'İş, eğitim, yetenekler');
  static const atHuawei = L('At Huawei', tr: 'Huawei’de');
  static const experience = L('Experience', tr: 'Deneyim');
  static const education = L('Education', tr: 'Eğitim');
  static const skills = L('Skills', tr: 'Yetenekler');
  static const viewProject = L('View project', tr: 'Projeyi gör');

  // Contact band and footer
  static const sayHello = L('Say hello.', tr: 'Merhaba de.');
  static const builtWith = L('Built with Flutter · Source', tr: 'Flutter ile yapıldı · Kaynak');
  static const top = L('Top', tr: 'Başa dön');

  // Project page
  static const role = L('Role', tr: 'Rol');
  static const platform = L('Platform', tr: 'Platform');
  static const status = L('Status', tr: 'Durum');
  static const stack = L('Stack', tr: 'Teknolojiler');
  static const screens = L('Screens', tr: 'Ekranlar');
  static const technology = L('Technology', tr: 'Teknoloji');
  static const nextProject = L('Next project', tr: 'Sonraki proje');
  static const backToStart = L('Back to the start', tr: 'Başa dön');
  static const openSource = L('open source', tr: 'açık kaynak');

  // Not found
  static const error404 = L('Error 404', tr: 'Hata 404');
  static const nothingHere = L('Nothing here.', tr: 'Burada bir şey yok.');
  static const notFoundBody = L('This page does not exist, or it has moved.', tr: 'Bu sayfa yok ya da taşındı.');
  static const backHome = L('Back to home', tr: 'Ana sayfaya dön');
  static const straightToProject = L('Or go straight to a project', tr: 'Ya da doğrudan bir projeye git');
}
