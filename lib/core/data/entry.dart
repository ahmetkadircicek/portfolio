import 'package:flutter/painting.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// One item of a [Collection]: a project, a job, or anything else the site
/// lists. Every entry gets a row in its section on the home page and a page
/// of its own at `/<collection>/<slug>`; adding an entry to a collection's
/// list is all it takes to add both.
class Entry {
  /// Route segment: `/<collection>/<slug>`.
  final String slug;

  /// Name shown in upper-case serif, e.g. `Tunes.AI` or a job title.
  final String title;

  /// Line under the title, e.g. what the app is or the employer.
  final String subtitle;

  /// Category or period, e.g. `Music` or `Dec 2025 — Present`. Shown above
  /// the title on the page; in the home row when the entry has no status.
  final String label;

  /// One or two sentences for the home page row.
  final String summary;

  /// Opening text of the entry's page.
  final String overview;

  /// What was done, as a bullet list under the overview.
  final List<String> points;

  /// App-icon style logo; null draws the code mark.
  final String? logo;

  /// Technologies or skills, shown as pills.
  final List<String> tags;
  final List<EntryStatus> statuses;
  final EntryLink? link;

  /// Image cards on the entry's page. Without them the page is text only.
  final List<Highlight> highlights;

  const Entry({
    required this.slug,
    required this.title,
    required this.subtitle,
    required this.label,
    required this.summary,
    required this.overview,
    this.points = const [],
    this.logo,
    this.tags = const [],
    this.statuses = const [],
    this.link,
    this.highlights = const [],
  });
}

/// A named list of entries with its own home section and routes:
/// `/<id>` opens the home page at the section, `/<id>/<slug>` an entry.
class Collection {
  final String id;
  final String title;
  final List<Entry> entries;

  /// Phones start with the section closed, to keep the home page short.
  final bool collapsedOnPhones;

  const Collection({required this.id, required this.title, required this.entries, this.collapsedOnPhones = false});

  String get path => '/$id';

  String pathOf(Entry entry) => '$path/${entry.slug}';

  Entry? bySlug(String? slug) {
    for (final entry in entries) {
      if (entry.slug == slug) return entry;
    }
    return null;
  }
}

/// One image card on an entry's page.
class Highlight {
  final String title;
  final String description;
  final String label;
  final String image;

  /// Card background gradient; empty uses the theme's surface colors.
  final List<Color> colors;

  const Highlight({
    required this.title,
    required this.description,
    required this.label,
    required this.image,
    this.colors = const [],
  });
}

enum EntryStatus {
  readyToRelease('Ready to Release'),
  underDevelopment('Under Development'),
  earlyDevelopment('Under Early Development'),
  earlyProject('Early Project');

  final String label;
  const EntryStatus(this.label);

  Color colorIn(AppPalette palette) => switch (this) {
        readyToRelease => palette.statusReady,
        underDevelopment => palette.statusProgress,
        earlyDevelopment => palette.statusEarly,
        earlyProject => palette.statusArchive,
      };
}

/// An outside link shown as a card on the entry's page.
class EntryLink {
  final String label;
  final String url;

  const EntryLink({required this.label, required this.url});

  const EntryLink.github(this.url) : label = 'Source code';

  bool get isGithub => Uri.parse(url).host == 'github.com';
}
