import 'package:portfolio/core/l10n/l10n.dart';

/// Every interface text of the site in all its languages. Content (projects,
/// experience) lives with its data; read either with `context.t(...)`.
class S {
  S._();

  // Identity
  static const role = L(
    'Cross-platform and native mobile developer',
    tr: 'Cross-platform ve native mobil geliştirici',
    de: 'Cross-Platform- und Native-Mobile-Developer',
  );
  static const pageTitleRole = L('Mobile Developer', tr: 'Mobil Geliştirici', de: 'Mobile Developer');

  // Splash
  static const hello = L(
    'Hi, I\'m Ahmet Kadir Çiçek.',
    tr: 'Merhaba, ben Ahmet Kadir Çiçek.',
    de: 'Hallo, ich bin Ahmet Kadir Çiçek.',
  );

  // Hero
  static const heroLine = L(
    'I build mobile apps that are easy to use and do their job well.',
    tr: 'Kullanımı kolay ve işini iyi yapan mobil uygulamalar geliştiriyorum.',
    de: 'Ich entwickle mobile Apps, die einfach zu bedienen sind und ihren Zweck erfüllen.',
  );
  static const downloadCv = L('Download CV', tr: 'CV\'yi indir', de: 'Lebenslauf herunterladen');
  static const techStack = L('Tech stack', tr: 'Teknolojiler', de: 'Tech-Stack');

  // What I do
  static const whatIDo = L('What I do', tr: 'Neler yapıyorum', de: 'Was ich mache');
  static const capabilities = [
    (
      L('Cross-platform apps', tr: 'Cross-platform uygulamalar', de: 'Cross-Platform-Apps'),
      L(
        'Android and iOS from one Flutter codebase, structured with MVVM and Provider.',
        tr: 'Tek Flutter kod tabanından Android ve iOS, MVVM ve Provider ile.',
        de: 'Android und iOS aus einer Flutter-Codebasis, strukturiert mit MVVM und Provider.',
      ),
      'Flutter · Dart · Provider · MVVM',
    ),
    (
      L('Native iOS', tr: 'Native iOS', de: 'Native iOS'),
      L(
        'Swift apps with UIKit, Storyboard and Auto Layout, following Apple\'s guidelines.',
        tr: 'UIKit, Storyboard ve Auto Layout ile, Apple\'ın rehberlerine uygun Swift uygulamaları.',
        de: 'Swift-Apps mit UIKit, Storyboard und Auto Layout, nach Apples Richtlinien.',
      ),
      'Swift · UIKit · Lottie · Alamofire',
    ),
    (
      L('Backend & integrations', tr: 'Backend ve entegrasyonlar', de: 'Backend & Integrationen'),
      L(
        'Cloud data, sign-in, AI services, NFC and monetisation, wired into the app.',
        tr: 'Bulut veri, kimlik doğrulama, yapay zekâ servisleri, NFC ve gelir modelleri.',
        de: 'Cloud-Daten, Login, KI-Dienste, NFC und Monetarisierung, sauber in die App integriert.',
      ),
      'Firebase · REST API · OAuth · Gemini AI · AdMob',
    ),
    (
      L('Product design', tr: 'Ürün tasarımı', de: 'Produktdesign'),
      L(
        'Research and interface design before the first line of code.',
        tr: 'İlk satır koddan önce araştırma ve arayüz tasarımı.',
        de: 'Recherche und UI-Design, bevor die erste Zeile Code entsteht.',
      ),
      'Figma · Photoshop · Illustrator · Blender',
    ),
  ];

  // Home sections and entry pages
  static L show(String what) => L('Show $what', tr: '$what göster', de: '$what anzeigen');
  static L all(L collection) => L('All ${collection.en.toLowerCase()}', tr: collection.tr, de: collection.de);
  static const highlights = L('Highlights', tr: 'Öne çıkanlar', de: 'Highlights');
  static const nextImage = L('Show next image', tr: 'Sonraki görsel', de: 'Nächstes Bild');

  // Closing block
  static const ctaEyebrow = L('Have an app in mind?', tr: 'Aklınızda bir uygulama mı var?', de: 'Eine App-Idee?');
  static const ctaTitle = L('LET\'S MAKE IT SIMPLE', tr: 'GELİN SADE TUTALIM', de: 'MACHEN WIR ES EINFACH');
  static const ctaBody = L(
    'Tell me about your project and I\'ll get back to you soon.',
    tr: 'Projenizi anlatın, en kısa sürede size dönüş yapayım.',
    de: 'Erzählen Sie mir von Ihrem Projekt, ich melde mich zeitnah.',
  );
  static const requestProject = L('Request a project', tr: 'Proje talebi', de: 'Projekt anfragen');
  static const backToTop = L('Back to top', tr: 'Başa dön', de: 'Nach oben');

