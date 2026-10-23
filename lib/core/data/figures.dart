import 'package:flutter/painting.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/l10n/l10n.dart';

/// A case study's "engineer's notebook": figures after its design chapter
/// and tables inside its chapters. Every fact here comes from the approved
/// design; add nothing that Ahmet has not confirmed.
class Notebook {
  /// Rows of figures on the 12-column grid; on phones they stack in order.
  final List<List<FigureCell>> rows;

  /// Tables under a chapter's text, by chapter index.
  final Map<int, ChapterTable> tables;

  const Notebook({required this.rows, this.tables = const {}});
}

/// Figures starting at column [start] and spanning [span] columns.
class FigureCell {
  final int start;
  final int span;
  final List<Figure> figures;

  const FigureCell(this.start, this.span, this.figures);
}

/// A box in a diagram: an optional mono [kicker], a [title] and a [detail].
class FigureBox {
  final L title;
  final L? detail;

  /// A shorter [detail] for phones.
  final L? phoneDetail;
  final L? kicker;

  /// Dark boxes mark the end of a flow or the one that matters.
  final bool dark;

  /// Dashed boxes are passing states.
  final bool dashed;

  const FigureBox(this.title, {this.detail, this.phoneDetail, this.kicker, this.dark = false, this.dashed = false});
}

/// One figure: a numbered [title] and a [detail] on its caption line.
sealed class Figure {
  final L title;
  final L detail;

  /// A shorter [detail] for phones.
  final L? phoneDetail;

  const Figure(this.title, this.detail, this.phoneDetail);
}

/// Phases as a bar, wide by their length; the last one is still going on.
class TimelineFigure extends Figure {
  final List<(L, int)> phases;
  final Color color;

  const TimelineFigure(L title, L detail, {required this.phases, required this.color}) : super(title, detail, null);
}

/// Boxes in a row with → between them, a column with ↓ on phones.
class FlowFigure extends Figure {
  final List<FigureBox> boxes;

  const FlowFigure(super.title, super.detail, super.phoneDetail, {required this.boxes});
}

/// Rows of boxes from top to bottom, each joined to the next by ↓ and an
/// optional label.
class TierFigure extends Figure {
  final List<(List<FigureBox>, L?)> tiers;
  final L? footnote;

  const TierFigure(super.title, super.detail, super.phoneDetail, {required this.tiers, this.footnote});
}

/// Boxes two by two.
class GridFigure extends Figure {
  final List<FigureBox> boxes;
  final L? footnote;

  const GridFigure(super.title, super.detail, super.phoneDetail, {required this.boxes, this.footnote});
}

/// What happens, and who hears about it.
class MapFigure extends Figure {
  final (L, L) header;
  final List<(L, L)> rows;

  const MapFigure(super.title, super.detail, super.phoneDetail, {required this.header, required this.rows});
}

/// Screens in order, each with a step label.
class StepsFigure extends Figure {
  final List<(String, L)> steps;
  final int columns;
  final int phoneColumns;
  final L? footnote;
  final L? phoneFootnote;

  const StepsFigure(super.title, super.detail, super.phoneDetail,
      {required this.steps, required this.columns, required this.phoneColumns, this.footnote, this.phoneFootnote});
}

/// A screen with lines pointing at its parts, each at a fraction of its
/// height: (fraction, label, phone label).
class CalloutFigure extends Figure {
  final String image;
  final List<(double, L, L)> callouts;

  const CalloutFigure(super.title, super.detail, super.phoneDetail, {required this.image, required this.callouts});
}

/// Past values as bars and the next one, estimated, dashed in [color].
class EstimateFigure extends Figure {
  final List<double> past;
  final double next;
  final Color color;
  final (L, L) legend;
  final String formula;

  const EstimateFigure(super.title, super.detail, super.phoneDetail,
      {required this.past, required this.next, required this.color, required this.legend, required this.formula});
}

/// An app icon with its measurements and background gradient.
class IconFigure extends Figure {
  final String image;
  final List<L> measures;
  final List<Color> gradient;
  final L gradientLabel;

  const IconFigure(super.title, super.detail, super.phoneDetail,
      {required this.image, required this.measures, required this.gradient, required this.gradientLabel});
}

/// White text on two backgrounds and the contrast each one reaches.
class ContrastFigure extends Figure {
  final String sample;
  final String font;

  /// The text's color, e.g. "White".
  final L textColor;
  final List<(Color, String, bool)> swatches;

