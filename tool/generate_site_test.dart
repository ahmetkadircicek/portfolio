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
import 'package:portfolio/core/components/site_nav.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/init/navigation/app_router.dart';
import 'package:portfolio/core/l10n/l10n.dart';

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

  /// Section paths are the home page opened at a section: served, but not
  /// listed, and canonical to the home page.
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
  'name': Profile.name,
  'url': '$site/',
  'image': '$site/assets/assets/images/common/profile.jpg',
  'jobTitle': 'Mobile Developer',
  'worksFor': {'@type': 'Organization', 'name': 'Huawei Türkiye R&D Center'},
  'knowsAbout': ['Flutter', 'Dart', 'Swift', 'SwiftUI', 'HarmonyOS', 'ArkTS', 'Firebase'],
  'knowsLanguage': ['tr', 'en', 'de'],
  'sameAs': [Profile.github, Profile.linkedin, Profile.medium],
};

String intro(AppLanguage l) => '${Profile.intro.$1.of(l)} ${Profile.intro.$2.of(l)}';

Page home(AppLanguage l, {String path = '/', bool listed = true}) {
  final projects = [
    for (final p in work)
      '<article><h3>${link(l, p.path, '${p.name} — ${p.descriptor.of(l)}')}</h3><p>${esc(p.summary.of(l))}</p>'
          '<p>${esc(p.label.of(l))}</p></article>',
  ];
  return Page(
    path,
    l,
    listed: listed,
    description: intro(l),
    about: {'@type': 'WebSite', 'name': AppRouter.siteName, 'url': '$site/', 'inLanguage': l.name},
    body: [
      '<h1>${Profile.name} — ${esc(Copy.pageTitleRole.of(l))}</h1>',
      '<p>${esc(intro(l))}</p>',
      '<dl>${[for (final (k, v) in Profile.facts) '<dt>${esc(k.of(l))}</dt><dd>${esc(v.of(l))}</dd>'].join()}</dl>',
      '<nav>${[
        for (final s in HomeSection.values) link(l, s.path, s.title.of(l)),
        '<a href="${Profile.cv}">${esc(Copy.downloadCv.of(l))}</a>',
        '<a href="${Profile.github}">GitHub</a>',
        '<a href="${Profile.linkedin}">LinkedIn</a>',
        '<a href="${Profile.medium}">Medium</a>',
      ].join(' ')}</nav>',
      '<section><h2>${link(l, HomeSection.work.path, Copy.work.of(l))}</h2>\n${projects.join('\n')}\n</section>',
      '<section><h2>${link(l, HomeSection.about.path, Copy.about.of(l))}</h2>',
      '<p>${esc(Profile.huaweiLead.of(l))}</p>',
      for (final (title, body) in Profile.huaweiParts) '<h3>${esc(title.of(l))}</h3><p>${esc(body.of(l))}</p>',
      '<h3>${esc(Copy.experience.of(l))}</h3><ul>${[
        for (final (period, where, role) in Profile.experience) '<li>${esc(period.of(l))} · ${esc(where.of(l))} · ${esc(role.of(l))}</li>',
      ].join()}</ul>',
      '<h3>${esc(Copy.education.of(l))}</h3><p>${esc(Profile.education.$1.of(l))} · ${esc(Profile.education.$2.of(l))} · ${esc(Profile.education.$3.of(l))}</p>',
      '<h3>${esc(Copy.skills.of(l))}</h3><dl>${[
        for (final (group, tools) in Profile.skills) '<dt>${esc(group.of(l))}</dt><dd>${esc(tools)}</dd>',
      ].join()}</dl></section>',
      '<section><h2>${esc(Copy.contact.of(l))}</h2><p><a href="mailto:${Profile.email}">${Profile.email}</a></p></section>',
    ].join('\n'),
  );
}

