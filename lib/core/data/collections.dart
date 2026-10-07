import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/data/experience.dart';
import 'package:portfolio/core/data/projects.dart';

/// Every collection on the site, in home page order. Each gets a home
/// section, `/<id>` and `/<id>/<slug>` routes; a new collection needs only
/// its data file and a line here.
const collections = [projects, experience];

/// Every entry title as shown (upper case); rows and pages size their
/// titles by the longest of these.
List<String> allEntryTitles(AppLanguage language) => [
      for (final c in collections)
        for (final e in c.entries) e.title.of(language).toUpperCase(),
    ];
