import 'package:flutter/painting.dart';
import 'package:portfolio/core/l10n/l10n.dart';

/// One project of the redesigned site: a row on the home page and a case
/// study at `/projects/<slug>`. Every sentence here was confirmed by Ahmet;
/// add nothing that he has not.
class Project {
  /// Route segment: `/projects/<slug>`.
  final String slug;
  final String name;

  /// The italic line after the name, e.g. "AI Song Maker".
  final L descriptor;

  /// The sentence under the title on the project page.
  final L lede;

  /// One line for the home page row.
  final L summary;

  /// Honest status for the home page row, e.g. "Personal · started at İBB".
  final L label;
  final L role;

  /// Platforms and years, e.g. "iOS & Android · 2024–2025".
  final L platform;
  final L status;
  final String stack;
  final String? repo;
  final String logo;

  /// The project's own color, used only as a light tint behind its screens.
  final Color color;

  /// Five screens for the cover, outermost to outermost; the third is the
  /// best one and stands in front. The home page shows the middle three.
  final List<String> cover;
  final List<Chapter> chapters;
  final List<Screen> screens;

  /// Technology by group, e.g. `(App, Flutter · Dart)`.
  final List<(L, String)> technology;

  /// Pages that belong to the project, e.g. its privacy policy: label, URL.
  final List<(L, String)> links;

  const Project({
    required this.slug,
    required this.name,
    required this.descriptor,
    required this.lede,
    required this.summary,
    required this.label,
    required this.role,
    required this.platform,
    required this.status,
    required this.stack,
    this.repo,
    required this.logo,
    required this.color,
    required this.cover,
    required this.chapters,
    required this.screens,
    required this.technology,
    this.links = const [],
  });

  String get path => '/projects/$slug';

  /// The three screens shown on the home page row.
  List<String> get rowScreens => cover.sublist(1, 4);
}

/// One section of a case study: a mono label, a serif lead and paragraphs.
class Chapter {
  final L label;
  final L lead;
  final List<L> body;

  const Chapter({required this.label, required this.lead, required this.body});
}

/// One screen in a project's gallery.
class Screen {
  final String image;
  final L title;
  final L caption;

  const Screen(this.image, {required this.title, required this.caption});
}

const _tunes = 'assets/images/tunes/tunes_screenshots';
const _vilsa = 'assets/images/vilsa/vilsa_screenshots';
const _sevk = 'assets/images/sevkiyatvar/sevkiyatvar_screenshots';
const _peasy = 'assets/images/peasy/peasy_screenshots';
const _chalko = 'assets/images/chalko/chalko_screenshots';

const _app = L('App', tr: 'Uygulama');
const _backend = L('Backend', tr: 'Backend');
const _design = L('Design', tr: 'Tasarım');

/// Every project, in home page order. The last one's "next project" leads
/// back to the first.
const work = [chalko, tunes, vilsa, sevkiyatvar, peasy];