  const ContrastFigure(super.title, super.detail, super.phoneDetail,
      {required this.sample, required this.font, required this.textColor, required this.swatches});
}

/// An app's type styles drawn in its own [font]: name, size, size / line
/// height, bold, shown on phones.
class TypeScaleFigure extends Figure {
  final String font;
  final List<(String, double, String, bool, bool)> styles;

  const TypeScaleFigure(super.title, super.detail, super.phoneDetail, {required this.font, required this.styles});
}

/// A table under a chapter's text.
sealed class ChapterTable {
  const ChapterTable();
}

/// Large figures side by side, two by two on phones.
class NumbersTable extends ChapterTable {
  final List<(L, L)> numbers;
  final L footnote;

  const NumbersTable({required this.numbers, required this.footnote});
}

/// Name and formula per row.
class FormulaTable extends ChapterTable {
  final List<(L, L)> rows;

  const FormulaTable({required this.rows});
}

Notebook? notebookOf(Project project) => switch (project.slug) {
      'tunes' => _tunes,
      'vilsa' => _vilsa,
      'sevkiyatvar' => _sevkiyatvar,
      'peasy' => _peasy,
      'chalko' => _chalko,
      _ => null,
    };

const _shots = 'assets/images';

const _tunes = Notebook(
  rows: [
    [
      FigureCell(4, 9, [
        TimelineFigure(
          L('Fig. 0 — Timeline', tr: 'Şekil 0 — Zaman çizelgesi'),
          L('Still in development', tr: 'Geliştirme sürüyor'),
          color: Color(0xFFFF8225),
          phases: [
            (L('Research · 3 wk', tr: 'Araştırma · 3 hf'), 3),
            (L('Design · 2 wk', tr: 'Tasarım · 2 hf'), 2),
            (L('Build — first version', tr: 'Geliştirme — ilk sürüm'), 9),
            (L('Release prep → now', tr: 'Yayın hazırlığı → bugün'), 4),
          ],
        ),
      ]),
    ],
    [
      FigureCell(1, 6, [
        IconFigure(
          L('Fig. 1 — Icon', tr: 'Şekil 1 — İkon'),
          L.same('3000 × 3000 px'),
          null,
          image: 'assets/images/tunes/tunes_logo.webp',
          measures: [
            L('Record ⌀ 62% of the canvas', tr: 'Plak ⌀ tuvalin %62’si'),
            L('Dark ring ⌀ 23%', tr: 'Koyu halka ⌀ %23'),
            L('Label ⌀ 15.8%', tr: 'Etiket ⌀ %15,8'),
            L('Centre hole ⌀ 1.6%', tr: 'Orta delik ⌀ %1,6'),
          ],
          gradient: [Color(0xFFFB7E23), Color(0xFFF0701E), Color(0xFFE16017), Color(0xFFD24D10), Color(0xFFC83F0A)],
          gradientLabel: L('Background #FB7E23 → #C83F0A', tr: 'Arka plan #FB7E23 → #C83F0A'),
        ),
      ]),
      FigureCell(7, 6, [
        ContrastFigure(
          L('Fig. 2 — Contrast', tr: 'Şekil 2 — Kontrast'),
          L('WCAG 2.2 · text ≤ 17 pt needs 4.5 : 1', tr: 'WCAG 2.2 · 17 pt ve altı metin 4.5 : 1 ister'),
          L('Needs 4.5 : 1', tr: '4.5 : 1 gerekir'),
          sample: 'Create track',
          font: 'Montserrat',
          textColor: L('White', tr: 'Beyaz'),
          swatches: [(Color(0xFFFF8225), '2.48 : 1', false), (Color(0xFFC83F0A), '5.03 : 1', true)],
        ),
      ]),
    ],
    [
      FigureCell(1, 6, [
        TypeScaleFigure(
          L('Fig. 3 — Type scale', tr: 'Şekil 3 — Yazı ölçeği'),
          L('Montserrat = HIG Dynamic Type, Large', tr: 'Montserrat = HIG Dynamic Type, Large'),
          L('= HIG Dynamic Type', tr: '= HIG Dynamic Type'),
          font: 'Montserrat',
          styles: [
            ('Large Title', 34, '34 / 41', false, true),
            ('Title 1', 28, '28 / 34', false, true),
            ('Title 2', 22, '22 / 28', false, true),
            ('Title 3', 20, '20 / 25', false, false),
            ('Headline', 17, '17 / 22', true, true),
            ('Body', 17, '17 / 22', false, true),
            ('Subhead', 15, '15 / 20', false, false),
            ('Footnote', 13, '13 / 18', false, true),
          ],
        ),
      ]),
      FigureCell(7, 6, [
        StepsFigure(
          L('Fig. 4 — Generation flow', tr: 'Şekil 4 — Üretim akışı'),
          L('Name → lyrics → genre → key → tempo', tr: 'Ad → sözler → tür → ton → tempo'),
          L('4 steps', tr: '4 adım'),
          columns: 4,
          phoneColumns: 2,
          steps: [
            ('$_shots/tunes/tunes_screenshots_8.webp', L('1 · Name it', tr: '1 · Adını koy')),
            ('$_shots/tunes/tunes_screenshots_4.webp', L('2 · Set the key', tr: '2 · Tonu seç')),
            ('$_shots/tunes/tunes_screenshots_6.webp', L('3 · Generate', tr: '3 · Üret')),
            ('$_shots/tunes/tunes_screenshots_3.webp', L('4 · Listen', tr: '4 · Dinle')),
          ],
        ),
      ]),
    ],
  ],
  tables: {
    3: NumbersTable(
      numbers: [
        (L('Cost per song', tr: 'Şarkı başı maliyet'), L.same(r'$0.021')),
        (L('Free songs per user', tr: 'Kullanıcı başı ücretsiz şarkı'), L.same('2')),
        (L('Max cost, new user', tr: 'Yeni kullanıcı, en fazla maliyet'), L.same(r'$0.042')),
        (L('Break-even, 500 users/mo', tr: 'Başa baş, ayda 500 kullanıcı'), L('≈ 11 packs', tr: '≈ 11 paket')),
      ],
      footnote: L(
        'Music, cover and storage per song. Break-even covers the free songs and the developer fee.',
        tr: 'Şarkı başına müzik, kapak ve depolama. Başa baş noktası ücretsiz şarkıları ve geliştirici ücretini karşılar.',
      ),
    ),
  },
);

