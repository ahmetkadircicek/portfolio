// Writes a static HTML file for every page of the site in every language,
// plus sitemap.xml and llms.txt, into build/web. Runs after `flutter build
// web` (tool/build_web.sh) as a test, because the site's data uses dart:ui:
//
//   flutter test tool/generate_site_test.dart
//
// Each file is the built index.html with the page's own head (title,
// description, canonical, hreflang, link previews, JSON-LD) and the page as
// text for search engines, screen readers and language models. Flutter then
// starts on top of it as usual. Firebase Hosting serves `/tr/projects/tunes`
// from `tr/projects/tunes.html` (cleanUrls).
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/constants/app_links.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:portfolio/core/data/entry.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/init/navigation/app_router.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/l10n/strings.dart';

import 'og.dart';

const site = 'https://ahmetkadircicek.com.tr';
const out = 'build/web';

/// One page of the site in one language.
class Page {
  final String path;
  final AppLanguage language;
  final String description;
  final String body;
  final Map<String, Object?>? about;

  /// Link preview image, from tool/og_image_test.dart.
  final String image;

  /// Collection paths are the home page opened at a section: served, but
  /// not listed, and canonical to the home page.
  final bool listed;

  Page(
    this.path,
    this.language, {
    required this.description,
    required this.body,
    this.about,
    this.listed = true,
    bool ownImage = false,
  }) : image = '$site/${ogFile(language, ownImage ? path : null)}';

  String get address => language.localize(path);
  String get url => urlIn(language);
  String get title => AppRouter.titleFor(Uri.parse(address));
  String get canonical => listed ? url : '$site${language.localize('/')}';
  String get file => address == '/' ? 'index.html' : '${address.substring(1)}.html';

  String urlIn(AppLanguage other) => '$site${other.localize(path)}';
}

String esc(String text) =>
    text.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;').replaceAll('"', '&quot;');

String link(AppLanguage language, String path, String text) => '<a href="${language.localize(path)}">${esc(text)}</a>';

const person = {
  '@type': 'Person',
  '@id': '$site/#person',
  'name': 'Ahmet Kadir Çiçek',
  'url': '$site/',
  'image': '$site/assets/assets/images/common/profile.jpg',
  'jobTitle': 'Mobile Developer',
  'worksFor': {'@type': 'Organization', 'name': 'Huawei Türkiye R&D Center'},
  'knowsAbout': ['Flutter', 'Dart', 'Swift', 'SwiftUI', 'HarmonyOS', 'ArkTS', 'Firebase'],
  'knowsLanguage': ['tr', 'en', 'de'],
  'sameAs': [AppLinks.github, AppLinks.linkedin],
};

Page home(AppLanguage l, {String path = '/', bool listed = true}) {
  final sections = [
    for (final c in collections)
      '<section><h2>${link(l, c.path, c.title.of(l))}</h2>\n'
          '${[for (final e in c.entries) '<article><h3>${link(l, c.pathOf(e), '${e.title.of(l)} — ${e.subtitle.of(l)}')}</h3><p>${esc(e.summary.of(l))}</p></article>'].join('\n')}\n'
          '</section>',
  ];
  final capabilities = [for (final (title, body, _) in S.capabilities) '<li><b>${esc(title.of(l))}</b>: ${esc(body.of(l))}</li>'];
  return Page(
    path,
    l,
    listed: listed,
    description: S.heroLine.of(l),
    about: {'@type': 'WebSite', 'name': AppRouter.siteName, 'url': '$site/', 'inLanguage': l.name},
    body: [
      '<h1>Ahmet Kadir Çiçek — ${esc(S.role.of(l))}</h1>',
      '<p>Make it simple. ${esc(S.heroLine.of(l))}</p>',
      '<nav>${[
        for (final c in collections) link(l, c.path, c.title.of(l)),
        link(l, '/contact', S.requestProject.of(l)),
        '<a href="${AppLinks.cv}">${esc(S.downloadCv.of(l))}</a>',
        '<a href="${AppLinks.github}">GitHub</a>',
        '<a href="${AppLinks.linkedin}">LinkedIn</a>',
      ].join(' ')}</nav>',
      ...sections,
      '<section><h2>${esc(S.whatIDo.of(l))}</h2><ul>${capabilities.join()}</ul></section>',
    ].join('\n'),
  );
}

Page entryPage(Collection c, Entry e, AppLanguage l) {
  final link = e.link;
  return Page(
    c.pathOf(e),
    l,
    ownImage: true,
    description: e.summary.of(l),
    about: c == projects
        ? {
            '@type': 'SoftwareApplication',
            'name': e.title.of(l),
            'description': e.overview.of(l),
            'applicationCategory': e.label.of(l),
            'operatingSystem': e.tags.contains('Swift') ? 'iOS' : 'Android, iOS',
            'keywords': e.tags.join(', '),
            'author': {'@id': '$site/#person'},
            if (link != null) 'codeRepository': link.url,
          }
        : {
            '@type': 'OrganizationRole',
            'roleName': e.title.of(l),
            'description': e.overview.of(l),
          },
    body: [
      '<h1>${esc(e.title.of(l))} — ${esc(e.subtitle.of(l))}</h1>',
      '<p>${esc(e.label.of(l))}</p>',
      '<p>${esc(e.overview.of(l))}</p>',
      if (e.points.isNotEmpty) '<ul>${[for (final p in e.points) '<li>${esc(p.of(l))}</li>'].join()}</ul>',
      if (e.tags.isNotEmpty) '<p>${esc(e.tags.join(', '))}</p>',
      for (final h in e.highlights) '<p>${esc(h.title.of(l))}: ${esc(h.description.of(l))}</p>',
      if (link != null) '<p><a href="${esc(link.url)}">${esc(link.label.of(l))}</a></p>',
      '<p>${linkTo(l, c)}</p>',
    ].join('\n'),
  );
}

