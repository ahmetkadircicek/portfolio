import 'package:flutter/painting.dart';
import 'package:portfolio/core/data/entry.dart';
import 'package:portfolio/core/l10n/l10n.dart';

/// Every project on the site, in page order. Adding an entry here adds its
/// row on the home page and its page at `/projects/<slug>`.
const projects = Collection(
  id: 'projects',
  title: L('Projects', tr: 'Projeler'),
  collapsedOnPhones: true,
  entries: [
    Entry(
      slug: 'tunes',
      title: L.same('Tunes.AI'),
      subtitle: L('AI music platform', tr: 'Yapay zekâ destekli müzik platformu'),
      summary: L(
        'A music app that creates songs and playlists with AI, built from scratch with Flutter and Firebase.',
        tr: 'Yapay zekâyla şarkı ve çalma listesi oluşturan, Flutter ve Firebase ile sıfırdan geliştirdiğim bir müzik uygulaması.',
      ),
      overview: L(
        'Tunes.AI is a music app I built from scratch with Flutter and Firebase. It creates playlists from your listening habits and generates songs that fit your mood. I took it from idea to release on my own: three weeks of market research, two of UI/UX design, five of building the MVP, then feature work, testing and performance tuning. I also added Google AdMob, which taught me a lot about how apps actually earn money.',
        tr: 'Tunes.AI, Flutter ve Firebase ile sıfırdan geliştirdiğim bir müzik uygulaması. Dinleme alışkanlıklarına göre çalma listeleri hazırlıyor, ruh haline uygun şarkılar üretiyor. Fikirden yayına kadar her aşamayı tek başıma yürüttüm: üç hafta pazar araştırması, iki hafta UI/UX tasarımı, beş hafta MVP geliştirme, ardından yeni özellikler, test ve performans iyileştirmeleri. Google AdMob entegrasyonu da bir uygulamanın gerçekte nasıl gelir elde ettiği konusunda bana çok şey öğretti.',
      ),
      label: L('Music', tr: 'Müzik'),
      logo: 'assets/images/tunes/tunes_logo.webp',
      tags: ['Flutter', 'Dart', 'Firebase', 'Provider', 'MVVM', 'Figma', 'Replicate', 'REST API', 'Google AdMob'],
      statuses: [EntryStatus.readyToRelease],
      highlights: [
        Highlight(
          title: L('Personal', tr: 'Kişisel'),
          description: L(
            'AI-generated songs shaped by your taste and mood.',
            tr: 'Zevkine ve ruh haline göre yapay zekâyla üretilen şarkılar.',
          ),
          label: L('AI creation', tr: 'Yapay zekâ ile üretim'),
          image: 'assets/images/tunes/image_mockup_tunes_01.webp',
          colors: [Color(0xFFFE6C11), Color(0xFFC63B08)],
        ),
        Highlight(
          title: L('Smooth playback', tr: 'Kesintisiz çalma'),
          description: L(
            'A custom AudioManager and fast streaming keep the music going without gaps.',
            tr: 'Özel bir AudioManager ve hızlı akış sayesinde müzik kesintisiz çalıyor.',
          ),
          label: L('Playback', tr: 'Oynatma'),
          image: 'assets/images/tunes/image_mockup_tunes_02.webp',
        ),
        Highlight(
          title: L('Cloud storage', tr: 'Bulut depolama'),
          description: L(
            'Firebase stores the library and a cache opens your favourite tracks instantly.',
            tr: 'Kütüphane Firebase\'de duruyor, önbellek sayesinde favori parçalar anında açılıyor.',
          ),
          label: L('Storage', tr: 'Depolama'),
          image: 'assets/images/tunes/image_mockup_tunes_03.webp',
        ),
        Highlight(
          title: L('Simple interface', tr: 'Sade arayüz'),
          description: L(
            'A minimal design that stays out of the way of the music.',
            tr: 'Müziğin önüne geçmeyen, sade bir tasarım.',
          ),
          label: L('Interface', tr: 'Arayüz'),
          image: 'assets/images/tunes/image_mockup_tunes_04.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı'),
          description: L(
            'The Tunes wordmark while the app gets ready.',
            tr: 'Uygulama hazırlanırken Tunes logosu.',
          ),
          label: L('Start', tr: 'Başlangıç'),
          image: 'assets/images/tunes/tunes_screenshots_1.webp',
        ),
        Highlight(
          title: L('Create your music', tr: 'Müziğini oluştur'),
          description: L(
            'Choose a length, name your melody and start a new track.',
            tr: 'Süreyi seç, melodine bir isim ver ve yeni parçaya başla.',
          ),
          label: L('Create', tr: 'Oluştur'),
          image: 'assets/images/tunes/tunes_screenshots_8.webp',
        ),
        Highlight(
          title: L('Pick a key', tr: 'Ton seç'),
          description: L(
            'The key sets the overall feel of the track, from C minor to G major.',
            tr: 'Ton, parçanın genel havasını belirliyor; Do minörden Sol majöre kadar.',
          ),
          label: L('Key setting', tr: 'Ton ayarı'),
          image: 'assets/images/tunes/tunes_screenshots_4.webp',
        ),
        Highlight(
          title: L('Generating', tr: 'Hazırlanıyor'),
          description: L(
            'The AI works on the track while you browse your other songs.',
            tr: 'Yapay zekâ parçayı hazırlarken diğer şarkılarına göz atabilirsin.',
          ),
          label: L('AI at work', tr: 'Yapay zekâ çalışıyor'),
          image: 'assets/images/tunes/tunes_screenshots_6.webp',
        ),
        Highlight(
          title: L('Player', tr: 'Oynatıcı'),
          description: L(
            'Cover, genre, key and simple playback controls.',
            tr: 'Kapak, tür, ton ve sade oynatma kontrolleri.',
          ),
          label: L('Playback', tr: 'Oynatma'),
          image: 'assets/images/tunes/tunes_screenshots_3.webp',
        ),
        Highlight(
          title: L('History', tr: 'Geçmiş'),
          description: L(
            'Every track you created, with its genre and key.',
            tr: 'Oluşturduğun tüm parçalar, türü ve tonuyla birlikte.',
          ),
          label: L('Library', tr: 'Kitaplık'),
          image: 'assets/images/tunes/tunes_screenshots_2.webp',
        ),
        Highlight(
          title: L('Three languages', tr: 'Üç dil'),
          description: L(
            'Settings with appearance options and English, Turkish and German.',
            tr: 'Görünüm seçenekleri ve İngilizce, Türkçe, Almanca dil desteğiyle ayarlar.',
          ),
          label: L('Settings', tr: 'Ayarlar'),
          image: 'assets/images/tunes/tunes_screenshots_7.webp',
        ),
        Highlight(
          title: L('AdMob', tr: 'AdMob'),
          description: L(
            'Interstitial ads through Google AdMob, shown here in test mode.',
            tr: 'Google AdMob ile geçiş reklamları; burada test modunda.',
          ),
          label: L('Monetisation', tr: 'Gelir modeli'),
          image: 'assets/images/tunes/tunes_screenshots_5.webp',
        ),
      ],
    ),
    Entry(
      slug: 'vilsa',
      title: L.same('Vilsa'),
      subtitle: L('Stock portfolio tracker', tr: 'Borsa portföy takibi'),
      summary: L(
        'A Flutter app for tracking stock portfolios across markets, with dividend tracking.',
        tr: 'Farklı borsalardaki hisseleri ve temettüleri takip etmek için geliştirdiğim bir Flutter uygulaması.',
      ),
      overview: L(
        'Vilsa is a portfolio tracker I built with Flutter. You choose which markets to follow and add stocks from each of them. It records past dividends and estimates upcoming ones, runs daily, weekly, monthly or quarterly reviews of the portfolio, and lets you arrange the dashboard with your own widgets, watchlists and alerts.',
        tr: 'Vilsa, Flutter ile geliştirdiğim bir portföy takip uygulaması. Takip etmek istediğin borsaları seçip hisselerini ekliyorsun. Geçmiş temettüleri kaydediyor ve gelecek ödemeleri tahmin ediyor; portföyü günlük, haftalık, aylık ya da çeyreklik olarak değerlendiriyor. Ana ekranı da kendi widget\'ların, izleme listelerin ve alarmlarınla düzenleyebiliyorsun.',
      ),
      label: L('Finance', tr: 'Finans'),
      logo: 'assets/images/vilsa/vilsa_logo.webp',
      tags: ['Flutter', 'Dart', 'Firebase', 'Provider', 'MVVM', 'Figma', 'Charts'],
      statuses: [EntryStatus.readyToRelease],
      link: EntryLink.github('https://github.com/ahmetkadircicek/vilsa'),
      highlights: [
        Highlight(
          title: L('Your markets', tr: 'Senin borsaların'),
          description: L(
            'Pick the exchanges you care about and add stocks from each.',
            tr: 'İlgilendiğin borsaları seç, her birinden hisse ekle.',
          ),
          label: L('Markets', tr: 'Borsalar'),
          image: 'assets/images/vilsa/image_mockup_vilsa_01.webp',
          colors: [Color(0xFF5908FA), Color(0xFF9829E9)],
        ),
        Highlight(
          title: L('Dividends', tr: 'Temettüler'),
          description: L(
            'A record of past dividends and an estimate of the ones to come.',
            tr: 'Geçmiş temettülerin kaydı ve gelecek ödemelerin tahmini.',
          ),
          label: L('Income', tr: 'Gelir'),
          image: 'assets/images/vilsa/image_mockup_vilsa_02.webp',
        ),
        Highlight(
          title: L('Regular reviews', tr: 'Düzenli analiz'),
          description: L(
            'Daily, weekly, monthly or quarterly looks at how the portfolio is doing.',
            tr: 'Portföyün durumuna günlük, haftalık, aylık ya da çeyreklik bakış.',
          ),
          label: L('Analysis', tr: 'Analiz'),
          image: 'assets/images/vilsa/image_mockup_vilsa_03.webp',
        ),
        Highlight(
          title: L('Your dashboard', tr: 'Senin ekranın'),
          description: L(
            'Widgets, watchlists and alerts arranged the way you invest.',
            tr: 'Widget\'lar, izleme listeleri ve alarmlar, yatırım tarzına göre.',
          ),
          label: L('Customisation', tr: 'Kişiselleştirme'),
          image: 'assets/images/vilsa/image_mockup_vilsa_04.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı'),
          description: L(
            'Vilsa, financial management.',
            tr: 'Vilsa, finansal yönetim.',
          ),
          label: L('Start', tr: 'Başlangıç'),
          image: 'assets/images/vilsa/vilsa_screenshots_1.webp',
        ),
        Highlight(
          title: L('Portfolio at a glance', tr: 'Bir bakışta portföy'),
          description: L(
            'Total balance, dividends and a line chart of the chosen period.',
            tr: 'Toplam bakiye, temettüler ve seçilen döneme ait çizgi grafik.',
          ),
          label: L('Home', tr: 'Ana sayfa'),
          image: 'assets/images/vilsa/vilsa_screenshots_6.webp',
        ),
        Highlight(
          title: L('Bar chart', tr: 'Sütun grafik'),
          description: L(
            'The same period as bars, one tap away.',
            tr: 'Aynı dönem, tek dokunuşla sütun grafikte.',
          ),
          label: L('Charts', tr: 'Grafikler'),
          image: 'assets/images/vilsa/vilsa_screenshots_7.webp',
        ),
        Highlight(
          title: L('Sort and filter', tr: 'Sırala ve filtrele'),
          description: L(
            'Sort holdings by name, quantity, total value or average price.',
            tr: 'Hisseleri ada, adede, toplam değere ya da ortalama fiyata göre sırala.',
          ),
          label: L('Holdings', tr: 'Hisseler'),
          image: 'assets/images/vilsa/vilsa_screenshots_5.webp',
        ),
        Highlight(
          title: L('Stock details', tr: 'Hisse detayı'),
          description: L(
            'Cost, average price, dividend yield and every transaction for one stock.',
            tr: 'Bir hissenin maliyeti, ortalama fiyatı, temettü verimi ve tüm işlemleri.',
          ),
          label: L('Detail', tr: 'Detay'),
          image: 'assets/images/vilsa/vilsa_screenshots_4.webp',
        ),
        Highlight(
          title: L('Add a transaction', tr: 'İşlem ekle'),
          description: L(
            'Date, buy price, quantity, dividend and a note.',
            tr: 'Tarih, alış fiyatı, adet, temettü ve not.',
          ),
          label: L('Transactions', tr: 'İşlemler'),
          image: 'assets/images/vilsa/vilsa_screenshots_3.webp',
        ),
        Highlight(
          title: L('Date range', tr: 'Tarih aralığı'),
          description: L(
            'Pick any range and every figure follows it.',
            tr: 'Bir aralık seç, tüm rakamlar ona göre güncellensin.',
          ),
          label: L('Period', tr: 'Dönem'),
          image: 'assets/images/vilsa/vilsa_screenshots_2.webp',
        ),
      ],
    ),
    Entry(
      slug: 'sevkiyatvar',
      title: L.same('Sevkiyatvar'),
      subtitle: L('Logistics platform', tr: 'Lojistik yönetim platformu'),
      summary: L(
        'An existing logistics app that I rebuilt in Flutter with a clearer interface for drivers and dispatchers.',
        tr: 'Mevcut bir lojistik uygulamasını sürücüler ve operasyon ekipleri için daha anlaşılır bir arayüzle Flutter\'da yeniden geliştirdim.',
      ),
      overview: L(
        'Sevkiyatvar is a modernisation project I led for a logistics company. Users found the old app dated and hard to use, so I rebuilt it in Flutter with a cleaner flow while keeping the business logic they already knew. I split the legacy code into reusable components and moved state management to Provider. The result is a faster, clearer app for both drivers and dispatchers.',
        tr: 'Sevkiyatvar, bir lojistik firması için yürüttüğüm bir modernizasyon projesi. Kullanıcılar eski uygulamayı eski moda ve kullanımı zor buluyordu. Uygulamayı, alıştıkları iş mantığını koruyarak daha sade bir akışla Flutter\'da yeniden geliştirdim. Eski kodu yeniden kullanılabilir bileşenlere ayırdım, state yönetimini Provider\'a taşıdım. Sonuçta hem sürücüler hem operasyon ekibi için daha hızlı ve anlaşılır bir uygulama çıktı.',
      ),
      label: L('Logistics', tr: 'Lojistik'),
      logo: 'assets/images/sevkiyatvar/sevkiyatvar_logo.webp',
      tags: ['Flutter', 'Dart', 'MVVM', 'REST API', 'Connectivity', 'Provider'],
      statuses: [EntryStatus.readyToRelease],
      highlights: [
        Highlight(
          title: L('Clearer interface', tr: 'Daha anlaşılır arayüz'),
          description: L(
            'Complex logistics steps reduced to a flow that is easy to follow.',
            tr: 'Karmaşık lojistik adımları, takibi kolay bir akışa indirildi.',
          ),
          label: L('Design', tr: 'Tasarım'),
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_01.webp',
          colors: [Color(0xFF677685), Color(0xFF495459)],
        ),
        Highlight(
          title: L('Live tracking', tr: 'Canlı takip'),
          description: L(
            'Shipments can be followed in real time, with GPS for route planning.',
            tr: 'Sevkiyatlar anlık takip ediliyor, rota planlaması için GPS kullanılıyor.',
          ),
          label: L('Tracking', tr: 'Takip'),
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_02.webp',
        ),
        Highlight(
          title: L('Reports', tr: 'Raporlar'),
          description: L(
            'Delivery performance in detailed statistics and custom reports.',
            tr: 'Teslimat performansı, detaylı istatistikler ve özelleştirilebilir raporlarla.',
          ),
          label: L('Analytics', tr: 'Analiz'),
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_03.webp',
        ),
        Highlight(
          title: L('Android and iOS', tr: 'Android ve iOS'),
          description: L(
            'One codebase, the same data in sync on both platforms.',
            tr: 'Tek kod tabanı, iki platformda da senkronize aynı veri.',
          ),
          label: L('Platforms', tr: 'Platformlar'),
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_04.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı'),
          description: L(
            'Sevkiyatvar, stronger together.',
            tr: 'Sevkiyatvar, hep birlikte çok daha güçlü.',
          ),
          label: L('Start', tr: 'Başlangıç'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_1.webp',
        ),
        Highlight(
          title: L('Sign up', tr: 'Kayıt ol'),
          description: L(
            'Companies register once to post loads and see open listings for free.',
            tr: 'Firmalar bir kez kayıt olup ücretsiz yük ilanı veriyor ve açık ilanları görüyor.',
          ),
          label: L('Account', tr: 'Hesap'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_7.webp',
        ),
        Highlight(
          title: L('Load listings', tr: 'Yük ilanları'),
          description: L(
            'Routes, vehicle types and dates, filtered by origin and destination.',
            tr: 'Nereden-nereye filtrelenebilen güzergâhlar, araç tipleri ve tarihler.',
          ),
          label: L('Listings', tr: 'İlanlar'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_6.webp',
        ),
        Highlight(
          title: L('Listing details', tr: 'İlan detayı'),
          description: L(
            'Everything about a load, with call and WhatsApp buttons.',
            tr: 'Yükle ilgili her şey, arama ve WhatsApp butonlarıyla.',
          ),
          label: L('Detail', tr: 'Detay'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_4.webp',
        ),
        Highlight(
          title: L('Post a load', tr: 'İlan ver'),
          description: L(
            'Origin, destination, vehicle, body and load type in one form.',
            tr: 'Çıkış, varış, araç, kasa ve yük tipi tek formda.',
          ),
          label: L('New listing', tr: 'Yeni ilan'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_2.webp',
        ),
        Highlight(
          title: L('Job tracking', tr: 'İş takibi'),
          description: L(
            'Accepted jobs, offers and your own listings in separate tabs.',
            tr: 'Alınan işler, teklifler ve kendi ilanların ayrı sekmelerde.',
          ),
          label: L('Tracking', tr: 'Takip'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_3.webp',
        ),
        Highlight(
          title: L('Packages', tr: 'Paketler'),
          description: L(
            'Three, six or twelve month plans with in-app card payment.',
            tr: 'Üç, altı ya da on iki aylık paketler, uygulama içi kartla ödeme.',
          ),
          label: L('Subscription', tr: 'Abonelik'),
          image: 'assets/images/sevkiyatvar/sevkiyatvar_screenshots_5.webp',
        ),
      ],
    ),
    Entry(
      slug: 'travelai',
      title: L.same('TravelAI'),
      subtitle: L('Travel companion', tr: 'Seyahat asistanı'),
      summary: L(
        'A social travel app where people share routes and hidden spots, with AI suggestions.',
        tr: 'Gezginlerin rotalarını ve gizli kalmış yerleri paylaştığı, yapay zekâ önerileri sunan sosyal bir seyahat uygulaması.',
      ),
      overview: L(
        'TravelAI is a social travel app I built to sharpen my Swift skills and try out different OAuth flows. Travellers share their routes and favourite spots, plan trips and save itineraries. Gemini AI suggests places to see based on the destination and the user\'s preferences.',
        tr: 'TravelAI, Swift becerilerimi geliştirmek ve farklı OAuth akışlarını denemek için yaptığım sosyal bir seyahat uygulaması. Gezginler rotalarını ve sevdikleri yerleri paylaşıyor, seyahat planlayıp kaydediyor. Gemini AI, gidilecek yere ve kullanıcının tercihlerine göre görülecek yerler öneriyor.',
      ),
      label: L('Travel', tr: 'Seyahat'),
      logo: 'assets/images/travelai/travelai_logo.webp',
      tags: ['Swift', 'UIKit', 'Lottie', 'Alamofire', 'Google Gemini AI', 'Firebase', 'OAuth'],
      highlights: [
        Highlight(
          title: L('One-tap sign-in', tr: 'Tek dokunuşla giriş'),
          description: L(
            'Sign in with Apple, Microsoft, Google or Facebook.',
            tr: 'Apple, Microsoft, Google veya Facebook ile giriş.',
          ),
          label: L('Social sign-in', tr: 'Sosyal giriş'),
          image: 'assets/images/travelai/travelai_screenshots_2.webp',
          colors: [Color(0xFF16C964), Color(0xFF00994A)],
        ),
        Highlight(
          title: L('Plan a trip', tr: 'Seyahat planla'),
          description: L(
            'Pick a country and a city on the globe, and the app builds a trip around them.',
            tr: 'Dünya üzerinde bir ülke ve şehir seç, uygulama seyahati onların etrafında kursun.',
          ),
          label: L('Planner', tr: 'Planlayıcı'),
          image: 'assets/images/travelai/travelai_screenshots_3.webp',
        ),
        Highlight(
          title: L('Places to see', tr: 'Görülecek yerler'),
          description: L(
            'Gemini AI lists the sights at each stop as a checklist.',
            tr: 'Gemini AI her durak için görülecek yerleri bir kontrol listesi olarak sunuyor.',
          ),
          label: L('AI itinerary', tr: 'Yapay zekâ rotası'),
          image: 'assets/images/travelai/travelai_screenshots_6.webp',
        ),
        Highlight(
          title: L('Shared routes', tr: 'Paylaşılan rotalar'),
          description: L(
            'Browse trips other travellers saved and filter them by continent.',
            tr: 'Diğer gezginlerin kaydettiği seyahatlere göz at, kıtaya göre filtrele.',
          ),
          label: L('Discover', tr: 'Keşfet'),
          image: 'assets/images/travelai/travelai_screenshots_4.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı'),
          description: L(
            'TravelAI, your personal AI travel adviser.',
            tr: 'TravelAI, kişisel yapay zekâ seyahat danışmanın.',
          ),
          label: L('Start', tr: 'Başlangıç'),
          image: 'assets/images/travelai/travelai_screenshots_5.webp',
        ),
        Highlight(
          title: L('Welcome', tr: 'Hoş geldin'),
          description: L(
            'Join with an account or continue as a guest.',
            tr: 'Hesapla katıl ya da misafir olarak devam et.',
          ),
          label: L('Onboarding', tr: 'Karşılama'),
          image: 'assets/images/travelai/travelai_screenshots_7.webp',
        ),
        Highlight(
          title: L('Profile menu', tr: 'Profil menüsü'),
          description: L(
            'Help, contact, privacy and account settings in one drawer.',
            tr: 'Yardım, iletişim, gizlilik ve hesap ayarları tek menüde.',
          ),
          label: L('Account', tr: 'Hesap'),
          image: 'assets/images/travelai/travelai_screenshots_1.webp',
        ),
      ],
      statuses: [EntryStatus.earlyDevelopment],
    ),
    Entry(
      slug: 'visiostellar',
      title: L.same('Visiostellar'),
      subtitle: L('iOS astronomy app', tr: 'iOS astronomi uygulaması'),
      summary: L(
        'My first iOS app: space news, celestial objects and astronomy basics, written in Swift.',
        tr: 'İlk iOS uygulamam: uzay haberleri, gök cisimleri ve temel astronomi bilgileri, Swift ile.',
      ),
      overview: L(
        'Visiostellar is the iOS app I built when I started mobile development. Written in Swift with UIKit, it taught me the fundamentals: Storyboard and Auto Layout for screens that fit every iPhone, iOS navigation and Apple\'s design guidelines. It shows NASA news, celestial objects and short lessons about space.',
        tr: 'Visiostellar, mobil geliştirmeye başladığımda yaptığım iOS uygulaması. Swift ve UIKit ile yazdım; her iPhone\'a uyan ekranlar için Storyboard ve Auto Layout, iOS navigasyonu ve Apple\'ın tasarım rehberleri gibi temelleri bu projede öğrendim. NASA haberlerini, gök cisimlerini ve uzayla ilgili kısa bilgileri gösteriyor.',
      ),
      label: L('Education', tr: 'Eğitim'),
      logo: 'assets/images/visiostellar/visiostellar_logo.webp',
      tags: ['Swift', 'UIKit', 'Storyboard', 'Auto Layout', 'iOS', 'Xcode', 'MVC'],
      highlights: [
        Highlight(
          title: L('NASA feed', tr: 'NASA akışı'),
          description: L(
            'The latest NASA stories with images and short summaries.',
            tr: 'NASA\'dan son haberler, görseller ve kısa özetlerle.',
          ),
          label: L('Space news', tr: 'Uzay haberleri'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_3.webp',
          colors: [Color(0xFF2A3157), Color(0xFF0E1226)],
        ),
        Highlight(
          title: L('Topics', tr: 'Konular'),
          description: L(
            'Browse the archive by topic, from rovers to launches and the ISS.',
            tr: 'Arşivde konuya göre gezin: keşif araçlarından fırlatmalara ve ISS\'e.',
          ),
          label: L('Search', tr: 'Arama'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_5.webp',
        ),
        Highlight(
          title: L('Full stories', tr: 'Detaylı okuma'),
          description: L(
            'Each story opens to a longer summary with a link to nasa.gov.',
            tr: 'Her haber, nasa.gov bağlantısıyla birlikte daha uzun bir özete açılıyor.',
          ),
          label: L('Article', tr: 'Makale'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_6.webp',
        ),
        Highlight(
          title: L('Find a mission', tr: 'Görev bul'),
          description: L(
            'Results update as you type, for example every SpaceX resupply mission.',
            tr: 'Sonuçlar yazarken güncelleniyor; örneğin tüm SpaceX ikmal görevleri.',
          ),
          label: L('Live search', tr: 'Canlı arama'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_4.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı'),
          description: L(
            'Visiostellar, astronomy on the iPhone.',
            tr: 'Visiostellar, iPhone\'da astronomi.',
          ),
          label: L('Start', tr: 'Başlangıç'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_1.webp',
        ),
        Highlight(
          title: L('Home feed', tr: 'Ana akış'),
          description: L(
            'Image-first cards for each story, from Mars rocks to aircraft tests.',
            tr: 'Mars kayalarından uçak testlerine, her haber için görsel ağırlıklı kartlar.',
          ),
          label: L('Feed', tr: 'Akış'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_7.webp',
        ),
        Highlight(
          title: L('On nasa.gov', tr: 'nasa.gov\'da'),
          description: L(
            'The full article opens on nasa.gov without leaving the app.',
            tr: 'Haberin tamamı uygulamadan çıkmadan nasa.gov\'da açılıyor.',
          ),
          label: L('Source', tr: 'Kaynak'),
          image: 'assets/images/visiostellar/visiostellar_screenshots_2.webp',
        ),
      ],
      statuses: [EntryStatus.earlyProject],
    ),
    Entry(
      slug: 'peasy',
      title: L.same('Peasy'),
      subtitle: L('Self-checkout app', tr: 'Kendi kendine ödeme uygulaması'),
      summary: L(
        'A self-checkout app with NFC, built as our graduation project in a team of four.',
        tr: 'Dört kişilik ekibimizle bitirme projesi olarak geliştirdiğimiz, NFC ile çalışan bir self-checkout uygulaması.',
      ),
      overview: L(
        'Peasy is our graduation project, built by a team of four. It removes the checkout queue: customers scan products with their phone over NFC and pay in the app. A backend service recommends similar products based on purchase history and the current cart. It gave me real experience in team development, NFC and recommendation systems.',
        tr: 'Peasy, dört kişilik ekibimizle geliştirdiğimiz bitirme projemiz. Kasa kuyruğunu ortadan kaldırıyor: müşteri ürünleri telefonuyla NFC üzerinden okutuyor ve ödemeyi uygulamada yapıyor. Arka uçtaki servis, alışveriş geçmişine ve sepete göre benzer ürünler öneriyor. Bu proje bana ekip çalışması, NFC ve öneri sistemleri konusunda gerçek deneyim kazandırdı.',
      ),
      label: L('Retail', tr: 'Perakende'),
      logo: 'assets/images/peasy/peasy_logo.webp',
      tags: ['Flutter', 'Dart', 'NFC', 'Firebase', 'REST API', 'Recommendation systems'],
      highlights: [
        Highlight(
          title: L('Tap to scan', tr: 'Dokun ve okut'),
          description: L(
            'Hold the phone near a product\'s NFC tag to add it to the cart.',
            tr: 'Telefonu ürünün NFC etiketine yaklaştır, ürün sepete eklensin.',
          ),
          label: L('NFC checkout', tr: 'NFC ile ödeme'),
          image: 'assets/images/peasy/peasy_screenshots_3.webp',
          colors: [Color(0xFF1652B8), Color(0xFF07245E)],
        ),
        Highlight(
          title: L('Barcode too', tr: 'Barkod da olur'),
          description: L(
            'Products without a tag go into the cart by their barcode.',
            tr: 'Etiketi olmayan ürünler barkoduyla sepete ekleniyor.',
          ),
          label: L('Scanner', tr: 'Tarayıcı'),
          image: 'assets/images/peasy/peasy_screenshots_2.webp',
        ),
        Highlight(
          title: L('Pay in the app', tr: 'Uygulamada öde'),
          description: L(
            'Saved card, Apple Pay, Google Pay or PayPal, and no queue.',
            tr: 'Kayıtlı kart, Apple Pay, Google Pay veya PayPal; kuyruk yok.',
          ),
          label: L('Payments', tr: 'Ödeme'),
          image: 'assets/images/peasy/peasy_screenshots_5.webp',
        ),
        Highlight(
          title: L('Find the aisle', tr: 'Reyonu bul'),
          description: L(
            'See where a product is, and whether it is in stock or on sale.',
            tr: 'Ürünün hangi reyonda olduğunu, stokta ya da indirimde olup olmadığını gör.',
          ),
          label: L('Store map', tr: 'Mağaza haritası'),
          image: 'assets/images/peasy/peasy_screenshots_6.webp',
        ),
        Highlight(
          title: L('Launch screen', tr: 'Açılış ekranı'),
          description: L(
            'Peasy, checkout without the queue.',
            tr: 'Peasy, kuyruksuz ödeme.',
          ),
          label: L('Start', tr: 'Başlangıç'),
          image: 'assets/images/peasy/peasy_screenshots_1.webp',
        ),
        Highlight(
          title: L('Verify with a code', tr: 'Kodla doğrula'),
          description: L(
            'A one-time code sent by email or SMS keeps the account safe.',
            tr: 'E-posta veya SMS ile gelen tek kullanımlık kod hesabı güvende tutuyor.',
          ),
          label: L('Security', tr: 'Güvenlik'),
          image: 'assets/images/peasy/peasy_screenshots_7.webp',
        ),
        Highlight(
          title: L('Order summary', tr: 'Sipariş özeti'),
          description: L(
            'Subtotal, taxes and promotion codes before confirming the payment.',
            tr: 'Ödemeyi onaylamadan önce ara toplam, vergiler ve indirim kodu.',
          ),
          label: L('Checkout', tr: 'Ödeme'),
          image: 'assets/images/peasy/peasy_screenshots_4.webp',
        ),
      ],
      statuses: [EntryStatus.underDevelopment],
      link: EntryLink.github('https://github.com/ahmetkadircicek/peasy'),
    ),
  ],
);