const _vilsa = Notebook(
  rows: [
    [
      FigureCell(1, 6, [
        CalloutFigure(
          L('Fig. 1 — Chart anatomy', tr: 'Şekil 1 — Grafiğin anatomisi'),
          L('Home screen', tr: 'Ana ekran'),
          L('Home', tr: 'Ana ekran'),
          image: '$_shots/vilsa/vilsa_screenshots_6.webp',
          callouts: [
            (0.17, L('Total balance', tr: 'Toplam bakiye'), L('Total balance', tr: 'Toplam bakiye')),
            (0.27, L('Period — any range', tr: 'Dönem — her aralık'), L('Period', tr: 'Dönem')),
            (0.39, L('Line ⇄ bars toggle', tr: 'Çizgi ⇄ çubuk geçişi'), L('Line ⇄ bars', tr: 'Çizgi ⇄ çubuk')),
            (0.47, L('Chart — fl_chart', tr: 'Grafik — fl_chart'), L('Chart', tr: 'Grafik')),
            (0.68, L('Holdings, sortable', tr: 'Hisseler, sıralanabilir'), L('Holdings', tr: 'Hisseler')),
          ],
        ),
      ]),
      FigureCell(7, 6, [
        TierFigure(
          L('Fig. 2 — Data model', tr: 'Şekil 2 — Veri modeli'),
          L.same('Firebase Realtime Database'),
          L.same('Realtime Database'),
          tiers: [
            ([FigureBox(L('Stock', tr: 'Hisse'), detail: L('market · name · symbol', tr: 'borsa · ad · sembol'))], L.same('1 — n')),
            (
              [
                FigureBox(L('Transaction', tr: 'İşlem'),
                    detail: L('date · price · quantity · note', tr: 'tarih · fiyat · adet · not')),
                FigureBox(L('Dividend', tr: 'Temettü'), detail: L('date · amount', tr: 'tarih · tutar')),
              ],
              null
            ),
          ],
          footnote: L('/stocks · /transactions · /dividends, linked by stock id',
              tr: '/stocks · /transactions · /dividends, hisse kimliğiyle bağlı'),
        ),
      ]),
    ],
    [
      FigureCell(1, 6, [
        EstimateFigure(
          L('Fig. 3 — Dividend estimate', tr: 'Şekil 3 — Temettü tahmini'),
          L('Illustration', tr: 'Temsilî'),
          null,
          past: [0.58, 0.66, 0.61, 0.71],
          next: 0.64,
          color: Color(0xFF5908FA),
          legend: (L('Past payments', tr: 'Geçmiş ödemeler'), L('Next, estimated', tr: 'Sonraki, tahmini')),
          formula: 'next ≈ average(past payments)',
        ),
      ]),
      FigureCell(7, 6, [
        TierFigure(
          L('Fig. 4 — Architecture', tr: 'Şekil 4 — Mimari'),
          L.same('MVVM + Provider'),
          null,
          tiers: [
            ([FigureBox(L.same('View'), detail: L('widgets only, no logic', tr: 'yalnız widget, mantık yok'))], L.same('Provider')),
            (
              [
                FigureBox(L.same('ViewModel'),
                    detail: L('state and calculations, on a shared BaseViewModel',
                        tr: 'state ve hesaplar, ortak bir BaseViewModel üzerinde'),
                    phoneDetail: L('state and calculations', tr: 'state ve hesaplar')),
              ],
              null
            ),
            (
              [
                FigureBox(L('Services', tr: 'Servisler'),
                    detail: L('stock · transaction · dividend · cache', tr: 'hisse · işlem · temettü · önbellek')),
              ],
              null
            ),
            ([FigureBox(L.same('Firebase Realtime Database'), dark: true)], null),
          ],
        ),
      ]),
    ],
  ],
  tables: {
    2: FormulaTable(rows: [
      (L('Average cost', tr: 'Ortalama maliyet'), L.same('Σ (price × quantity) ÷ Σ quantity')),
      (L('Return', tr: 'Getiri'), L.same('(value − cost) ÷ cost')),
      (L('Dividend yield', tr: 'Temettü verimi'), L.same('dividends received ÷ cost')),
      (L('Period totals', tr: 'Dönem toplamları'),
          L('day · week · month · quarter · any range', tr: 'gün · hafta · ay · çeyrek · her aralık')),
    ]),
  },
);