Page projectPage(Project p, AppLanguage l) {
  final repo = p.repo;
  return Page(
    p.path,
    l,
    ownImage: true,
    description: p.lede.of(l),
    about: {
      '@type': 'SoftwareApplication',
      'name': p.name,
      'description': p.lede.of(l),
      'applicationCategory': p.descriptor.of(l),
      'operatingSystem': 'Android, iOS',
      'keywords': p.stack.replaceAll(' · ', ', '),
      'author': {'@id': '$site/#person'},
      'codeRepository': ?repo,
    },
    body: [
      '<h1>${esc(p.name)} — ${esc(p.descriptor.of(l))}</h1>',
      '<p>${esc(p.lede.of(l))}</p>',
      '<dl>${[
        for (final (k, v) in [(Copy.role, p.role.of(l)), (Copy.platform, p.platform.of(l)), (Copy.status, p.status.of(l)), (Copy.stack, p.stack)])
          '<dt>${esc(k.of(l))}</dt><dd>${esc(v)}</dd>',
      ].join()}</dl>',
      for (final c in p.chapters) ...[
        '<h2>${esc(c.label.of(l))}</h2>',
        '<p>${esc(c.lead.of(l))}</p>',
        for (final paragraph in c.body) '<p>${esc(paragraph.of(l))}</p>',
      ],
      '<h2>${esc(Copy.screens.of(l))}</h2><ul>${[
        for (final s in p.screens) '<li>${esc(s.title.of(l))}: ${esc(s.caption.of(l))}</li>',
      ].join()}</ul>',
      '<h2>${esc(Copy.technology.of(l))}</h2><dl>${[
        for (final (group, tools) in p.technology) '<dt>${esc(group.of(l))}</dt><dd>${esc(tools)}</dd>',
      ].join()}</dl>',
      if (repo != null) '<p><a href="${esc(repo)}">${esc(repo.replaceFirst('https://', ''))}</a></p>',
      for (final (label, url) in p.links) '<p><a href="${esc(url)}">${esc(label.of(l))}</a></p>',
      '<p>${link(l, nextProject(p).path, '${Copy.nextProject.of(l)}: ${nextProject(p).name}')}</p>',
    ].join('\n'),
  );
}

List<Page> allPages() => [
      for (final l in AppLanguage.values) ...[
        home(l),
        for (final s in HomeSection.values) home(l, path: s.path, listed: false),
        for (final p in work) projectPage(p, l),
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
    '<meta name="author" content="${Profile.name}">',
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
    '<meta property="og:locale" content="${const {'en': 'en_US', 'tr': 'tr_TR'}[l.name]}">',
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
    // Static pages outside the app, e.g. an app's privacy policy.
    for (final path in ['/tahtaya-kalk/privacy', '/tahtaya-kalk/support']) '  <url><loc>$site$path</loc></url>',
    '</urlset>',
    '',
  ].join('\n');
}

/// A plain summary for language models (llmstxt.org).
String llms() {
  const l = AppLanguage.en;
  return [
    '# ${Profile.name}',
    '',
    '> ${Copy.pageTitleRole.of(l)} at Huawei Türkiye R&D Center. ${intro(l)}',
    '',
    'The site is also in Turkish ($site/tr).',
    '',
    '## ${Copy.work.of(l)}',
    '',
    for (final p in work) '- [${p.name} — ${p.descriptor.of(l)}]($site${p.path}): ${p.summary.of(l)} ${p.label.of(l)}.',
    '',
    '## ${Copy.about.of(l)}',
    '',
    '- [${Copy.about.of(l)}]($site${HomeSection.about.path}): ${Profile.huaweiLead.of(l)}',
    '',
    '## ${Copy.contact.of(l)}',
    '',
    '- [Email](mailto:${Profile.email})',
    '- [CV (PDF)]($site${Profile.cv})',
    '- [GitHub](${Profile.github})',
    '- [LinkedIn](${Profile.linkedin})',
    '- [Medium](${Profile.medium})',
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
