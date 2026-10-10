import 'package:flutter/painting.dart';
import 'package:portfolio/core/data/entry.dart';
import 'package:portfolio/core/l10n/l10n.dart';

/// Every project on the site, in page order. Adding an entry here adds its
/// row on the home page and its page at `/projects/<slug>`.
const projects = Collection(
  id: 'projects',
  title: L('Projects', tr: 'Projeler', de: 'Projekte'),
  collapsedOnPhones: true,
  entries: [
    Entry(
      slug: 'tunes',
      title: L.same('Tunes.AI'),
      subtitle: L('AI music platform', tr: 'Yapay zekâ destekli müzik platformu', de: 'KI-gestützte Musikplattform'),
      summary: L(
        'A music app that creates songs and playlists with AI, built from scratch with Flutter and Firebase.',
        tr: 'Yapay zekâyla şarkı ve çalma listesi oluşturan, Flutter ve Firebase ile sıfırdan geliştirdiğim bir müzik uygulaması.',
        de: 'Eine Musik-App, die mit KI Songs und Playlists erstellt, von Grund auf mit Flutter und Firebase entwickelt.',
      ),
      overview: L(
        'Tunes.AI is a music app I built from scratch with Flutter and Firebase. It creates playlists from your listening habits and generates songs that fit your mood. I took it from idea to release on my own: three weeks of market research, two of UI/UX design, five of building the MVP, then feature work, testing and performance tuning. I also added Google AdMob, which taught me a lot about how apps actually earn money.',
        tr: 'Tunes.AI, Flutter ve Firebase ile sıfırdan geliştirdiğim bir müzik uygulaması. Dinleme alışkanlıklarına göre çalma listeleri hazırlıyor, ruh haline uygun şarkılar üretiyor. Fikirden yayına kadar her aşamayı tek başıma yürüttüm: üç hafta pazar araştırması, iki hafta UI/UX tasarımı, beş hafta MVP geliştirme, ardından yeni özellikler, test ve performans iyileştirmeleri. Google AdMob entegrasyonu da bir uygulamanın gerçekte nasıl gelir elde ettiği konusunda bana çok şey öğretti.',
        de: 'Tunes.AI ist eine Musik-App, die ich von Grund auf mit Flutter und Firebase entwickelt habe. Sie stellt Playlists nach den eigenen Hörgewohnheiten zusammen und erzeugt Songs passend zur Stimmung. Von der Idee bis zum Release habe ich alles selbst umgesetzt: drei Wochen Marktrecherche, zwei Wochen UI/UX-Design, fünf Wochen MVP-Entwicklung, danach Features, Tests und Performance-Optimierung. Die Integration von Google AdMob hat mir gezeigt, wie Apps tatsächlich Umsatz machen.',
      ),
      label: L('Music', tr: 'Müzik', de: 'Musik'),
      logo: 'assets/images/tunes/tunes_logo.webp',
      facts: [EntryFact.ideaToRelease, EntryFact.solo, EntryFact.androidAndIos],
      tags: ['Flutter', 'Dart', 'Firebase', 'Provider', 'MVVM', 'Figma', 'Replicate', 'REST API', 'Google AdMob'],
      statuses: [EntryStatus.readyToRelease],
      highlights: [
        Highlight(
          title: L('Personal', tr: 'Kişisel', de: 'Persönlich'),
          description: L(
            'AI-generated songs shaped by your taste and mood.',
            tr: 'Zevkine ve ruh haline göre yapay zekâyla üretilen şarkılar.',
            de: 'KI-generierte Songs, abgestimmt auf Geschmack und Stimmung.',
          ),
          label: L('AI creation', tr: 'Yapay zekâ ile üretim', de: 'KI-Erstellung'),
          image: 'assets/images/tunes/image_mockup_tunes_01.webp',
          colors: [Color(0xFFFE6C11), Color(0xFFC63B08)],
        ),
        Highlight(
          title: L('Smooth playback', tr: 'Kesintisiz çalma', de: 'Flüssige Wiedergabe'),
          description: L(
            'A custom AudioManager and fast streaming keep the music going without gaps.',
            tr: 'Özel bir AudioManager ve hızlı akış sayesinde müzik kesintisiz çalıyor.',
            de: 'Ein eigener AudioManager und schnelles Streaming sorgen für Musik ohne Unterbrechung.',
          ),
          label: L('Playback', tr: 'Oynatma', de: 'Wiedergabe'),
          image: 'assets/images/tunes/image_mockup_tunes_02.webp',
        ),
        Highlight(
          title: L('Cloud storage', tr: 'Bulut depolama', de: 'Cloud-Speicher'),
          description: L(
            'Firebase stores the library and a cache opens your favourite tracks instantly.',
            tr: 'Kütüphane Firebase\'de duruyor, önbellek sayesinde favori parçalar anında açılıyor.',
            de: 'Firebase speichert die Bibliothek, ein Cache öffnet Lieblingstitel sofort.',
          ),
          label: L('Storage', tr: 'Depolama', de: 'Speicher'),
          image: 'assets/images/tunes/image_mockup_tunes_03.webp',
        ),
        Highlight(
          title: L('Simple interface', tr: 'Sade arayüz', de: 'Klare Oberfläche'),
          description: L(
            'A minimal design that stays out of the way of the music.',
            tr: 'Müziğin önüne geçmeyen, sade bir tasarım.',
            de: 'Ein minimales Design, das der Musik den Vortritt lässt.',
          ),
          label: L('Interface', tr: 'Arayüz', de: 'Oberfläche'),
          image: 'assets/images/tunes/image_mockup_tunes_04.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı', de: 'Startbildschirm'),
          description: L(
            'The Tunes wordmark while the app gets ready.',
            tr: 'Uygulama hazırlanırken Tunes logosu.',
            de: 'Das Tunes-Logo, während die App lädt.',
          ),
          label: L('Start', tr: 'Başlangıç', de: 'Start'),
          image: 'assets/images/tunes/tunes_screenshots_1.webp',
        ),
        Highlight(
          title: L('Create your music', tr: 'Müziğini oluştur', de: 'Eigene Musik erstellen'),
          description: L(
            'Choose a length, name your melody and start a new track.',
            tr: 'Süreyi seç, melodine bir isim ver ve yeni parçaya başla.',
            de: 'Länge wählen, Melodie benennen und einen neuen Track starten.',
          ),
          label: L('Create', tr: 'Oluştur', de: 'Erstellen'),
          image: 'assets/images/tunes/tunes_screenshots_8.webp',
        ),
        Highlight(
          title: L('Pick a key', tr: 'Ton seç', de: 'Tonart wählen'),
          description: L(
            'The key sets the overall feel of the track, from C minor to G major.',
            tr: 'Ton, parçanın genel havasını belirliyor; Do minörden Sol majöre kadar.',
            de: 'Die Tonart bestimmt die Stimmung des Tracks, von c-Moll bis G-Dur.',
          ),
          label: L('Key setting', tr: 'Ton ayarı', de: 'Tonart'),
          image: 'assets/images/tunes/tunes_screenshots_4.webp',
        ),
        Highlight(
          title: L('Generating', tr: 'Hazırlanıyor', de: 'Wird erstellt'),
          description: L(
            'The AI works on the track while you browse your other songs.',
            tr: 'Yapay zekâ parçayı hazırlarken diğer şarkılarına göz atabilirsin.',
            de: 'Die KI erstellt den Track, währenddessen lassen sich andere Songs anhören.',
          ),
          label: L('AI at work', tr: 'Yapay zekâ çalışıyor', de: 'KI arbeitet'),
          image: 'assets/images/tunes/tunes_screenshots_6.webp',
        ),
        Highlight(
          title: L('Player', tr: 'Oynatıcı', de: 'Player'),
          description: L(
            'Cover, genre, key and simple playback controls.',
            tr: 'Kapak, tür, ton ve sade oynatma kontrolleri.',
            de: 'Cover, Genre, Tonart und einfache Wiedergabesteuerung.',
          ),
          label: L('Playback', tr: 'Oynatma', de: 'Wiedergabe'),
          image: 'assets/images/tunes/tunes_screenshots_3.webp',
        ),
        Highlight(
          title: L('History', tr: 'Geçmiş', de: 'Verlauf'),
          description: L(
            'Every track you created, with its genre and key.',
            tr: 'Oluşturduğun tüm parçalar, türü ve tonuyla birlikte.',
            de: 'Alle erstellten Tracks mit Genre und Tonart.',
          ),
          label: L('Library', tr: 'Kitaplık', de: 'Bibliothek'),
          image: 'assets/images/tunes/tunes_screenshots_2.webp',
        ),
        Highlight(
          title: L('Three languages', tr: 'Üç dil', de: 'Drei Sprachen'),
          description: L(
            'Settings with appearance options and English, Turkish and German.',
            tr: 'Görünüm seçenekleri ve İngilizce, Türkçe, Almanca dil desteğiyle ayarlar.',
            de: 'Einstellungen mit Darstellungsoptionen und Englisch, Türkisch und Deutsch.',
          ),
          label: L('Settings', tr: 'Ayarlar', de: 'Einstellungen'),
          image: 'assets/images/tunes/tunes_screenshots_7.webp',
        ),
        Highlight(
          title: L('AdMob', tr: 'AdMob', de: 'AdMob'),
          description: L(
            'Interstitial ads through Google AdMob, shown here in test mode.',
            tr: 'Google AdMob ile geçiş reklamları; burada test modunda.',
            de: 'Interstitial-Anzeigen über Google AdMob, hier im Testmodus.',
          ),
          label: L('Monetisation', tr: 'Gelir modeli', de: 'Monetarisierung'),
          image: 'assets/images/tunes/tunes_screenshots_5.webp',
        ),
      ],
    ),
    Entry(
      slug: 'vilsa',
      title: L.same('Vilsa'),
      subtitle: L('Stock portfolio tracker', tr: 'Borsa portföy takibi', de: 'Aktien-Portfolio-Tracker'),
      summary: L(
        'A Flutter app for tracking stock portfolios across markets, with dividend tracking.',
        tr: 'Farklı borsalardaki hisseleri ve temettüleri takip etmek için geliştirdiğim bir Flutter uygulaması.',
        de: 'Eine Flutter-App, um Aktien aus verschiedenen Märkten samt Dividenden im Blick zu behalten.',
      ),
      overview: L(
        'Vilsa is a portfolio tracker I built with Flutter. You choose which markets to follow and add stocks from each of them. It records past dividends and estimates upcoming ones, runs daily, weekly, monthly or quarterly reviews of the portfolio, and lets you arrange the dashboard with your own widgets, watchlists and alerts.',
        tr: 'Vilsa, Flutter ile geliştirdiğim bir portföy takip uygulaması. Takip etmek istediğin borsaları seçip hisselerini ekliyorsun. Geçmiş temettüleri kaydediyor ve gelecek ödemeleri tahmin ediyor; portföyü günlük, haftalık, aylık ya da çeyreklik olarak değerlendiriyor. Ana ekranı da kendi widget\'ların, izleme listelerin ve alarmlarınla düzenleyebiliyorsun.',
        de: 'Vilsa ist ein Portfolio-Tracker, den ich mit Flutter entwickelt habe. Man wählt die Börsen, die man verfolgen möchte, und fügt Aktien hinzu. Die App erfasst vergangene Dividenden, schätzt künftige Ausschüttungen, wertet das Depot täglich, wöchentlich, monatlich oder quartalsweise aus und lässt sich mit eigenen Widgets, Watchlists und Alarmen anpassen.',
      ),
      label: L('Finance', tr: 'Finans', de: 'Finanzen'),
      logo: 'assets/images/vilsa/vilsa_logo.webp',
      facts: [EntryFact.ideaToRelease, EntryFact.solo, EntryFact.androidAndIos],
      tags: ['Flutter', 'Dart', 'Firebase', 'Provider', 'MVVM', 'Figma', 'Charts'],
      statuses: [EntryStatus.readyToRelease],
      link: EntryLink.github('https://github.com/ahmetkadircicek/vilsa'),
      highlights: [
        Highlight(
          title: L('Your markets', tr: 'Senin borsaların', de: 'Eigene Märkte'),
          description: L(
            'Pick the exchanges you care about and add stocks from each.',
            tr: 'İlgilendiğin borsaları seç, her birinden hisse ekle.',
            de: 'Die gewünschten Börsen auswählen und Aktien daraus hinzufügen.',
          ),
          label: L('Markets', tr: 'Borsalar', de: 'Märkte'),
          image: 'assets/images/vilsa/image_mockup_vilsa_01.webp',
          colors: [Color(0xFF5908FA), Color(0xFF9829E9)],
        ),
        Highlight(
          title: L('Dividends', tr: 'Temettüler', de: 'Dividenden'),
          description: L(
            'A record of past dividends and an estimate of the ones to come.',
            tr: 'Geçmiş temettülerin kaydı ve gelecek ödemelerin tahmini.',
            de: 'Vergangene Dividenden im Überblick, künftige als Prognose.',
          ),
          label: L('Income', tr: 'Gelir', de: 'Erträge'),
          image: 'assets/images/vilsa/image_mockup_vilsa_02.webp',
        ),
        Highlight(
          title: L('Regular reviews', tr: 'Düzenli analiz', de: 'Regelmäßige Analyse'),
          description: L(
            'Daily, weekly, monthly or quarterly looks at how the portfolio is doing.',
            tr: 'Portföyün durumuna günlük, haftalık, aylık ya da çeyreklik bakış.',
            de: 'Tägliche, wöchentliche, monatliche oder quartalsweise Auswertung des Depots.',
          ),
          label: L('Analysis', tr: 'Analiz', de: 'Analyse'),
          image: 'assets/images/vilsa/image_mockup_vilsa_03.webp',
        ),
        Highlight(
          title: L('Your dashboard', tr: 'Senin ekranın', de: 'Eigenes Dashboard'),
          description: L(
            'Widgets, watchlists and alerts arranged the way you invest.',
            tr: 'Widget\'lar, izleme listeleri ve alarmlar, yatırım tarzına göre.',
            de: 'Widgets, Watchlists und Alarme, passend zur eigenen Strategie.',
          ),
          label: L('Customisation', tr: 'Kişiselleştirme', de: 'Anpassung'),
          image: 'assets/images/vilsa/image_mockup_vilsa_04.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı', de: 'Startbildschirm'),
          description: L(
            'Vilsa, financial management.',
            tr: 'Vilsa, finansal yönetim.',
            de: 'Vilsa, Finanzverwaltung.',
          ),
          label: L('Start', tr: 'Başlangıç', de: 'Start'),
          image: 'assets/images/vilsa/vilsa_screenshots_1.webp',
        ),
        Highlight(
          title: L('Portfolio at a glance', tr: 'Bir bakışta portföy', de: 'Depot auf einen Blick'),
          description: L(
            'Total balance, dividends and a line chart of the chosen period.',
            tr: 'Toplam bakiye, temettüler ve seçilen döneme ait çizgi grafik.',
            de: 'Gesamtsaldo, Dividenden und ein Liniendiagramm für den gewählten Zeitraum.',
          ),
          label: L('Home', tr: 'Ana sayfa', de: 'Startseite'),
          image: 'assets/images/vilsa/vilsa_screenshots_6.webp',
        ),
        Highlight(
          title: L('Bar chart', tr: 'Sütun grafik', de: 'Balkendiagramm'),
          description: L(
            'The same period as bars, one tap away.',
            tr: 'Aynı dönem, tek dokunuşla sütun grafikte.',
            de: 'Derselbe Zeitraum als Balken, mit einem Tipp.',
          ),
          label: L('Charts', tr: 'Grafikler', de: 'Diagramme'),
          image: 'assets/images/vilsa/vilsa_screenshots_7.webp',
        ),
        Highlight(
          title: L('Sort and filter', tr: 'Sırala ve filtrele', de: 'Sortieren und filtern'),
          description: L(
            'Sort holdings by name, quantity, total value or average price.',
            tr: 'Hisseleri ada, adede, toplam değere ya da ortalama fiyata göre sırala.',
            de: 'Positionen nach Name, Stückzahl, Gesamtwert oder Durchschnittspreis sortieren.',
          ),
          label: L('Holdings', tr: 'Hisseler', de: 'Positionen'),
          image: 'assets/images/vilsa/vilsa_screenshots_5.webp',
        ),
        Highlight(
          title: L('Stock details', tr: 'Hisse detayı', de: 'Aktiendetails'),
          description: L(
            'Cost, average price, dividend yield and every transaction for one stock.',
            tr: 'Bir hissenin maliyeti, ortalama fiyatı, temettü verimi ve tüm işlemleri.',
            de: 'Kosten, Durchschnittspreis, Dividendenrendite und alle Transaktionen einer Aktie.',
          ),
          label: L('Detail', tr: 'Detay', de: 'Detail'),
          image: 'assets/images/vilsa/vilsa_screenshots_4.webp',
        ),
        Highlight(
          title: L('Add a transaction', tr: 'İşlem ekle', de: 'Transaktion hinzufügen'),
          description: L(
            'Date, buy price, quantity, dividend and a note.',
            tr: 'Tarih, alış fiyatı, adet, temettü ve not.',
            de: 'Datum, Kaufpreis, Stückzahl, Dividende und Notiz.',
          ),
          label: L('Transactions', tr: 'İşlemler', de: 'Transaktionen'),
          image: 'assets/images/vilsa/vilsa_screenshots_3.webp',
        ),
        Highlight(
          title: L('Date range', tr: 'Tarih aralığı', de: 'Zeitraum'),
          description: L(
            'Pick any range and every figure follows it.',
            tr: 'Bir aralık seç, tüm rakamlar ona göre güncellensin.',
            de: 'Beliebigen Zeitraum wählen, alle Zahlen passen sich an.',
          ),
          label: L('Period', tr: 'Dönem', de: 'Zeitraum'),
          image: 'assets/images/vilsa/vilsa_screenshots_2.webp',
        ),
      ],
    ),
    Entry(
      slug: 'sevkiyatvar',
      title: L.same('Sevkiyatvar'),
      subtitle: L('Logistics platform', tr: 'Lojistik yönetim platformu', de: 'Logistikplattform'),
      summary: L(
        'An existing logistics app that I rebuilt in Flutter with a clearer interface for drivers and dispatchers.',
        tr: 'Mevcut bir lojistik uygulamasını sürücüler ve operasyon ekipleri için daha anlaşılır bir arayüzle Flutter\'da yeniden geliştirdim.',
        de: 'Eine bestehende Logistik-App, die ich in Flutter mit einer klareren Oberfläche für Fahrer und Disponenten neu aufgebaut habe.',
      ),
      overview: L(
        'Sevkiyatvar is a modernisation project I led for a logistics company. Users found the old app dated and hard to use, so I rebuilt it in Flutter with a cleaner flow while keeping the business logic they already knew. I split the legacy code into reusable components and moved state management to Provider. The result is a faster, clearer app for both drivers and dispatchers.',
        tr: 'Sevkiyatvar, bir lojistik firması için yürüttüğüm bir modernizasyon projesi. Kullanıcılar eski uygulamayı eski moda ve kullanımı zor buluyordu. Uygulamayı, alıştıkları iş mantığını koruyarak daha sade bir akışla Flutter\'da yeniden geliştirdim. Eski kodu yeniden kullanılabilir bileşenlere ayırdım, state yönetimini Provider\'a taşıdım. Sonuçta hem sürücüler hem operasyon ekibi için daha hızlı ve anlaşılır bir uygulama çıktı.',
        de: 'Sevkiyatvar ist ein Modernisierungsprojekt, das ich für ein Logistikunternehmen geleitet habe. Die alte App galt als veraltet und umständlich, also habe ich sie in Flutter mit klareren Abläufen neu gebaut und die gewohnte Geschäftslogik beibehalten. Den Legacy-Code habe ich in wiederverwendbare Komponenten zerlegt und das State-Management auf Provider umgestellt. Heraus kam eine schnellere, übersichtlichere App für Fahrer und Disponenten.',
      ),
      label: L('Logistics', tr: 'Lojistik', de: 'Logistik'),
      logo: 'assets/images/sevkiyatvar/sevkiyatvar_logo.webp',
      facts: [
        EntryFact.role(L('Lead developer of the rebuild', tr: 'Yeniden yazımın lider geliştiricisi', de: 'Leitender Entwickler des Neubaus')),
        EntryFact.androidAndIos,
      ],
      tags: ['Flutter', 'Dart', 'MVVM', 'REST API', 'Connectivity', 'Provider'],
      statuses: [EntryStatus.readyToRelease],
      highlights: [
        Highlight(
          title: L('Clearer interface', tr: 'Daha anlaşılır arayüz', de: 'Klarere Oberfläche'),
          description: L(
            'Complex logistics steps reduced to a flow that is easy to follow.',
            tr: 'Karmaşık lojistik adımları, takibi kolay bir akışa indirildi.',
            de: 'Komplexe Logistikschritte, reduziert auf einen leicht verständlichen Ablauf.',
          ),
          label: L('Design', tr: 'Tasarım', de: 'Design'),
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_01.webp',
          colors: [Color(0xFF677685), Color(0xFF495459)],
        ),
        Highlight(
          title: L('Live tracking', tr: 'Canlı takip', de: 'Live-Tracking'),
          description: L(
            'Shipments can be followed in real time, with GPS for route planning.',
            tr: 'Sevkiyatlar anlık takip ediliyor, rota planlaması için GPS kullanılıyor.',
            de: 'Sendungen lassen sich in Echtzeit verfolgen, GPS hilft bei der Routenplanung.',
          ),
          label: L('Tracking', tr: 'Takip', de: 'Tracking'),
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_02.webp',
        ),
        Highlight(
          title: L('Reports', tr: 'Raporlar', de: 'Berichte'),
          description: L(
            'Delivery performance in detailed statistics and custom reports.',
            tr: 'Teslimat performansı, detaylı istatistikler ve özelleştirilebilir raporlarla.',
            de: 'Lieferleistung in detaillierten Statistiken und eigenen Berichten.',
          ),
          label: L('Analytics', tr: 'Analiz', de: 'Auswertung'),
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_03.webp',
        ),
        Highlight(
          title: L('Android and iOS', tr: 'Android ve iOS', de: 'Android und iOS'),
          description: L(
            'One codebase, the same data in sync on both platforms.',
            tr: 'Tek kod tabanı, iki platformda da senkronize aynı veri.',
            de: 'Eine Codebasis, dieselben Daten synchron auf beiden Plattformen.',
          ),
          label: L('Platforms', tr: 'Platformlar', de: 'Plattformen'),
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_04.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı', de: 'Startbildschirm'),
          description: L(
            'Sevkiyatvar, stronger together.',
            tr: 'Sevkiyatvar, hep birlikte çok daha güçlü.',
            de: 'Sevkiyatvar, gemeinsam stärker.',
          ),
          label: L('Start', tr: 'Başlangıç', de: 'Start'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_1.webp',
        ),
        Highlight(
          title: L('Sign up', tr: 'Kayıt ol', de: 'Registrierung'),
          description: L(
            'Companies register once to post loads and see open listings for free.',
            tr: 'Firmalar bir kez kayıt olup ücretsiz yük ilanı veriyor ve açık ilanları görüyor.',
            de: 'Firmen registrieren sich einmal und können kostenlos Ladungen inserieren und Angebote sehen.',
          ),
          label: L('Account', tr: 'Hesap', de: 'Konto'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_7.webp',
        ),
        Highlight(
          title: L('Load listings', tr: 'Yük ilanları', de: 'Ladungsangebote'),
          description: L(
            'Routes, vehicle types and dates, filtered by origin and destination.',
            tr: 'Nereden-nereye filtrelenebilen güzergâhlar, araç tipleri ve tarihler.',
            de: 'Strecken, Fahrzeugtypen und Termine, filterbar nach Start und Ziel.',
          ),
          label: L('Listings', tr: 'İlanlar', de: 'Angebote'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_6.webp',
        ),
        Highlight(
          title: L('Listing details', tr: 'İlan detayı', de: 'Angebotsdetails'),
          description: L(
            'Everything about a load, with call and WhatsApp buttons.',
            tr: 'Yükle ilgili her şey, arama ve WhatsApp butonlarıyla.',
            de: 'Alle Infos zur Ladung, mit Anruf- und WhatsApp-Button.',
          ),
          label: L('Detail', tr: 'Detay', de: 'Detail'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_4.webp',
        ),
        Highlight(
          title: L('Post a load', tr: 'İlan ver', de: 'Ladung inserieren'),
          description: L(
            'Origin, destination, vehicle, body and load type in one form.',
            tr: 'Çıkış, varış, araç, kasa ve yük tipi tek formda.',
            de: 'Start, Ziel, Fahrzeug, Aufbau und Ladungsart in einem Formular.',
          ),
          label: L('New listing', tr: 'Yeni ilan', de: 'Neues Inserat'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_2.webp',
        ),
        Highlight(
          title: L('Job tracking', tr: 'İş takibi', de: 'Auftragsverfolgung'),
          description: L(
            'Accepted jobs, offers and your own listings in separate tabs.',
            tr: 'Alınan işler, teklifler ve kendi ilanların ayrı sekmelerde.',
            de: 'Angenommene Aufträge, Angebote und eigene Inserate in getrennten Tabs.',
          ),
          label: L('Tracking', tr: 'Takip', de: 'Verfolgung'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_3.webp',
        ),
        Highlight(
          title: L('Packages', tr: 'Paketler', de: 'Pakete'),
          description: L(
            'Three, six or twelve month plans with in-app card payment.',
            tr: 'Üç, altı ya da on iki aylık paketler, uygulama içi kartla ödeme.',
            de: 'Pakete für drei, sechs oder zwölf Monate mit Kartenzahlung in der App.',
          ),
          label: L('Subscription', tr: 'Abonelik', de: 'Abo'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_5.webp',
        ),
      ],
    ),
    Entry(
      slug: 'travelai',
      title: L.same('TravelAI'),
      subtitle: L('Travel companion', tr: 'Seyahat asistanı', de: 'Reisebegleiter'),
      summary: L(
        'A social travel app where people share routes and hidden spots, with AI suggestions.',
        tr: 'Gezginlerin rotalarını ve gizli kalmış yerleri paylaştığı, yapay zekâ önerileri sunan sosyal bir seyahat uygulaması.',
        de: 'Eine soziale Reise-App, in der Reisende Routen und Geheimtipps teilen, mit Vorschlägen von KI.',
      ),
      overview: L(
        'TravelAI is a social travel app I built to sharpen my Swift skills and try out different OAuth flows. Travellers share their routes and favourite spots, plan trips and save itineraries. Gemini AI suggests places to see based on the destination and the user\'s preferences.',
        tr: 'TravelAI, Swift becerilerimi geliştirmek ve farklı OAuth akışlarını denemek için yaptığım sosyal bir seyahat uygulaması. Gezginler rotalarını ve sevdikleri yerleri paylaşıyor, seyahat planlayıp kaydediyor. Gemini AI, gidilecek yere ve kullanıcının tercihlerine göre görülecek yerler öneriyor.',
        de: 'TravelAI ist eine soziale Reise-App, mit der ich meine Swift-Kenntnisse vertieft und verschiedene OAuth-Flows ausprobiert habe. Reisende teilen Routen und Lieblingsorte, planen Trips und speichern Reisepläne. Gemini AI schlägt passend zu Ziel und Vorlieben Sehenswürdigkeiten vor.',
      ),
      label: L('Travel', tr: 'Seyahat', de: 'Reisen'),
      logo: 'assets/images/travelai/travelai_logo.webp',
      facts: [EntryFact.ideaToRelease, EntryFact.solo, EntryFact.ios],
      tags: ['Swift', 'UIKit', 'Lottie', 'Alamofire', 'Google Gemini AI', 'Firebase', 'OAuth'],
      highlights: [
        Highlight(
          title: L('One-tap sign-in', tr: 'Tek dokunuşla giriş', de: 'Anmeldung mit einem Tipp'),
          description: L(
            'Sign in with Apple, Microsoft, Google or Facebook.',
            tr: 'Apple, Microsoft, Google veya Facebook ile giriş.',
            de: 'Anmelden mit Apple, Microsoft, Google oder Facebook.',
          ),
          label: L('Social sign-in', tr: 'Sosyal giriş', de: 'Social Login'),
          image: 'assets/images/travelai/travelai_screenshots_2.webp',
          colors: [Color(0xFF16C964), Color(0xFF00994A)],
        ),
        Highlight(
          title: L('Plan a trip', tr: 'Seyahat planla', de: 'Reise planen'),
          description: L(
            'Pick a country and a city on the globe, and the app builds a trip around them.',
            tr: 'Dünya üzerinde bir ülke ve şehir seç, uygulama seyahati onların etrafında kursun.',
            de: 'Land und Stadt auf dem Globus wählen, die App plant die Reise drumherum.',
          ),
          label: L('Planner', tr: 'Planlayıcı', de: 'Planer'),
          image: 'assets/images/travelai/travelai_screenshots_3.webp',
        ),
        Highlight(
          title: L('Places to see', tr: 'Görülecek yerler', de: 'Sehenswertes'),
          description: L(
            'Gemini AI lists the sights at each stop as a checklist.',
            tr: 'Gemini AI her durak için görülecek yerleri bir kontrol listesi olarak sunuyor.',
            de: 'Gemini AI listet die Sehenswürdigkeiten jedes Ziels als Checkliste.',
          ),
          label: L('AI itinerary', tr: 'Yapay zekâ rotası', de: 'KI-Reiseplan'),
          image: 'assets/images/travelai/travelai_screenshots_6.webp',
        ),
        Highlight(
          title: L('Shared routes', tr: 'Paylaşılan rotalar', de: 'Geteilte Routen'),
          description: L(
            'Browse trips other travellers saved and filter them by continent.',
            tr: 'Diğer gezginlerin kaydettiği seyahatlere göz at, kıtaya göre filtrele.',
            de: 'Durch die Reisen anderer stöbern und nach Kontinent filtern.',
          ),
          label: L('Discover', tr: 'Keşfet', de: 'Entdecken'),
          image: 'assets/images/travelai/travelai_screenshots_4.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı', de: 'Startbildschirm'),
          description: L(
            'TravelAI, your personal AI travel adviser.',
            tr: 'TravelAI, kişisel yapay zekâ seyahat danışmanın.',
            de: 'TravelAI, Ihr persönlicher KI-Reiseberater.',
          ),
          label: L('Start', tr: 'Başlangıç', de: 'Start'),
          image: 'assets/images/travelai/travelai_screenshots_5.webp',
        ),
        Highlight(
          title: L('Welcome', tr: 'Hoş geldin', de: 'Willkommen'),
          description: L(
            'Join with an account or continue as a guest.',
            tr: 'Hesapla katıl ya da misafir olarak devam et.',
            de: 'Mit Konto beitreten oder als Gast fortfahren.',
          ),
          label: L('Onboarding', tr: 'Karşılama', de: 'Onboarding'),
          image: 'assets/images/travelai/travelai_screenshots_7.webp',
        ),
        Highlight(
          title: L('Profile menu', tr: 'Profil menüsü', de: 'Profilmenü'),
          description: L(
            'Help, contact, privacy and account settings in one drawer.',
            tr: 'Yardım, iletişim, gizlilik ve hesap ayarları tek menüde.',
            de: 'Hilfe, Kontakt, Datenschutz und Kontoeinstellungen in einem Menü.',
          ),
          label: L('Account', tr: 'Hesap', de: 'Konto'),
          image: 'assets/images/travelai/travelai_screenshots_1.webp',
        ),
      ],
      statuses: [EntryStatus.earlyDevelopment],
    ),
    Entry(
      slug: 'visiostellar',
      title: L.same('Visiostellar'),
      subtitle: L('iOS astronomy app', tr: 'iOS astronomi uygulaması', de: 'Astronomie-App für iOS'),
      summary: L(
        'My first iOS app: space news, celestial objects and astronomy basics, written in Swift.',
        tr: 'İlk iOS uygulamam: uzay haberleri, gök cisimleri ve temel astronomi bilgileri, Swift ile.',
        de: 'Meine erste iOS-App: Weltraum-News, Himmelskörper und Astronomie-Grundlagen, in Swift.',
      ),
      overview: L(
        'Visiostellar is the iOS app I built when I started mobile development. Written in Swift with UIKit, it taught me the fundamentals: Storyboard and Auto Layout for screens that fit every iPhone, iOS navigation and Apple\'s design guidelines. It shows NASA news, celestial objects and short lessons about space.',
        tr: 'Visiostellar, mobil geliştirmeye başladığımda yaptığım iOS uygulaması. Swift ve UIKit ile yazdım; her iPhone\'a uyan ekranlar için Storyboard ve Auto Layout, iOS navigasyonu ve Apple\'ın tasarım rehberleri gibi temelleri bu projede öğrendim. NASA haberlerini, gök cisimlerini ve uzayla ilgili kısa bilgileri gösteriyor.',
        de: 'Visiostellar ist die iOS-App, mit der ich in die Mobile-Entwicklung eingestiegen bin. Geschrieben in Swift mit UIKit, habe ich damit die Grundlagen gelernt: Storyboard und Auto Layout für Screens auf jedem iPhone, iOS-Navigation und Apples Design-Richtlinien. Sie zeigt NASA-News, Himmelskörper und kurze Lerninhalte zum Weltraum.',
      ),
      label: L('Education', tr: 'Eğitim', de: 'Bildung'),
      logo: 'assets/images/visiostellar/visiostellar_logo.webp',
      facts: [EntryFact.ideaToRelease, EntryFact.solo, EntryFact.ios],
      tags: ['Swift', 'UIKit', 'Storyboard', 'Auto Layout', 'iOS', 'Xcode', 'MVC'],
      highlights: [
        Highlight(
          title: L('NASA feed', tr: 'NASA akışı', de: 'NASA-Feed'),
          description: L(
            'The latest NASA stories with images and short summaries.',
            tr: 'NASA\'dan son haberler, görseller ve kısa özetlerle.',
            de: 'Aktuelle NASA-Meldungen mit Bildern und kurzen Zusammenfassungen.',
          ),
          label: L('Space news', tr: 'Uzay haberleri', de: 'Weltraum-News'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_3.webp',
          colors: [Color(0xFF2A3157), Color(0xFF0E1226)],
        ),
        Highlight(
          title: L('Topics', tr: 'Konular', de: 'Themen'),
          description: L(
            'Browse the archive by topic, from rovers to launches and the ISS.',
            tr: 'Arşivde konuya göre gezin: keşif araçlarından fırlatmalara ve ISS\'e.',
            de: 'Das Archiv nach Themen durchsuchen, von Rovern über Starts bis zur ISS.',
          ),
          label: L('Search', tr: 'Arama', de: 'Suche'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_5.webp',
        ),
        Highlight(
          title: L('Full stories', tr: 'Detaylı okuma', de: 'Ganze Artikel'),
          description: L(
            'Each story opens to a longer summary with a link to nasa.gov.',
            tr: 'Her haber, nasa.gov bağlantısıyla birlikte daha uzun bir özete açılıyor.',
            de: 'Jede Meldung öffnet eine längere Zusammenfassung mit Link zu nasa.gov.',
          ),
          label: L('Article', tr: 'Makale', de: 'Artikel'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_6.webp',
        ),
        Highlight(
          title: L('Find a mission', tr: 'Görev bul', de: 'Mission finden'),
          description: L(
            'Results update as you type, for example every SpaceX resupply mission.',
            tr: 'Sonuçlar yazarken güncelleniyor; örneğin tüm SpaceX ikmal görevleri.',
            de: 'Ergebnisse aktualisieren sich beim Tippen, etwa alle SpaceX-Versorgungsflüge.',
          ),
          label: L('Live search', tr: 'Canlı arama', de: 'Live-Suche'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_4.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı', de: 'Startbildschirm'),
          description: L(
            'Visiostellar, astronomy on the iPhone.',
            tr: 'Visiostellar, iPhone\'da astronomi.',
            de: 'Visiostellar, Astronomie auf dem iPhone.',
          ),
          label: L('Start', tr: 'Başlangıç', de: 'Start'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_1.webp',
        ),
        Highlight(
          title: L('Home feed', tr: 'Ana akış', de: 'Start-Feed'),
          description: L(
            'Image-first cards for each story, from Mars rocks to aircraft tests.',
            tr: 'Mars kayalarından uçak testlerine, her haber için görsel ağırlıklı kartlar.',
            de: 'Bildstarke Karten für jede Meldung, von Mars-Gestein bis zu Flugtests.',
          ),
          label: L('Feed', tr: 'Akış', de: 'Feed'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_7.webp',
        ),
        Highlight(
          title: L('On nasa.gov', tr: 'nasa.gov\'da', de: 'Auf nasa.gov'),
          description: L(
            'The full article opens on nasa.gov without leaving the app.',
            tr: 'Haberin tamamı uygulamadan çıkmadan nasa.gov\'da açılıyor.',
            de: 'Der ganze Artikel öffnet sich auf nasa.gov, ohne die App zu verlassen.',
          ),
          label: L('Source', tr: 'Kaynak', de: 'Quelle'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_2.webp',
        ),
      ],
      statuses: [EntryStatus.earlyProject],
    ),
    Entry(
      slug: 'peasy',
      title: L.same('Peasy'),
      subtitle: L('Self-checkout app', tr: 'Kendi kendine ödeme uygulaması', de: 'Self-Checkout-App'),
      summary: L(
        'A self-checkout app with NFC, built as our graduation project in a team of four.',
        tr: 'Dört kişilik ekibimizle bitirme projesi olarak geliştirdiğimiz, NFC ile çalışan bir self-checkout uygulaması.',
        de: 'Eine Self-Checkout-App mit NFC, entstanden als Abschlussprojekt im Viererteam.',
      ),
      overview: L(
        'Peasy is our graduation project, built by a team of four. It removes the checkout queue: customers scan products with their phone over NFC and pay in the app. A backend service recommends similar products based on purchase history and the current cart. It gave me real experience in team development, NFC and recommendation systems.',
        tr: 'Peasy, dört kişilik ekibimizle geliştirdiğimiz bitirme projemiz. Kasa kuyruğunu ortadan kaldırıyor: müşteri ürünleri telefonuyla NFC üzerinden okutuyor ve ödemeyi uygulamada yapıyor. Arka uçtaki servis, alışveriş geçmişine ve sepete göre benzer ürünler öneriyor. Bu proje bana ekip çalışması, NFC ve öneri sistemleri konusunda gerçek deneyim kazandırdı.',
        de: 'Peasy ist unser Abschlussprojekt, entwickelt im Viererteam. Es macht die Kassenschlange überflüssig: Kunden scannen Produkte per NFC mit dem Smartphone und bezahlen direkt in der App. Ein Backend-Service empfiehlt ähnliche Produkte anhand der Kaufhistorie und des aktuellen Warenkorbs. Dabei habe ich viel über Teamarbeit, NFC und Empfehlungssysteme gelernt.',
      ),
      label: L('Retail', tr: 'Perakende', de: 'Einzelhandel'),
      logo: 'assets/images/peasy/peasy_logo.webp',
      facts: [
        EntryFact.role(L('Mobile app', tr: 'Mobil uygulama', de: 'Mobile App')),
        EntryFact.team(L('Four students', tr: 'Dört öğrenci', de: 'Vier Studierende')),
        EntryFact.androidAndIos,
      ],
      tags: ['Flutter', 'Dart', 'NFC', 'Firebase', 'REST API', 'Recommendation systems'],
      highlights: [
        Highlight(
          title: L('Tap to scan', tr: 'Dokun ve okut', de: 'Antippen und scannen'),
          description: L(
            'Hold the phone near a product\'s NFC tag to add it to the cart.',
            tr: 'Telefonu ürünün NFC etiketine yaklaştır, ürün sepete eklensin.',
            de: 'Smartphone an den NFC-Tag halten, schon liegt das Produkt im Warenkorb.',
          ),
          label: L('NFC checkout', tr: 'NFC ile ödeme', de: 'NFC-Checkout'),
          image: 'assets/images/peasy/peasy_screenshots_3.webp',
          colors: [Color(0xFF1652B8), Color(0xFF07245E)],
        ),
        Highlight(
          title: L('Barcode too', tr: 'Barkod da olur', de: 'Auch per Barcode'),
          description: L(
            'Products without a tag go into the cart by their barcode.',
            tr: 'Etiketi olmayan ürünler barkoduyla sepete ekleniyor.',
            de: 'Produkte ohne Tag kommen per Barcode in den Warenkorb.',
          ),
          label: L('Scanner', tr: 'Tarayıcı', de: 'Scanner'),
          image: 'assets/images/peasy/peasy_screenshots_2.webp',
        ),
        Highlight(
          title: L('Pay in the app', tr: 'Uygulamada öde', de: 'In der App bezahlen'),
          description: L(
            'Saved card, Apple Pay, Google Pay or PayPal, and no queue.',
            tr: 'Kayıtlı kart, Apple Pay, Google Pay veya PayPal; kuyruk yok.',
            de: 'Gespeicherte Karte, Apple Pay, Google Pay oder PayPal, ohne Anstehen.',
          ),
          label: L('Payments', tr: 'Ödeme', de: 'Bezahlen'),
          image: 'assets/images/peasy/peasy_screenshots_5.webp',
        ),
        Highlight(
          title: L('Find the aisle', tr: 'Reyonu bul', de: 'Regal finden'),
          description: L(
            'See where a product is, and whether it is in stock or on sale.',
            tr: 'Ürünün hangi reyonda olduğunu, stokta ya da indirimde olup olmadığını gör.',
            de: 'Sehen, wo ein Produkt steht und ob es vorrätig oder im Angebot ist.',
          ),
          label: L('Store map', tr: 'Mağaza haritası', de: 'Filialplan'),
          image: 'assets/images/peasy/peasy_screenshots_6.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı', de: 'Startbildschirm'),
          description: L(
            'Peasy, checkout without the queue.',
            tr: 'Peasy, kuyruksuz ödeme.',
            de: 'Peasy, bezahlen ohne Schlange.',
          ),
          label: L('Start', tr: 'Başlangıç', de: 'Start'),
          image: 'assets/images/peasy/peasy_screenshots_1.webp',
        ),
        Highlight(
          title: L('Verify with a code', tr: 'Kodla doğrula', de: 'Per Code bestätigen'),
          description: L(
            'A one-time code sent by email or SMS keeps the account safe.',
            tr: 'E-posta veya SMS ile gelen tek kullanımlık kod hesabı güvende tutuyor.',
            de: 'Ein Einmalcode per E-Mail oder SMS schützt das Konto.',
          ),
          label: L('Security', tr: 'Güvenlik', de: 'Sicherheit'),
          image: 'assets/images/peasy/peasy_screenshots_7.webp',
        ),
        Highlight(
          title: L('Order summary', tr: 'Sipariş özeti', de: 'Bestellübersicht'),
          description: L(
            'Subtotal, taxes and promotion codes before confirming the payment.',
            tr: 'Ödemeyi onaylamadan önce ara toplam, vergiler ve indirim kodu.',
            de: 'Zwischensumme, Steuern und Gutscheincode vor der Zahlung.',
          ),
          label: L('Checkout', tr: 'Ödeme', de: 'Kasse'),
          image: 'assets/images/peasy/peasy_screenshots_4.webp',
        ),
      ],
      statuses: [EntryStatus.underDevelopment],
      link: EntryLink.github('https://github.com/ahmetkadircicek/peasy'),
    ),
  ],
);
