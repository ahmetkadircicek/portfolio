import 'package:portfolio/core/l10n/l10n.dart';

/// Every interface text of the site in all its languages. Content (projects,
/// experience) lives with its data; read either with `context.t(...)`.
class S {
  S._();

  // Identity
  static const role = L(
    'Cross-platform and native mobile developer',
    tr: 'Cross-platform ve native mobil geliştirici',
  );
  static const pageTitleRole = L('Mobile Developer', tr: 'Mobil Geliştirici');

  // Splash
  static const hello = L(
    'Hi, I\'m Ahmet Kadir Çiçek.',
    tr: 'Merhaba, ben Ahmet Kadir Çiçek.',
  );

  // Hero
  static const heroLine = L(
    'I build mobile apps that are easy to use and do their job well.',
    tr: 'Kullanımı kolay ve işini iyi yapan mobil uygulamalar geliştiriyorum.',
  );
  static const downloadCv = L('Download CV', tr: 'CV\'yi indir');
  static const techStack = L('Tech stack', tr: 'Teknolojiler');

  // What I do
  static const whatIDo = L('What I do', tr: 'Neler yapıyorum');
  static const capabilities = [
    (
      L('Cross-platform apps', tr: 'Cross-platform uygulamalar'),
      L(
        'Android and iOS from one Flutter codebase, structured with MVVM and Provider.',
        tr: 'Tek Flutter kod tabanından Android ve iOS, MVVM ve Provider ile.',
      ),
      'Flutter · Dart · Provider · MVVM',
    ),
    (
      L('Native iOS', tr: 'Native iOS'),
      L(
        'Swift apps with UIKit, Storyboard and Auto Layout, following Apple\'s guidelines.',
        tr: 'UIKit, Storyboard ve Auto Layout ile, Apple\'ın rehberlerine uygun Swift uygulamaları.',
      ),
      'Swift · UIKit · Lottie · Alamofire',
    ),
    (
      L('Backend & integrations', tr: 'Backend ve entegrasyonlar'),
      L(
        'Cloud data, sign-in, AI services, NFC and monetisation, wired into the app.',
        tr: 'Bulut veri, kimlik doğrulama, yapay zekâ servisleri, NFC ve gelir modelleri.',
      ),
      'Firebase · REST API · OAuth · Gemini AI · AdMob',
    ),
    (
      L('Product design', tr: 'Ürün tasarımı'),
      L(
        'Research and interface design before the first line of code.',
        tr: 'İlk satır koddan önce araştırma ve arayüz tasarımı.',
      ),
      'Figma · Photoshop · Illustrator · Blender',
    ),
  ];

  // Home sections and entry pages
  static L show(String what) => L('Show $what', tr: '$what göster');
  static L all(L collection) => L('All ${collection.en.toLowerCase()}', tr: collection.tr);
  static const highlights = L('Highlights', tr: 'Öne çıkanlar');
  static const nextImage = L('Show next image', tr: 'Sonraki görsel');

  // Closing block
  static const ctaEyebrow = L('Have an app in mind?', tr: 'Aklınızda bir uygulama mı var?');
  static const ctaTitle = L('LET\'S MAKE IT SIMPLE', tr: 'GELİN SADE TUTALIM');
  static const ctaBody = L(
    'Tell me about your project and I\'ll get back to you soon.',
    tr: 'Projenizi anlatın, en kısa sürede size dönüş yapayım.',
  );
  static const requestProject = L('Request a project', tr: 'Proje talebi');
  static const backToTop = L('Back to top', tr: 'Başa dön');

  // Contact
  static const contact = L('Contact', tr: 'İletişim');
  static const contactTitle = L('REQUEST A PROJECT', tr: 'PROJE TALEBİ');
  static const contactBody = L(
    'Fill out the form and I\'ll get back to you as soon as I can.',
    tr: 'Formu doldurun, en kısa sürede size dönüş yapayım.',
  );
  static const thanksTitle = L('THANK YOU!', tr: 'TEŞEKKÜRLER!');
  static const thanksBody = L(
    'Your message is on its way. I\'ll get back to you soon.',
    tr: 'Mesajınız ulaştı. En kısa sürede size dönüş yapacağım.',
  );
  static const name = L('Name', tr: 'Ad soyad');
  static const nameHint = L('Your full name', tr: 'Adınız ve soyadınız');
  static const email = L('Email', tr: 'E-posta');
  static const subject = L('Subject', tr: 'Konu');
  static const subjectHint = L('What is it about?', tr: 'Ne hakkında?');
  static const message = L('Message', tr: 'Mesaj');
  static const messageHint = L('Write your message here…', tr: 'Mesajınızı buraya yazın…');
  static const send = L('Send message', tr: 'Gönder');
  static const sent = L('Message sent', tr: 'Mesaj gönderildi');
  static const sendAnother = L('Send another message', tr: 'Yeni mesaj gönder');

  // Form validation
  static const nameEmpty =
      L('Please enter your name', tr: 'Lütfen adınızı girin');
  static L nameLong(int max) =>
      L('Name can be at most $max characters', tr: 'Ad en fazla $max karakter olabilir');
  static const emailEmpty = L('Please enter your email',
      tr: 'Lütfen e-posta adresinizi girin');
  static const emailInvalid = L(
    'Please enter a valid email address',
    tr: 'Lütfen geçerli bir e-posta adresi girin',
  );
  static L emailLong(int max) => L('Email can be at most $max characters',
      tr: 'E-posta en fazla $max karakter olabilir');
  static const subjectEmpty =
      L('Please enter a subject', tr: 'Lütfen bir konu girin');
  static L subjectLong(int max) => L('Subject can be at most $max characters',
      tr: 'Konu en fazla $max karakter olabilir');
  static const messageEmpty =
      L('Please enter your message', tr: 'Lütfen mesajınızı yazın');
  static const messageShort = L(
    'Message should be at least 10 characters',
    tr: 'Mesaj en az 10 karakter olmalı',
  );
  static L messageLong(int max) => L('Message can be at most $max characters',
      tr: 'Mesaj en fazla $max karakter olabilir');
  static const sendFailed = L(
    'Your message could not be sent. Please try again in a moment.',
    tr: 'Mesajınız gönderilemedi. Lütfen biraz sonra tekrar deneyin.',
  );

  // Not found
  static const notFound = L('Page not found', tr: 'Sayfa bulunamadı');
  static const notFoundBody =
      L('This page does not exist.', tr: 'Bu sayfa mevcut değil.');
  static const backHome = L('Back to home', tr: 'Ana sayfaya dön');

  // Header
  static const home = L('Home', tr: 'Ana sayfa');
  static const freelance = L('Freelance', tr: 'Freelance');
  static const toLight = L('Switch to light mode', tr: 'Açık temaya geç');
  static const toDark = L('Switch to dark mode', tr: 'Koyu temaya geç');
  static const language = L('Language', tr: 'Dil');
}