const chalko = Project(
  slug: 'chalko',
  name: 'Chalko',
  descriptor: L('Drawing Party Game', tr: 'Çizerek Anlatma Oyunu'),
  lede: L(
    'A Turkish party game for iPhone and iPad: one player draws a word on a real board while their team guesses, and the app deals the words, runs the timer and keeps score.',
    tr: 'iPhone ve iPad için Türkçe bir parti oyunu: bir oyuncu kelimeyi gerçek bir tahtaya çizer, takımı tahmin eder; kelimeleri dağıtmak, süreyi tutmak ve puanı saymak uygulamanın işi.',
  ),
  summary: L(
    'Draw the word, your team guesses; the app keeps the time and the score.',
    tr: 'Kelimeyi çiz, takımın bilsin; süreyi ve puanı uygulama tutsun.',
  ),
  label: L('Personal · preparing for TestFlight', tr: 'Kişisel · TestFlight’a hazırlanıyor'),
  role: L('Solo — idea, design, code', tr: 'Tek başıma — fikir, tasarım, kod'),
  platform: L('iPhone & iPad · 2026', tr: 'iPhone ve iPad · 2026'),
  status: L('Preparing for TestFlight', tr: 'TestFlight’a hazırlanıyor'),
  stack: 'Swift · SwiftUI · Observation · AVFoundation',
  logo: 'assets/images/chalko/chalko_logo.webp',
  color: Color(0xFF3B7BFF),
  cover: ['${_chalko}_3.webp', '${_chalko}_1.webp', '${_chalko}_4.webp', '${_chalko}_6.webp', '${_chalko}_7.webp'],
  chapters: [
    Chapter(
      label: L('The idea', tr: 'Fikir'),
      lead: L(
        'A drawing game for a room full of people, where the phone stays out of the way.',
        tr: 'Kalabalık bir oda için bir çizim oyunu; telefon işin önüne geçmiyor.',
      ),
      body: [
        L(
          'One player draws on a whiteboard or on paper while their team guesses. Two to four teams play; before the game you pick the turn length, the number of rounds and the free passes per turn. A guessed word is a point; a pass is free until the turn’s free passes run out, then it costs a point. Teams with the same top score share the win, and a rematch starts with the same settings. It is my own project, from the idea to the code, built with AI coding assistants.',
          tr: 'Bir oyuncu tahtaya ya da kâğıda çizer, takımı tahmin eder. İki ila dört takım oynar; oyundan önce tur süresi, tur sayısı ve tur başına bedava pas seçilir. Bilinen kelime bir puan; pas, turun bedava pasları bitene kadar ücretsiz, sonra bir puan götürür. En yüksek puanda eşit kalan takımlar galibiyeti paylaşır, rövanş aynı ayarlarla başlar. Fikirden koda kendi projem; yapay zekâ kodlama asistanlarıyla geliştirdim.',
        ),
      ],
    ),
    Chapter(
      label: L('Design', tr: 'Tasarım'),
      lead: L(
        'Loud, chunky and readable on every team’s color.',
        tr: 'Gürültülü, tombul ve her takımın renginde okunur.',
      ),
      body: [
        L(
          'A cartoonish 3D style borrowed from mobile party games: thick dark ink outlines, hard drop shadows and SF Rounded in its Black weight. The whole background takes the color of the team that is playing, so badges and rows sit on white with a colored dot, or on lime when the team itself is yellow, and stay readable on all four colors. The copy is playful Turkish, like “Süre bitti, kalemler yere!”, time’s up, pens down.',
          tr: 'Mobil parti oyunlarından ödünç alınmış çizgi filmsi bir 3D stil: kalın koyu mürekkep konturları, sert gölgeler ve Black ağırlığında SF Rounded. Arka planın tamamı oynayan takımın rengini alıyor; rozetler ve satırlar bu yüzden renkli noktalı beyaz zeminde, takım sarıysa limon yeşilinde duruyor ve dört rengin hepsinde okunuyor. Metinler esprili bir Türkçe: “Süre bitti, kalemler yere!” gibi.',
        ),
      ],
    ),
    Chapter(
      label: L('Engineering', tr: 'Mühendislik'),
      lead: L(
        'One state machine, and a timer that cannot drift.',
        tr: 'Tek bir durum makinesi ve kayamayan bir sayaç.',
      ),
      body: [
        L(
          'Swift and SwiftUI with the Observation framework. One state machine drives every screen, from setup to the final scores. The timer is worked out from an end date checked every 200 ms rather than from counted ticks, so pausing is exact, and the game pauses itself when the app goes to the background. Sound plays on an ambient audio session, so it respects the silent switch and mixes with music already playing, and sound and haptics have their own switches.',
          tr: 'Observation framework ile Swift ve SwiftUI. Tek bir durum makinesi kurulumdan final skorlarına kadar her ekranı yönetiyor. Sayaç, sayılan tiklerden değil her 200 ms’de kontrol edilen bir bitiş zamanından hesaplanıyor; bu yüzden duraklatma tam isabetli ve uygulama arka plana geçince oyun kendini duraklatıyor. Ses, ambient bir ses oturumunda çalıyor; sessiz moda uyuyor ve çalan müziğe karışıyor. Ses ve titreşimin ayrı anahtarları var.',
        ),
        L(
          'Nothing leaves the phone: no account, no ads, no analytics. Settings and the history of seen words live in UserDefaults, and the App Store privacy answer is “Data Not Collected”. There are no unit tests yet; a UI test target takes the App Store screenshots, and I play-tested the game on an iPhone SE, an iPhone 17 Pro Max and an iPad Pro in the Simulator.',
          tr: 'Telefondan hiçbir şey çıkmıyor: hesap yok, reklam yok, analitik yok. Ayarlar ve görülen kelimelerin geçmişi UserDefaults’ta duruyor; App Store gizlilik cevabı “Veri Toplanmıyor”. Henüz birim testi yok; bir UI test hedefi App Store ekran görüntülerini çekiyor ve oyunu Simülatör’de iPhone SE, iPhone 17 Pro Max ve iPad Pro üzerinde oynayarak test ettim.',
        ),
      ],
    ),
    Chapter(
      label: L('The words', tr: 'Kelimeler'),
      lead: L(
        'The hardest part was never dealing the same word twice.',
        tr: 'En zor kısım, aynı kelimeyi asla iki kez vermemekti.',
      ),
      body: [
        L(
          'A word must not come back within a game, words nobody has seen in earlier games should come first, each level borrows a fixed slice of the level below, and undoing a turn or fixing the summary must not put a seen word back in the deck. Each game keeps a set of used words and each level a history of seen ones, and every new deck is drawn from words that are in neither. When a whole level has been seen, its history starts again from this game’s words.',
          tr: 'Bir kelime aynı oyunda geri gelmemeli, önceki oyunlarda kimsenin görmediği kelimeler önce çıkmalı, her seviye bir alt seviyeden sabit bir dilim almalı; turu geri almak ya da özeti düzeltmek görülmüş bir kelimeyi desteye geri koymamalı. Her oyun kullanılan kelimelerin, her seviye de görülenlerin kaydını tutuyor; her yeni deste ikisinde de olmayan kelimelerden çekiliyor. Bir seviyenin tamamı görülünce geçmişi bu oyunun kelimeleriyle yeniden başlıyor.',
        ),
        L(
          'Keeping the word secret came close. The drawer holds the phone while the team faces the board, so the word stays hidden until the card is pressed and held, and each new word opens for a moment and closes again.',
          tr: 'Kelimeyi gizli tutmak da az kalsın o kadar zordu. Çizen telefonu tutarken takım tahtaya bakıyor; bu yüzden kelime kart basılı tutulana kadar gizli kalıyor, her yeni kelime bir an açılıp yeniden kapanıyor.',
        ),
      ],
    ),
    Chapter(
      label: L('What I learned', tr: 'Öğrendiklerim'),
      lead: L('Curating beats volume.', tr: 'Seçmek, çoğaltmaktan iyidir.'),
      body: [
        L(
          'A quality pass flagged 127 words that were hard to draw or wrong for their level, and the lists went from 2,700 words to 2,607; keeping abstract words for the hardest level made the levels feel distinct. Real-time timers should come from end dates, not counted ticks. Party games need big targets, sound and haptic feedback, and corrections that forgive a wrong tap. And AI agents do mechanical work best when it comes as written tasks, with a separate build and review step afterwards.',
          tr: 'Bir kalite taraması çizmesi zor ya da seviyesine uymayan 127 kelime buldu; listeler 2.700 kelimeden 2.607’ye indi. Soyut kelimeleri en zor seviyeye ayırmak seviyeleri birbirinden belirgin şekilde ayırdı. Gerçek zamanlı sayaçlar sayılan tiklerden değil bitiş zamanlarından gelmeli. Parti oyunları büyük dokunma alanları, ses ve titreşim geri bildirimi ve yanlış dokunuşu affeden düzeltmeler ister. Yapay zekâ ajanları da mekanik işi en iyi yazılı görevler olarak aldıklarında yapıyor; ardından ayrı bir build ve inceleme adımıyla.',
        ),
      ],
    ),
  ],
  screens: [
    Screen('${_chalko}_1.webp',
        title: L('Play', tr: 'Oyna'),
        caption: L('The home screen: Play, a quick start with its settings underneath, and buttons for sound, haptics, settings and help.',
            tr: 'Ana ekran: Oyna, ayarları altında yazan hızlı başlat ve ses, titreşim, ayarlar ve yardım düğmeleri.')),
    Screen('${_chalko}_2.webp',
        title: L('Choose how hard', tr: 'Zorluğu seç'),
        caption: L('The four levels with their word counts, and the game’s settings above the start button.',
            tr: 'Kelime sayılarıyla dört seviye ve başlat düğmesinin üstünde oyunun ayarları.')),
    Screen('${_chalko}_3.webp',
        title: L('Whose turn is it?', tr: 'Sıra kimde?'),
        caption: L('After the opening draw: the starting team, a reminder to hide the phone and the scoreboard.',
            tr: 'Açılış kurasından sonra: başlayan takım, telefonu saklama hatırlatması ve puan tablosu.')),
    Screen('${_chalko}_4.webp',
        title: L('Draw it, don’t say it', tr: 'Çiz, söyleme'),
        caption: L('The secret word, the countdown, the turn score, undo, and Pas and Bildi.',
            tr: 'Gizli kelime, geri sayım, tur puanı, geri al ve Pas ile Bildi.')),
    Screen('${_chalko}_5.webp',
        title: L('Pens down', tr: 'Kalemler yere'),
        caption: L('Time is up, and the team says whether the last word was guessed in time.',
            tr: 'Süre bitti; takım son kelimenin zamanında bilinip bilinmediğini söylüyor.')),
    Screen('${_chalko}_6.webp',
        title: L('Fix a mis-tap', tr: 'Yanlış dokunuşu düzelt'),
        caption: L('Every word of the turn; a tap flips Bildi and Pas and the score follows.',
            tr: 'Turun her kelimesi; bir dokunuş Bildi ile Pas’ı değiştirir, puan da takip eder.')),
    Screen('${_chalko}_7.webp',
        title: L('And the winner is', tr: 'Ve kazanan'),
        caption: L('The final scores with a rematch button.', tr: 'Rövanş düğmesiyle final skorları.')),
    Screen('${_chalko}_8.webp',
        title: L('The rules in one card', tr: 'Tek kartta kurallar'),
        caption: L('How to play, shown on first launch.', tr: 'Nasıl oynanır; ilk açılışta gösterilir.')),
  ],
  technology: [
    (_app, 'Swift, SwiftUI, Observation'),
    (L('Data', tr: 'Veri'), 'UserDefaults, bundled word lists'),
    (L('Sound', tr: 'Ses'), 'AVAudioPlayer, UIFeedbackGenerator, CC0 sounds from Kenney.nl'),
    (L('Tooling', tr: 'Araçlar'), 'XcodeGen, Xcode UI tests, Claude Code, Google Antigravity'),
  ],
  links: [
    (L('Privacy policy', tr: 'Gizlilik politikası'), 'https://ahmetkadircicek.com.tr/chalko/privacy'),
    (L('Support', tr: 'Destek'), 'https://ahmetkadircicek.com.tr/chalko/support'),
  ],
);