  // Contact
  static const contact = L('Contact', tr: 'İletişim', de: 'Kontakt');
  static const contactTitle = L('REQUEST A PROJECT', tr: 'PROJE TALEBİ', de: 'PROJEKT ANFRAGEN');
  static const contactBody = L(
    'Fill out the form and I\'ll get back to you as soon as I can.',
    tr: 'Formu doldurun, en kısa sürede size dönüş yapayım.',
    de: 'Füllen Sie das Formular aus, ich melde mich so schnell wie möglich.',
  );
  static const thanksTitle = L('THANK YOU!', tr: 'TEŞEKKÜRLER!', de: 'DANKE!');
  static const thanksBody = L(
    'Your message is on its way. I\'ll get back to you soon.',
    tr: 'Mesajınız ulaştı. En kısa sürede size dönüş yapacağım.',
    de: 'Ihre Nachricht ist angekommen. Ich melde mich bald bei Ihnen.',
  );
  static const name = L('Name', tr: 'Ad soyad', de: 'Name');
  static const nameHint = L('Your full name', tr: 'Adınız ve soyadınız', de: 'Vor- und Nachname');
  static const email = L('Email', tr: 'E-posta', de: 'E-Mail');
  static const subject = L('Subject', tr: 'Konu', de: 'Betreff');
  static const subjectHint = L('What is it about?', tr: 'Ne hakkında?', de: 'Worum geht es?');
  static const message = L('Message', tr: 'Mesaj', de: 'Nachricht');
  static const messageHint = L('Write your message here…', tr: 'Mesajınızı buraya yazın…', de: 'Ihre Nachricht…');
  static const send = L('Send message', tr: 'Gönder', de: 'Nachricht senden');
  static const sent = L('Message sent', tr: 'Mesaj gönderildi', de: 'Nachricht gesendet');
  static const sendAnother = L('Send another message', tr: 'Yeni mesaj gönder', de: 'Weitere Nachricht senden');

  // Form validation
  static const nameEmpty =
      L('Please enter your name', tr: 'Lütfen adınızı girin', de: 'Bitte geben Sie Ihren Namen ein');
  static L nameLong(int max) =>
      L('Name can be at most $max characters', tr: 'Ad en fazla $max karakter olabilir', de: 'Höchstens $max Zeichen');
  static const emailEmpty = L('Please enter your email',
      tr: 'Lütfen e-posta adresinizi girin', de: 'Bitte geben Sie Ihre E-Mail-Adresse ein');
  static const emailInvalid = L(
    'Please enter a valid email address',
    tr: 'Lütfen geçerli bir e-posta adresi girin',
    de: 'Bitte geben Sie eine gültige E-Mail-Adresse ein',
  );
  static L emailLong(int max) => L('Email can be at most $max characters',
      tr: 'E-posta en fazla $max karakter olabilir', de: 'Höchstens $max Zeichen');
  static const subjectEmpty =
      L('Please enter a subject', tr: 'Lütfen bir konu girin', de: 'Bitte geben Sie einen Betreff ein');
  static L subjectLong(int max) => L('Subject can be at most $max characters',
      tr: 'Konu en fazla $max karakter olabilir', de: 'Höchstens $max Zeichen');
  static const messageEmpty =
      L('Please enter your message', tr: 'Lütfen mesajınızı yazın', de: 'Bitte geben Sie Ihre Nachricht ein');
  static const messageShort = L(
    'Message should be at least 10 characters',
    tr: 'Mesaj en az 10 karakter olmalı',
    de: 'Die Nachricht sollte mindestens 10 Zeichen haben',
  );
  static L messageLong(int max) => L('Message can be at most $max characters',
      tr: 'Mesaj en fazla $max karakter olabilir', de: 'Höchstens $max Zeichen');
  static const sendFailed = L(
    'Your message could not be sent. Please try again in a moment.',
    tr: 'Mesajınız gönderilemedi. Lütfen biraz sonra tekrar deneyin.',
    de: 'Die Nachricht konnte nicht gesendet werden. Bitte versuchen Sie es gleich noch einmal.',
  );

  // Not found
  static const notFound = L('Page not found', tr: 'Sayfa bulunamadı', de: 'Seite nicht gefunden');
  static const notFoundBody =
      L('This page does not exist.', tr: 'Bu sayfa mevcut değil.', de: 'Diese Seite gibt es nicht.');
  static const backHome = L('Back to home', tr: 'Ana sayfaya dön', de: 'Zur Startseite');

  // Header
  static const home = L('Home', tr: 'Ana sayfa', de: 'Startseite');
  static const freelance = L('Freelance', tr: 'Freelance', de: 'Freiberuflich');
  static const toLight = L('Switch to light mode', tr: 'Açık temaya geç', de: 'Zum hellen Modus wechseln');
  static const toDark = L('Switch to dark mode', tr: 'Koyu temaya geç', de: 'Zum dunklen Modus wechseln');
  static const language = L('Language', tr: 'Dil', de: 'Sprache');
}