const _sevkiyatvar = Notebook(rows: [
  [
    FigureCell(1, 12, [
      FlowFigure(
        L('Fig. 1 — A load’s life', tr: 'Şekil 1 — Bir yükün hayatı'),
        L('Read from the app’s four tabs', tr: 'Uygulamanın dört sekmesinden'),
        L('From the four tabs', tr: 'Dört sekmeden'),
        boxes: [
          FigureBox(L('Post a load', tr: 'Yük ilanı ver'),
              kicker: L.same('İlan ver'), detail: L('route · vehicle · load · date', tr: 'güzergâh · araç · yük · tarih')),
          FigureBox(L('Listed', tr: 'Listelendi'),
              kicker: L.same('İlanlar'),
              detail: L('filtered by origin and destination', tr: 'nereden ve nereye göre süzülür')),
          FigureBox(L('Call, message or offer', tr: 'Ara, yaz ya da teklif ver'),
              kicker: L.same('Detay'), detail: L('phone · WhatsApp · offer', tr: 'telefon · WhatsApp · teklif')),
          FigureBox(L('Taken and tracked', tr: 'Alındı ve takipte'),
              kicker: L.same('İş takibi'), detail: L('jobs · offers · my listings', tr: 'işler · teklifler · ilanlarım')),
        ],
      ),
    ]),
  ],
  [
    FigureCell(1, 6, [
      GridFigure(
        L('Fig. 2 — Connection states', tr: 'Şekil 2 — Bağlantı durumları'),
        L('In the field', tr: 'Sahada'),
        null,
        boxes: [
          FigureBox(L('Online', tr: 'Çevrimiçi'), detail: L('listings load as usual', tr: 'ilanlar her zamanki gibi yüklenir')),
          FigureBox(L('Connection lost', tr: 'Bağlantı koptu'),
              detail: L('a plain “you are offline” notice', tr: 'açık bir “çevrimdışısın” uyarısı'),
              phoneDetail: L('a plain offline notice', tr: 'açık bir çevrimdışı uyarısı'),
              dashed: true),
          FigureBox(L('Last data stays', tr: 'Son veri kalır'),
              detail: L('the last loaded listings remain on screen', tr: 'son yüklenen ilanlar ekranda kalır'),
              phoneDetail: L('the last listings remain', tr: 'son ilanlar kalır'),
              dashed: true),
          FigureBox(L('Back online', tr: 'Yeniden çevrimiçi'),
              detail: L('the request is retried, the list refreshes', tr: 'istek yeniden denenir, liste yenilenir'),
              phoneDetail: L('retried, list refreshes', tr: 'yeniden denenir, liste yenilenir')),
        ],
        footnote: L('Online → lost → last data → retry → online',
            tr: 'Çevrimiçi → koptu → son veri → yeniden dene → çevrimiçi'),
      ),
    ]),
    FigureCell(7, 6, [
      MapFigure(
        L('Fig. 3 — Notification map', tr: 'Şekil 3 — Bildirim haritası'),
        L.same('OneSignal · FCM'),
        null,
        header: (L('Event', tr: 'Olay'), L('Who hears it', tr: 'Kime gider')),
        rows: [
          (L('A listing changes status', tr: 'Bir ilanın durumu değişir'), L('The shipper', tr: 'Yük sahibi')),
          (L('A new load on your route', tr: 'Güzergâhında yeni bir yük'), L('The carrier', tr: 'Taşıyıcı')),
          (L('A critical alert', tr: 'Kritik bir uyarı'), L('The team in the field', tr: 'Sahadaki ekip')),
        ],
      ),
    ]),
  ],
]);