const tunes = Project(
  slug: 'tunes',
  name: 'Tunes',
  descriptor: L('AI Song Maker', tr: 'Yapay Zekâ Şarkı Stüdyosu'),
  lede: L(
    'A song in a few taps: name it, write the lyrics, pick a genre, key and tempo, and Tunes makes the music and the cover.',
    tr: 'Birkaç dokunuşla bir şarkı: adını koy, sözlerini yaz, türünü, tonunu ve temposunu seç; müziği ve kapağı Tunes yapsın.',
  ),
  summary: L(
    'Songs made with AI, shaped by your taste and mood.',
    tr: 'Zevkine ve ruh haline göre yapay zekâyla yapılan şarkılar.',
  ),
  label: L('Personal · started at İBB', tr: 'Kişisel · İBB’de başladı'),
  role: L('Solo — research, design, code', tr: 'Tek başıma — araştırma, tasarım, kod'),
  platform: L('iOS & Android · 2024–2025', tr: 'iOS ve Android · 2024–2025'),
  status: L('Preparing for the App Store', tr: 'App Store’a hazırlanıyor'),
  stack: 'Flutter · Riverpod · Firebase · Replicate',
  logo: 'assets/images/tunes/tunes_logo.webp',
  color: Color(0xFFFF8225),
  cover: ['${_tunes}_2.webp', '${_tunes}_3.webp', '${_tunes}_8.webp', '${_tunes}_4.webp', '${_tunes}_6.webp'],
  chapters: [
    Chapter(
      label: L('The idea', tr: 'Fikir'),
      lead: L(
        'AI music tools felt like studio software, and few of them worked well on a phone.',
        tr: 'Yapay zekâ müzik araçları stüdyo yazılımı gibiydi ve çok azı telefonda iyi çalışıyordu.',
      ),
      body: [
        L(
          'I wanted the opposite: a short, guided flow made for mobile. You name the track, write the lyrics, pick genres, a key and a tempo, and Tunes makes the song and its cover. Everything you make stays in your own library. It started during my internship at İBB, and I have kept building it since.',
          tr: 'Ben tersini istedim: mobil için yapılmış kısa, yol gösteren bir akış. Parçaya ad verirsin, sözleri yazarsın, türleri, tonu ve tempoyu seçersin; Tunes şarkıyı ve kapağını yapar. Yaptığın her şey kendi kitaplığında kalır. İBB stajımda başladı ve o günden beri geliştirmeye devam ediyorum.',
        ),
      ],
    ),
    Chapter(
      label: L('Design', tr: 'Tasarım'),
      lead: L(
        'Three weeks of research, two of design, and every screen in Figma before the first line of code.',
        tr: 'Üç hafta araştırma, iki hafta tasarım ve ilk satır koddan önce Figma’da her ekran.',
      ),
      body: [
        L(
          'Orange for warmth and energy, a vinyl record as the mark. The type scale matches Apple’s Dynamic Type sizes one to one. When I measured the palette later, white text on the brand orange came out at 2.48:1, under the 4.5:1 minimum, so text on orange moves to a deeper #C83F0A. I tested the flow with friends and changed it from what they told me.',
          tr: 'Sıcaklık ve enerji için turuncu, işaret olarak bir plak. Yazı ölçeği Apple’ın Dynamic Type boyutlarıyla birebir aynı. Paleti sonradan ölçtüğümde marka turuncusu üzerindeki beyaz metin 2.48:1 çıktı, 4.5:1 sınırının altında; bu yüzden turuncu üzerindeki metin daha koyu bir #C83F0A’ya geçiyor. Akışı arkadaşlarımla test ettim ve söylediklerine göre değiştirdim.',
        ),
      ],
    ),
    Chapter(
      label: L('Engineering', tr: 'Mühendislik'),
      lead: L(
        'The first version ran on Provider and MVVM. Getting it ready for release meant rebuilding the base.',
        tr: 'İlk sürüm Provider ve MVVM ile çalışıyordu. Yayına hazırlamak, temeli yeniden kurmak demekti.',
      ),
      body: [
        L(
          'State is moving to Riverpod, navigation to go_router and models to Freezed, and the dependencies go from about thirty to sixteen. Song generation moves to Cloud Functions: the Replicate key never reaches the phone, a song keeps generating if the app closes, and a credit is spent only in the same transaction that saves the finished track.',
          tr: 'State Riverpod’a, navigasyon go_router’a, modeller Freezed’e taşınıyor; bağımlılıklar otuz civarından on altıya iniyor. Şarkı üretimi Cloud Functions’a geçiyor: Replicate anahtarı telefona hiç ulaşmıyor, uygulama kapansa da şarkı üretilmeye devam ediyor ve kredi yalnızca bitmiş parçayı kaydeden işlemle birlikte düşüyor.',
        ),
        L(
          'The hardest part for the listener was audio. Tracks keep playing in the background with lock screen controls, and one track flows into the next without a gap.',
          tr: 'Dinleyen için en zor kısım sesti. Parçalar kilit ekranı kontrolleriyle arka planda çalmaya devam ediyor ve bir parça diğerine boşluksuz geçiyor.',
        ),
      ],
    ),
    Chapter(
      label: L('Business', tr: 'İş modeli'),
      lead: L(
        'The first goal is not profit. It is not losing money.',
        tr: 'İlk hedef kâr değil. Zarar etmemek.',
      ),
      body: [
        L(
          'Every song costs real money to make, so I planned the numbers before the screens. Two free songs per account and device keep a new user’s cost small, and a spending limit on the generation service caps the worst case. After that, credits come in three packs with the largest as the best value, and no fake discounts or countdowns. Free songs unlock with a rewarded ad that you can always skip.',
          tr: 'Her şarkının üretimi gerçek para tutuyor, bu yüzden rakamları ekranlardan önce planladım. Hesap ve cihaz başına iki ücretsiz şarkı yeni bir kullanıcının maliyetini küçük tutuyor, üretim servisindeki harcama limiti de en kötü durumu sınırlıyor. Sonrasında krediler üç pakette geliyor, en büyüğü en avantajlısı; sahte indirim ya da geri sayım yok. Ücretsiz şarkılar, her zaman geçilebilen ödüllü bir reklamla açılıyor.',
        ),
        L(
          'The first release goes to the US, UK, Canada, Australia and New Zealand. The EU requires public trader details under the DSA, and in Türkiye ad revenue would cover only a small part of each song’s cost.',
          tr: 'İlk yayın ABD, İngiltere, Kanada, Avustralya ve Yeni Zelanda’ya. AB, DSA kapsamında satıcı bilgilerinin herkese açık olmasını istiyor; Türkiye’de ise reklam geliri her şarkının maliyetinin yalnızca küçük bir kısmını karşılardı.',
        ),
      ],
    ),
    Chapter(
      label: L('What I learned', tr: 'Öğrendiklerim'),
      lead: L(
        'How a product is built end to end, not just coded.',
        tr: 'Bir ürünün sadece kodlanmadığını, uçtan uca nasıl yapıldığını.',
      ),
      body: [
        L(
          'Planning in phases and keeping to them. What AI services really cost, and how that shapes the product. And how an app can pay for itself without getting in the way of the person using it.',
          tr: 'Aşamalarla planlamayı ve plana sadık kalmayı. Yapay zekâ servislerinin gerçek maliyetini ve bunun ürünü nasıl şekillendirdiğini. Ve bir uygulamanın, onu kullanan kişinin önüne geçmeden kendi masrafını nasıl çıkarabileceğini.',
        ),
      ],
    ),
  ],
  screens: [
    Screen('${_tunes}_1.webp',
        title: L('Start', tr: 'Başlangıç'),
        caption: L('The Tunes wordmark while the app gets ready.', tr: 'Uygulama hazırlanırken Tunes yazısı.')),
    Screen('${_tunes}_8.webp',
        title: L('Create', tr: 'Oluştur'),
        caption: L('Choose a length, name your melody and start a new track.',
            tr: 'Bir uzunluk seç, melodine ad ver ve yeni bir parçaya başla.')),
    Screen('${_tunes}_4.webp',
        title: L('Key', tr: 'Ton'),
        caption: L('The key sets the overall feel of the track, from C minor to G major.',
            tr: 'Ton, parçanın genel havasını belirler; Do minörden Sol majöre.')),
    Screen('${_tunes}_6.webp',
        title: L('Generating', tr: 'Üretiliyor'),
        caption: L('The AI works on the track while you browse your other songs.',
            tr: 'Sen diğer şarkılarına göz atarken yapay zekâ parçayı hazırlar.')),
    Screen('${_tunes}_3.webp',
        title: L('Player', tr: 'Oynatıcı'),
        caption: L('Cover, genre, key and simple playback controls.', tr: 'Kapak, tür, ton ve sade oynatma kontrolleri.')),
    Screen('${_tunes}_2.webp',
        title: L('Library', tr: 'Kitaplık'),
        caption: L('Every track you created, with its genre and key.', tr: 'Oluşturduğun her parça, türü ve tonuyla.')),
    Screen('${_tunes}_7.webp',
        title: L('Settings', tr: 'Ayarlar'),
        caption: L('Appearance options and English, Turkish and German.', tr: 'Görünüm seçenekleri; İngilizce, Türkçe ve Almanca.')),
    Screen('${_tunes}_5.webp',
        title: L('Ads', tr: 'Reklamlar'),
        caption: L('Google AdMob, shown here in test mode.', tr: 'Google AdMob, burada test modunda.')),
  ],
  technology: [
    (_app, 'Flutter, Dart, Riverpod, go_router, Freezed'),
    (_backend, 'Firebase Auth, Cloud Firestore, Cloud Functions, Firebase Storage'),
    (L('Audio', tr: 'Ses'), 'just_audio, background playback'),
    (L('Services', tr: 'Servisler'), 'Replicate, Google AdMob'),
    (_design, 'Figma'),
  ],
);