String linkTo(AppLanguage l, Collection c) => link(l, c.path, S.all(c.title).of(l));

Page contactPage(AppLanguage l) => Page(
      '/contact',
      l,
      description: S.contactBody.of(l),
      body: '<h1>${esc(S.contactTitle.of(l))}</h1>\n<p>${esc(S.contactBody.of(l))}</p>\n<p>${link(l, '/', S.backHome.of(l))}</p>',
    );

List<Page> allPages() => [
      for (final l in AppLanguage.values) ...[
        home(l),
        for (final c in collections) ...[
          home(l, path: c.path, listed: false),
          for (final e in c.entries) entryPage(c, e, l),
        ],
        contactPage(l),
      ],
    ];

String head(Page page) {
  final l = page.language;
  final ld = {
    '@context': 'https://schema.org',
    '@graph': [
      person,
      {
        '@type': 'WebPage',
        'url': page.url,
        'name': page.title,
        'inLanguage': l.name,
        'description': page.description,
        if (page.about != null) 'about': page.about,
      },
    ],
  };
  final image = page.image;
  return [
    '<title>${esc(page.title)}</title>',
    '<meta name="description" content="${esc(page.description)}">',
    '<meta name="author" content="Ahmet Kadir Çiçek">',
    '<meta name="theme-color" content="#ffffff">',
    '<link rel="canonical" href="${page.canonical}">',
    if (page.listed) ...[
      for (final other in AppLanguage.values)
        '<link rel="alternate" hreflang="${other.name}" href="${page.urlIn(other)}">',
      '<link rel="alternate" hreflang="x-default" href="${page.urlIn(AppLanguage.en)}">',
    ],
    '<meta property="og:type" content="${page.path == '/' ? 'website' : 'article'}">',
    '<meta property="og:site_name" content="${AppRouter.siteName}">',
    '<meta property="og:title" content="${esc(page.title)}">',
    '<meta property="og:description" content="${esc(page.description)}">',
    '<meta property="og:url" content="${page.url}">',
    '<meta property="og:locale" content="${const {'en': 'en_US', 'tr': 'tr_TR', 'de': 'de_DE'}[l.name]}">',
    '<meta property="og:image" content="$image">',
    '<meta property="og:image:width" content="1200">',
    '<meta property="og:image:height" content="630">',
    '<meta property="og:image:alt" content="${esc(page.title)}">',
    '<meta name="twitter:card" content="summary_large_image">',
    '<script type="application/ld+json">${jsonEncode(ld)}</script>',
  ].map((line) => '  $line').join('\n');
}

String replaceBetween(String html, String marker, String content) {
  final start = RegExp('<!-- $marker[^>]*-->').firstMatch(html);
  final end = html.indexOf('<!-- /$marker -->');
  if (start == null || end < 0) throw StateError('index.html has no $marker markers');
  return '${html.substring(0, start.end)}\n$content\n  ${html.substring(end)}';
}

String render(String template, Page page) {
  var html = template.replaceFirst(RegExp(r'<html lang="[^"]*">'), '<html lang="${page.language.name}">');
  html = replaceBetween(html, 'page:head', head(page));
  html = replaceBetween(html, 'page:body', '  <main class="sr-only">\n${page.body}\n  </main>');
  return html;
}

String sitemap(List<Page> pages) {
  final listed = pages.where((p) => p.listed && p.language == AppLanguage.en);
  return [
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">',
    for (final page in listed)
      for (final l in AppLanguage.values) ...[
        '  <url>',
        '    <loc>${page.urlIn(l)}</loc>',
        for (final other in AppLanguage.values)
          '    <xhtml:link rel="alternate" hreflang="${other.name}" href="${page.urlIn(other)}"/>',
        '    <xhtml:link rel="alternate" hreflang="x-default" href="${page.urlIn(AppLanguage.en)}"/>',
        '  </url>',
      ],
    '</urlset>',
    '',
  ].join('\n');
}

/// A plain summary for language models (llmstxt.org).
String llms() {
  const l = AppLanguage.en;
  return [
    '# Ahmet Kadir Çiçek',
    '',
    '> ${S.role.of(l)} at Huawei Türkiye R&D Center. ${S.heroLine.of(l)}',
    '',
    'The site is also in Turkish ($site/tr) and German ($site/de).',
    '',
    for (final c in collections) ...[
      '## ${c.title.of(l)}',
      '',
      for (final e in c.entries) '- [${e.title.of(l)} — ${e.subtitle.of(l)}]($site${c.pathOf(e)}): ${e.summary.of(l)}',
      '',
    ],
    '## Contact',
    '',
    '- [Request a project]($site/contact)',
    '- [CV (PDF)]($site${AppLinks.cv})',
    '- [GitHub](${AppLinks.github})',
    '- [LinkedIn](${AppLinks.linkedin})',
    '',
  ].join('\n');
}

void main() {
  test('writes the static pages, sitemap.xml and llms.txt', () {
    final index = File('$out/index.html');
    if (!index.existsSync()) fail('Build the site first: flutter build web');
    final template = index.readAsStringSync();
    final pages = allPages();
    for (final page in pages) {
      File('$out/${page.file}')
        ..createSync(recursive: true)
        ..writeAsStringSync(render(template, page));
    }
    File('$out/sitemap.xml').writeAsStringSync(sitemap(pages));
    File('$out/llms.txt').writeAsStringSync(llms());
    // ignore: avoid_print
    print('wrote ${pages.length} pages');
  });
}