const _peasy = Notebook(rows: [
  [
    FigureCell(1, 12, [
      FlowFigure(
        L('Fig. 1 — From shelf to cart', tr: 'Şekil 1 — Raftan sepete'),
        L.same('flutter_nfc_kit · Cloud Firestore'),
        L.same('NFC · Firestore'),
        boxes: [
          FigureBox(L('Tap the tag', tr: 'Etikete dokun'),
              kicker: L.same('01'), detail: L('or scan the barcode', tr: 'ya da barkodu okut')),
          FigureBox(L('Read its id', tr: 'Kimliğini oku'),
              kicker: L.same('02'), detail: L('iOS and Android read differently', tr: 'iOS ve Android farklı okur')),
          FigureBox(L('Find the product', tr: 'Ürünü bul'),
              kicker: L.same('03'),
              detail: L('price · stock · sale, from Firestore', tr: 'fiyat · stok · indirim, Firestore’dan')),
          FigureBox(L('In the cart', tr: 'Sepette'), kicker: L.same('04'), dark: true),
        ],
      ),
    ]),
  ],
  [
    FigureCell(1, 7, [
      StepsFigure(
        L('Fig. 2 — Checkout', tr: 'Şekil 2 — Ödeme'),
        L('Simulated payment', tr: 'Simüle ödeme'),
        null,
        columns: 3,
        phoneColumns: 3,
        steps: [
          ('$_shots/peasy/peasy_screenshots_4.webp', L('1 · Review', tr: '1 · Gözden geçir')),
          ('$_shots/peasy/peasy_screenshots_5.webp', L('2 · Pay', tr: '2 · Öde')),
          ('$_shots/peasy/peasy_screenshots_7.webp', L('3 · Confirm', tr: '3 · Onayla')),
        ],
        footnote: L('Apple Pay and Google Pay sheets via the pay package; no real money moves.',
            tr: 'pay paketiyle Apple Pay ve Google Pay ekranları; gerçek para hareket etmez.'),
        phoneFootnote: L('Apple Pay and Google Pay sheets; no real money moves.',
            tr: 'Apple Pay ve Google Pay ekranları; gerçek para hareket etmez.'),
      ),
    ]),
    FigureCell(8, 5, [
      TierFigure(
        L('Fig. 3 — Data model', tr: 'Şekil 3 — Veri modeli'),
        L.same('Cloud Firestore'),
        null,
        tiers: [
          ([FigureBox(L('Category', tr: 'Kategori'), detail: L('section in the store', tr: 'mağazadaki bölüm'))], L.same('1 — n')),
          (
            [
              FigureBox(L('Product', tr: 'Ürün'),
                  detail: L('tag id · barcode · price · stock · sale', tr: 'etiket kimliği · barkod · fiyat · stok · indirim')),
            ],
            null
          ),
          (
            [
              FigureBox(L('Cart', tr: 'Sepet'), detail: L('per user', tr: 'kullanıcı başına')),
              FigureBox(L('Receipt', tr: 'Fiş'), detail: L('kept after paying', tr: 'ödemeden sonra saklanır')),
            ],
            null
          ),
        ],
      ),
      GridFigure(
        L('Fig. 4 — Team of four', tr: 'Şekil 4 — Dört kişilik ekip'),
        L('Who did what', tr: 'Kim ne yaptı'),
        null,
        boxes: [
          FigureBox(L('Me', tr: 'Ben'), detail: L('mobile app · design', tr: 'mobil uygulama · tasarım'), dark: true),
          FigureBox(L.same('Backend'), detail: L('Firebase · data', tr: 'Firebase · veri')),
          FigureBox(L('Hardware', tr: 'Donanım'), detail: L('NFC tags · test setup', tr: 'NFC etiketleri · test düzeni')),
          FigureBox(L('Report', tr: 'Rapor'),
              detail: L('report · presentation · testing', tr: 'rapor · sunum · testler')),
        ],
      ),
    ]),
  ],
]);