const vilsa = Project(
  slug: 'vilsa',
  name: 'Vilsa',
  descriptor: L('Dividend Tracker', tr: 'Temettü Takibi'),
  lede: L(
    'A personal portfolio tracker: add your own markets and stocks, log every trade and dividend, and see how it is doing over any period.',
    tr: 'Kişisel bir portföy takipçisi: kendi borsalarını ve hisselerini ekle, her işlemi ve temettüyü kaydet, istediğin dönemde nasıl gittiğini gör.',
  ),
  summary: L(
    'Tracks stocks across markets and estimates the dividends to come.',
    tr: 'Hisseleri borsalar arasında takip eder, gelecek temettüleri tahmin eder.',
  ),
  label: L('Archived · open source', tr: 'Arşivlendi · açık kaynak'),
  role: L('Solo — design and code', tr: 'Tek başıma — tasarım ve kod'),
  platform: L('iOS & Android · 2025', tr: 'iOS ve Android · 2025'),
  status: L('Archived · open source', tr: 'Arşivlendi · açık kaynak'),
  stack: 'Flutter · Provider · Firebase · fl_chart',
  repo: 'https://github.com/ahmetkadircicek/vilsa',
  logo: 'assets/images/vilsa/vilsa_logo.webp',
  color: Color(0xFF5908FA),
  cover: ['${_vilsa}_3.webp', '${_vilsa}_4.webp', '${_vilsa}_6.webp', '${_vilsa}_2.webp', '${_vilsa}_7.webp'],
  chapters: [
    Chapter(
      label: L('The idea', tr: 'Fikir'),
      lead: L(
        'I wanted a project built around numbers and charts, and a clean Flutter codebase I could share.',
        tr: 'Rakamlar ve grafikler etrafında kurulmuş bir proje ve paylaşabileceğim temiz bir Flutter kodu istedim.',
      ),
      body: [
        L(
          'Vilsa tracks a portfolio you enter yourself. You define the markets, add stocks and log every buy and every dividend; the app does the maths: cost, returns, yield and an estimate of the dividends to come. It taught me what I set out to learn, so it is archived now, with its code open.',
          tr: 'Vilsa, kendi girdiğin bir portföyü takip eder. Borsaları tanımlarsın, hisseleri eklersin, her alımı ve her temettüyü kaydedersin; hesabı uygulama yapar: maliyet, getiri, verim ve gelecek temettülerin tahmini. Öğrenmek istediğimi bana öğretti; bu yüzden artık arşivde, kodu açık.',
        ),
      ],
    ),
    Chapter(
      label: L('Design', tr: 'Tasarım'),
      lead: L(
        'Purple for trust and calm, away from the red and green that make finance apps feel tense.',
        tr: 'Güven ve sakinlik için mor; finans uygulamalarını gergin hissettiren kırmızı ve yeşilden uzak.',
      ),
      body: [
        L(
          'I looked at existing trackers first, drew the main screens in Figma and refined the rest while building. The home screen is built around one chart: pick a period and every figure on the screen follows it. Entering data had to be quick, so prices format as you type, dates come from a picker, sensible defaults are filled in, and a swipe edits or deletes a transaction.',
          tr: 'Önce mevcut takip uygulamalarına baktım, ana ekranları Figma’da çizdim, kalanını geliştirirken netleştirdim. Ana ekran tek bir grafiğin etrafında kurulu: bir dönem seç, ekrandaki her rakam onu izlesin. Veri girişi hızlı olmalıydı; fiyatlar yazarken biçimleniyor, tarihler bir seçiciden geliyor, mantıklı varsayılanlar dolu geliyor ve bir kaydırmayla işlem düzenleniyor ya da siliniyor.',
        ),
      ],
    ),
    Chapter(
      label: L('Engineering', tr: 'Mühendislik'),
      lead: L(
        'The hard part was not storing the data. It was getting the numbers right.',
        tr: 'Zor olan veriyi saklamak değildi. Rakamları doğru çıkarmaktı.',
      ),
      body: [
        L(
          'Every figure comes from what the user typed, across several buy prices and dividends over time, and a small date or rounding slip shows up on every screen. The code follows MVVM with Provider: views stay thin, view models hold the state and the maths, services talk to Firebase, and charts are drawn with fl_chart.',
          tr: 'Her rakam kullanıcının yazdığından geliyor; farklı alış fiyatları ve zamana yayılan temettüler arasında küçük bir tarih ya da yuvarlama hatası her ekranda görünüyor. Kod, Provider ile MVVM izliyor: view’lar ince kalıyor, view model’ler state’i ve hesabı tutuyor, servisler Firebase ile konuşuyor ve grafikler fl_chart ile çiziliyor.',
        ),
      ],
    ),
    Chapter(
      label: L('Open source', tr: 'Açık kaynak'),
      lead: L('The code is public, on purpose.', tr: 'Kod bilerek herkese açık.'),
      body: [
        L(
          'I wanted a clean Flutter example: a shared base view model, thin views, small services and reusable components. It shows how I structure an app, and anyone building their own tracker can start from it.',
          tr: 'Temiz bir Flutter örneği istedim: ortak bir base view model, ince view’lar, küçük servisler ve tekrar kullanılabilir bileşenler. Bir uygulamayı nasıl kurduğumu gösteriyor ve kendi takipçisini yapmak isteyen herkes buradan başlayabilir.',
        ),
      ],
    ),
    Chapter(
      label: L('What I learned', tr: 'Öğrendiklerim'),
      lead: L('Financial data forgives nothing.', tr: 'Finansal veri hiçbir hatayı affetmez.'),
      body: [
        L(
          'Working with money made me exact about dates, ranges and rounding. Drawing the charts showed me that a chart is only as clear as the question it answers. A clean architecture made the project easy to come back to, and keeping the scope small is what let me finish it.',
          tr: 'Parayla çalışmak beni tarihler, aralıklar ve yuvarlama konusunda titiz yaptı. Grafikleri çizmek, bir grafiğin ancak cevapladığı soru kadar net olduğunu gösterdi. Temiz bir mimari projeye geri dönmeyi kolaylaştırdı; kapsamı küçük tutmak da bitirmemi sağladı.',
        ),
      ],
    ),
  ],
  screens: [
    Screen('${_vilsa}_1.webp',
        title: L('Start', tr: 'Başlangıç'), caption: L('Vilsa, financial management.', tr: 'Vilsa, finansal yönetim.')),
    Screen('${_vilsa}_6.webp',
        title: L('Home', tr: 'Ana sayfa'),
        caption: L('Total balance, dividends and a line chart of the chosen period.',
            tr: 'Toplam bakiye, temettüler ve seçilen dönemin çizgi grafiği.')),
    Screen('${_vilsa}_7.webp',
        title: L('Charts', tr: 'Grafikler'),
        caption: L('The same period as bars, one tap away.', tr: 'Aynı dönem, bir dokunuşla çubuk grafik.')),
    Screen('${_vilsa}_5.webp',
        title: L('Holdings', tr: 'Hisseler'),
        caption: L('Sort holdings by name, quantity, total value or average price.',
            tr: 'Hisseleri ada, adede, toplam değere ya da ortalama fiyata göre sırala.')),
    Screen('${_vilsa}_4.webp',
        title: L('Detail', tr: 'Detay'),
        caption: L('Cost, average price, dividend yield and every transaction for one stock.',
            tr: 'Bir hissenin maliyeti, ortalama fiyatı, temettü verimi ve her işlemi.')),
    Screen('${_vilsa}_3.webp',
        title: L('Transactions', tr: 'İşlemler'),
        caption: L('Date, buy price, quantity, dividend and a note.', tr: 'Tarih, alış fiyatı, adet, temettü ve bir not.')),
    Screen('${_vilsa}_2.webp',
        title: L('Period', tr: 'Dönem'),
        caption: L('Pick any range and every figure follows it.', tr: 'Herhangi bir aralık seç, her rakam onu izlesin.')),
  ],
  technology: [
    (_app, 'Flutter, Dart, Provider, MVVM'),
    (L('Data', tr: 'Veri'), 'Firebase Realtime Database, local cache'),
    (L('Charts', tr: 'Grafikler'), 'fl_chart'),
    (L('Input', tr: 'Giriş'), 'Price formatting, date picker, swipe actions'),
    (_design, 'Figma'),
  ],
);

const sevkiyatvar = Project(
  slug: 'sevkiyatvar',
  name: 'Sevkiyatvar',
  descriptor: L('Freight Marketplace', tr: 'Yük Pazaryeri'),
  lede: L(
    'A freight marketplace on mobile: shippers post loads, carriers find them by route, and both sides follow their jobs in one place.',
    tr: 'Mobilde bir yük pazaryeri: yük sahipleri ilan açar, taşıyıcılar güzergâha göre bulur ve iki taraf da işlerini tek yerden takip eder.',
  ),
  summary: L(
    'A clearer Flutter rebuild of a freight app for drivers and dispatchers.',
    tr: 'Sürücüler ve operasyon ekipleri için bir yük uygulamasının daha sade Flutter ile yeniden yapımı.',
  ),
  label: L('Client project', tr: 'Müşteri projesi'),
  role: L('Freelance — mobile app', tr: 'Freelance — mobil uygulama'),
  platform: L('iOS & Android · 2024–2025', tr: 'iOS ve Android · 2024–2025'),
  status: L('Client project · delivered', tr: 'Müşteri projesi · teslim edildi'),
  stack: 'Flutter · Provider · REST API · OneSignal',
  logo: 'assets/images/sevkiyatvar/sevkiyatvar_logo.webp',
  color: Color(0xFFFF6A00),
  cover: ['${_sevk}_7.webp', '${_sevk}_2.webp', '${_sevk}_6.webp', '${_sevk}_3.webp', '${_sevk}_4.webp'],
  chapters: [
    Chapter(
      label: L('The brief', tr: 'İstek'),
      lead: L(
        'Modernise the client’s freight app, and run iOS and Android from one codebase.',
        tr: 'Müşterinin yük uygulamasını modernleştirmek; iOS ve Android’i tek kod tabanından çalıştırmak.',
      ),
      body: [
        L(
          'Sevkiyatvar is a load board. Shippers and logistics companies post loads; carriers and drivers filter them by route and get in touch with a call, a message or an offer. I rebuilt the mobile app in Flutter on top of the client’s existing backend, while their website stayed as it was.',
          tr: 'Sevkiyatvar bir yük ilanı platformu. Yük sahipleri ve lojistik firmaları ilan açıyor; taşıyıcılar ve sürücüler ilanları güzergâha göre süzüp arayarak, mesajla ya da teklif vererek iletişime geçiyor. Mobil uygulamayı müşterinin mevcut backend’i üzerinde Flutter ile yeniden yaptım; web sitesi olduğu gibi kaldı.',
        ),
      ],
    ),
    Chapter(
      label: L('Design', tr: 'Tasarım'),
      lead: L(
        'Designed together with the client, one screen at a time.',
        tr: 'Müşteriyle birlikte, ekran ekran tasarlandı.',
      ),
      body: [
        L(
          'The brand’s orange stayed. Listings had to read at a glance, so each one shows its route, vehicle and date in a single row with one action. The long listing form got a clearer layout: origin and destination first, then the vehicle and the load, then the date.',
          tr: 'Markanın turuncusu kaldı. İlanlar bir bakışta okunmalıydı; her biri güzergâhını, aracını ve tarihini tek satırda, tek bir eylemle gösteriyor. Uzun ilan formu daha net bir düzene kavuştu: önce nereden ve nereye, sonra araç ve yük, en son tarih.',
        ),
      ],
    ),
    Chapter(
      label: L('Engineering', tr: 'Mühendislik'),
      lead: L('A new app on an existing backend.', tr: 'Mevcut bir backend üzerinde yeni bir uygulama.'),
      body: [
        L(
          'The API was already there, so the app had to speak its language exactly: its endpoints, its formats and its edge cases. In the field connections drop, so the app says so plainly, keeps the last listings on screen and retries when the connection is back. Notifications run on OneSignal and FCM, so shippers hear about their listings and carriers hear about new loads on their routes. The code follows MVVM with Provider.',
          tr: 'API zaten vardı; uygulama onun dilini birebir konuşmalıydı: uç noktalarını, biçimlerini ve uç durumlarını. Sahada bağlantı kopuyor; uygulama bunu açıkça söylüyor, son ilanları ekranda tutuyor ve bağlantı gelince yeniden deniyor. Bildirimler OneSignal ve FCM ile çalışıyor; yük sahipleri ilanlarından, taşıyıcılar güzergâhlarındaki yeni yüklerden haberdar oluyor. Kod, Provider ile MVVM izliyor.',
        ),
      ],
    ),
    Chapter(
      label: L('Delivery', tr: 'Teslim'),
      lead: L('Handed over ready for release.', tr: 'Yayına hazır halde teslim edildi.'),
      body: [
        L(
          'I versioned every build, shared test builds with the client, collected their feedback and fixed what came back, until the app was delivered ready for the stores.',
          tr: 'Her build’i sürümledim, test build’lerini müşteriyle paylaştım, geri bildirimlerini toplayıp gelenleri düzelttim; ta ki uygulama mağazalara hazır halde teslim edilene kadar.',
        ),
      ],
    ),
    Chapter(
      label: L('What I learned', tr: 'Öğrendiklerim'),
      lead: L('Building for someone else’s users.', tr: 'Başkasının kullanıcıları için yapmak.'),
      body: [
        L(
          'Working on a system I did not design taught me to read before I write. Working directly with a client taught me to agree on scope and timelines early. And designing for drivers in the field taught me that speed and clarity beat everything else.',
          tr: 'Benim tasarlamadığım bir sistem üzerinde çalışmak, yazmadan önce okumayı öğretti. Doğrudan bir müşteriyle çalışmak, kapsam ve takvim üzerinde erkenden anlaşmayı öğretti. Sahadaki sürücüler için tasarlamak da hızın ve netliğin her şeyden önemli olduğunu öğretti.',
        ),
      ],
    ),
  ],
  screens: [
    Screen('${_sevk}_1.webp',
        title: L('Start', tr: 'Başlangıç'),
        caption: L('Sevkiyatvar, stronger together.', tr: 'Sevkiyatvar, hep birlikte çok daha güçlü.')),
    Screen('${_sevk}_7.webp',
        title: L('Account', tr: 'Hesap'),
        caption: L('Companies register once to post loads and see open listings.',
            tr: 'Firmalar bir kez kaydolup ilan açar ve açık ilanları görür.')),
    Screen('${_sevk}_6.webp',
        title: L('Listings', tr: 'İlanlar'),
        caption: L('Routes, vehicle types and dates, filtered by origin and destination.',
            tr: 'Güzergâhlar, araç tipleri ve tarihler; nereden ve nereye göre süzülür.')),
    Screen('${_sevk}_4.webp',
        title: L('Detail', tr: 'Detay'),
        caption: L('Everything about a load, with call and WhatsApp buttons.',
            tr: 'Bir yükle ilgili her şey; arama ve WhatsApp düğmeleriyle.')),
    Screen('${_sevk}_2.webp',
        title: L('New listing', tr: 'Yeni ilan'),
        caption: L('Origin, destination, vehicle, body and load type in one form.',
            tr: 'Nereden, nereye, araç, kasa ve yük tipi tek formda.')),
    Screen('${_sevk}_3.webp',
        title: L('Tracking', tr: 'İş takibi'),
        caption: L('Accepted jobs, offers and your own listings in separate tabs.',
            tr: 'Alınan işler, teklifler ve kendi ilanların ayrı sekmelerde.')),
  ],
  technology: [
    (_app, 'Flutter, Dart, Provider, MVVM'),
    (_backend, 'The client’s existing REST API'),
    (L('Notifications', tr: 'Bildirimler'), 'OneSignal, Firebase Cloud Messaging'),
    (L('Network', tr: 'Ağ'), 'Connectivity checks and retries'),
  ],
);