const _chalko = Notebook(rows: [
  [
    FigureCell(1, 12, [
      FlowFigure(
        L('Fig. 1 — One game', tr: 'Şekil 1 — Bir oyun'),
        L('One state machine drives every screen', tr: 'Her ekranı tek bir durum makinesi yönetir'),
        L('One state machine', tr: 'Tek durum makinesi'),
        boxes: [
          FigureBox(L('Setup', tr: 'Kurulum'), kicker: L.same('01'), detail: L('teams · time · rounds · passes', tr: 'takımlar · süre · tur · pas')),
          FigureBox(L('Handoff', tr: 'Devir'), kicker: L.same('02'), detail: L('whose turn, hide the phone', tr: 'sıra kimde, telefonu sakla')),
          FigureBox(L('Countdown', tr: 'Geri sayım'), kicker: L.same('03')),
          FigureBox(L('Playing', tr: 'Oyun'), kicker: L.same('04'), detail: L('hold to see the word', tr: 'kelimeyi görmek için basılı tut')),
          FigureBox(L('Summary', tr: 'Özet'), kicker: L.same('05'), detail: L('fix a mis-tap', tr: 'yanlış dokunuşu düzelt')),
          FigureBox(L('Game over', tr: 'Oyun sonu'), kicker: L.same('06'), detail: L('rematch', tr: 'rövanş'), dark: true),
        ],
      ),
    ]),
  ],
  [
    FigureCell(1, 6, [
      GridFigure(
        L('Fig. 2 — Four levels', tr: 'Şekil 2 — Dört seviye'),
        L('Words in each pool', tr: 'Her havuzdaki kelime'),
        null,
        boxes: [
          FigureBox(L.same('Çöp Adam'), kicker: L('Easy', tr: 'Kolay'), detail: L('834 words', tr: '834 kelime')),
          FigureBox(L.same('Karalamacı'), kicker: L('Medium', tr: 'Orta'), detail: L('618 + 300 from below = 918', tr: '618 + alttan 300 = 918')),
          FigureBox(L.same('Ressam'), kicker: L('Hard', tr: 'Zor'), detail: L('569 + 300 from below = 869', tr: '569 + alttan 300 = 869')),
          FigureBox(L.same('Dalí'), kicker: L('Impossible', tr: 'İmkânsız'),
              detail: L('586 + 300 from below = 886, abstract only', tr: '586 + alttan 300 = 886, yalnız soyut'), dark: true),
        ],
      ),
    ]),
    FigureCell(7, 6, [
      MapFigure(
        L('Fig. 3 — Scoring', tr: 'Şekil 3 — Puanlama'),
        L('Per word', tr: 'Kelime başına'),
        null,
        header: (L('Press', tr: 'Basılan'), L('Points', tr: 'Puan')),
        rows: [
          (L('Bildi — guessed', tr: 'Bildi'), L.same('+1')),
          (L('Pas — while free passes last', tr: 'Pas — bedava pas varken'), L.same('0')),
          (L('Pas — after that', tr: 'Pas — sonrasında'), L.same('−1')),
          (L('Same top score', tr: 'En yüksekte eşitlik'), L('shared win', tr: 'ortak galibiyet')),
        ],
      ),
    ]),
  ],
], tables: {
  3: NumbersTable(
    numbers: [
      (L('Hand-picked words', tr: 'Elle seçilmiş kelime'), L.same('2,607')),
      (L('Levels', tr: 'Seviye'), L.same('4')),
      (L('Cut in review', tr: 'İncelemede elenen'), L.same('127')),
      (L('Repeats in a game', tr: 'Bir oyunda tekrar'), L.same('0')),
    ],
    footnote: L(
      'Every level above Çöp Adam mixes in 300 words from the level below.',
      tr: 'Çöp Adam’ın üstündeki her seviye, bir alttaki seviyeden 300 kelime katıyor.',
    ),
  ),
});