const peasy = Project(
  slug: 'peasy',
  name: 'Peasy',
  descriptor: L('NFC Checkout', tr: 'NFC ile Ödeme'),
  lede: L(
    'Shopping without the checkout queue: tap a product’s tag or scan its barcode, and pay in the app.',
    tr: 'Kasa kuyruğu olmadan alışveriş: ürünün etiketine dokun ya da barkodunu okut, ödemeyi uygulamada yap.',
  ),
  summary: L(
    'Scan products with NFC and pay without the checkout queue.',
    tr: 'Ürünleri NFC ile okut, kasa kuyruğuna girmeden öde.',
  ),
  label: L('Graduation project · team of 4', tr: 'Bitirme projesi · 4 kişilik ekip'),
  role: L('Mobile app and design · team of 4', tr: 'Mobil uygulama ve tasarım · 4 kişilik ekip'),
  platform: L('iOS & Android · 2024–2025', tr: 'iOS ve Android · 2024–2025'),
  status: L('Graduation project · open source', tr: 'Bitirme projesi · açık kaynak'),
  stack: 'Flutter · Provider · Firebase · NFC',
  repo: 'https://github.com/ahmetkadircicek/peasy',
  logo: 'assets/images/peasy/peasy_logo.webp',
  color: Color(0xFF1652B8),
  cover: ['${_peasy}_2.webp', '${_peasy}_6.webp', '${_peasy}_3.webp', '${_peasy}_5.webp', '${_peasy}_4.webp'],
  chapters: [
    Chapter(
      label: L('The problem', tr: 'Problem'),
      lead: L('The slowest part of shopping is the queue at the till.',
          tr: 'Alışverişin en yavaş kısmı kasadaki kuyruktur.'),
      body: [
        L(
          'Peasy moves the checkout into the customer’s phone. Hold the phone to a product’s NFC tag, or scan its barcode if it has no tag, and it goes into the cart. Browse by section, see what is in stock or on sale, pay in the app and keep the receipt there. It was our graduation project, built by a team of four.',
          tr: 'Peasy kasayı müşterinin telefonuna taşıyor. Telefonu ürünün NFC etiketine yaklaştır ya da etiketi yoksa barkodunu okut; ürün sepete girsin. Bölümlere göre gez, stokta ya da indirimde olanı gör, uygulamada öde ve fişini orada sakla. Dört kişilik bir ekiple yaptığımız bitirme projemizdi.',
        ),
      ],
    ),
    Chapter(
      label: L('Design', tr: 'Tasarım'),
      lead: L('I owned the design, so every screen had to explain itself.',
          tr: 'Tasarım bendeydi, bu yüzden her ekranın kendini anlatması gerekiyordu.'),
      body: [
        L(
          'Deep blue, for trust: this is an app that takes payments. The scanner opens a clear “Ready to scan” sheet over the camera, so it is always obvious what the phone expects. Before paying you see the subtotal, taxes and any promotion code in one place, and a one-time code confirms the account.',
          tr: 'Güven için koyu mavi: bu, ödeme alan bir uygulama. Tarayıcı kameranın üzerinde net bir “Okutmaya hazır” sayfası açıyor; telefonun ne beklediği her zaman belli. Ödemeden önce ara toplamı, vergileri ve varsa promosyon kodunu tek yerde görüyorsun; tek kullanımlık bir kod da hesabı doğruluyor.',
        ),
      ],
    ),
    Chapter(
      label: L('Engineering', tr: 'Mühendislik'),
      lead: L('The hard part was making a tag read every single time.',
          tr: 'Zor olan, etiketin her seferinde okunmasını sağlamaktı.'),
      body: [
        L(
          'iOS and Android handle NFC differently, from how a session starts to how long it waits, and a checkout cannot miss a product. Scanning had to work on both, fall back to the barcode when a product had no tag, and turn a tag id into a product with its price, stock and sale in one lookup. Sign-in runs on Firebase Auth with Google and Apple, products and receipts live in Cloud Firestore, and the app works in Turkish and English.',
          tr: 'iOS ve Android NFC’yi farklı ele alıyor; oturumun nasıl başladığından ne kadar beklediğine kadar. Bir kasa ise hiçbir ürünü kaçıramaz. Okuma iki platformda da çalışmalı, etiketi olmayan üründe barkoda geçmeli ve bir etiket kimliğini tek sorguda fiyatı, stoğu ve indirimiyle bir ürüne çevirmeliydi. Giriş Google ve Apple ile Firebase Auth üzerinden, ürünler ve fişler Cloud Firestore’da; uygulama Türkçe ve İngilizce çalışıyor.',
        ),
      ],
    ),
    Chapter(
      label: L('Teamwork', tr: 'Ekip çalışması'),
      lead: L('Four people, one app.', tr: 'Dört kişi, tek uygulama.'),
      body: [
        L(
          'I built the mobile app and designed it; the others took the backend, the NFC tags and test setup, and the report, presentation and testing. We agreed on the data model first, met every week and merged often with Git, which kept four pieces of work fitting together.',
          tr: 'Mobil uygulamayı ben yaptım ve tasarladım; diğerleri backend’i, NFC etiketlerini ve test düzenini, raporu, sunumu ve testleri üstlendi. Önce veri modelinde anlaştık, her hafta buluştuk ve Git ile sık sık birleştirdik; dört parça iş böylece birbirine uydu.',
        ),
      ],
    ),
    Chapter(
      label: L('What I learned', tr: 'Öğrendiklerim'),
      lead: L('Software that touches the physical world is a different kind of hard.',
          tr: 'Fiziksel dünyaya dokunan yazılım, başka türlü bir zorluk.'),
      body: [
        L(
          'Working with tags and real devices taught me to test on hardware early. Working in a team taught me to divide the work clearly and talk often. Designing the payment taught me that it has to feel safe before it feels fast. And owning the design meant making decisions, not waiting for them.',
          tr: 'Etiketlerle ve gerçek cihazlarla çalışmak, donanımda erkenden test etmeyi öğretti. Ekipte çalışmak, işi net bölmeyi ve sık konuşmayı öğretti. Ödemeyi tasarlamak, hızlı hissettirmeden önce güvenli hissettirmesi gerektiğini öğretti. Tasarımı sahiplenmek de kararları beklemek değil, vermek demekti.',
        ),
      ],
    ),
  ],
  screens: [
    Screen('${_peasy}_1.webp',
        title: L('Start', tr: 'Başlangıç'),
        caption: L('Peasy, checkout without the queue.', tr: 'Peasy, kuyruksuz ödeme.')),
    Screen('${_peasy}_3.webp',
        title: L('NFC', tr: 'NFC'),
        caption: L('Hold the phone to a product’s tag and it goes into the cart.',
            tr: 'Telefonu ürünün etiketine yaklaştır, ürün sepete girsin.')),
    Screen('${_peasy}_2.webp',
        title: L('Barcode', tr: 'Barkod'),
        caption: L('Products without a tag go into the cart by their barcode.',
            tr: 'Etiketi olmayan ürünler barkoduyla sepete girer.')),
    Screen('${_peasy}_6.webp',
        title: L('Products', tr: 'Ürünler'),
        caption: L('See where a product is, and whether it is in stock or on sale.',
            tr: 'Ürünün nerede olduğunu, stokta ya da indirimde olup olmadığını gör.')),
    Screen('${_peasy}_4.webp',
        title: L('Checkout', tr: 'Ödeme özeti'),
        caption: L('Subtotal, taxes and promotion codes before confirming.',
            tr: 'Onaylamadan önce ara toplam, vergiler ve promosyon kodları.')),
    Screen('${_peasy}_5.webp',
        title: L('Payment', tr: 'Ödeme'),
        caption: L('Saved card, Apple Pay or Google Pay, and no queue.',
            tr: 'Kayıtlı kart, Apple Pay ya da Google Pay; kuyruk yok.')),
    Screen('${_peasy}_7.webp',
        title: L('Verification', tr: 'Doğrulama'),
        caption: L('A one-time code keeps the account safe.', tr: 'Tek kullanımlık bir kod hesabı güvende tutar.')),
  ],
  technology: [
    (_app, 'Flutter, Dart, Provider, MVVM, easy_localization'),
    (L('Scanning', tr: 'Okuma'), 'flutter_nfc_kit, barcode'),
    (_backend, 'Firebase Auth (Google, Apple), Cloud Firestore'),
    (L('Payment', tr: 'Ödeme'), 'pay (Apple Pay, Google Pay), simulated'),
  ],
);

Project? projectBySlug(String? slug) {
  for (final p in work) {
    if (p.slug == slug) return p;
  }
  return null;
}

/// The project after [p], wrapping back to the first.
Project nextProject(Project p) => work[(work.indexOf(p) + 1) % work.length];
