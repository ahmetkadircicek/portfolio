import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/components/app_logo.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/components/page_frame.dart';
import 'package:portfolio/core/components/pill.dart';
import 'package:portfolio/core/components/reveal.dart';
import 'package:portfolio/core/components/section_header.dart';
import 'package:portfolio/core/data/entry.dart';
import 'package:portfolio/core/components/uniform_line.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

String _number(int index) => (index + 1).toString().padLeft(2, '0');

/// A collection's home section: its title with the count, then one row per
/// entry, each leading to the entry's page. With
/// [Collection.collapsedOnPhones], phones start with the rows hidden.
class CollectionSection extends StatefulWidget {
  final Collection collection;

  /// Opens a collapsed section, e.g. when a link leads here.
  final ValueNotifier<bool> open;

  const CollectionSection({super.key, required this.collection, required this.open});

  @override
  State<CollectionSection> createState() => _CollectionSectionState();
}

class _CollectionSectionState extends State<CollectionSection> {
  bool get _open => widget.open.value;

  @override
  void initState() {
    super.initState();
    widget.open.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.open.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final collection = widget.collection;
    final entries = collection.entries;
    final count = entries.length.toString().padLeft(2, '0');
    final collapsible = mobile && collection.collapsedOnPhones;
    final open = !collapsible || _open;

    final header = collapsible
        ? Semantics(
            button: true,
            expanded: _open,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => widget.open.value = !_open,
              child: SectionHeader(
                title: context.t(collection.title),
                count: count,
                trailing: AnimatedRotation(
                  turns: _open ? 0.5 : 0,
                  duration: AppMotion.base,
                  curve: AppMotion.standard,
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(Icons.expand_more,
                        color: context.colors.ink, semanticLabel: context.t(S.show(context.t(collection.title)))),
                  ),
                ),
              ),
            ),
          )
        : SectionHeader(title: context.t(collection.title), count: count);

    final rows = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: mobile ? AppSpace.x2 : AppSpace.x4),
        for (final (i, entry) in entries.indexed) ...[
          Reveal(child: _EntryRow(collection: collection, entry: entry, index: i)),
          if (i < entries.length - 1) Divider(height: 1, thickness: 1, color: context.colors.line),
        ],
      ],
    );

    return PageFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Reveal(child: header),
          AnimatedSize(
            duration: context.reduceMotion ? Duration.zero : AppMotion.slow,
            curve: AppMotion.emphasized,
            alignment: Alignment.topCenter,
            child: open ? rows : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

/// One line of a section; the whole row leads to the entry's page.
class _EntryRow extends StatefulWidget {
  final Collection collection;
  final Entry entry;
  final int index;

  const _EntryRow({required this.collection, required this.entry, required this.index});

  @override
  State<_EntryRow> createState() => _EntryRowState();
}

class _EntryRowState extends State<_EntryRow> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final text = context.text;
    final mobile = context.isMobile;
    final desktop = context.isDesktop;

    final name = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpace.x1,
      children: [
        // Same size for every title on the site, set by the longest one.
        UniformLine(context.t(entry.title).toUpperCase(), all: allEntryTitles(context.language), style: text.h2),
        Text(context.t(entry.subtitle), style: text.bodySmall.copyWith(color: context.colors.inkMuted)),
      ],
    );
    // Statuses when the entry has them; otherwise its label, e.g. a job's
    // period.
    final meta = entry.statuses.isEmpty
        ? Text(context.t(entry.label), style: text.bodySmall.copyWith(color: context.colors.inkSubtle))
        : Wrap(
            spacing: AppSpace.x2,
            runSpacing: AppSpace.x2,
            children: [
              for (final status in entry.statuses)
                Pill.status(context.t(status.label), color: status.colorIn(context.colors))
            ],
          );
    final arrow = AnimatedSlide(
      offset: Offset(_hovering ? 0.2 : 0, 0),
      duration: AppMotion.base,
      curve: AppMotion.standard,
      child: Icon(Icons.arrow_forward, size: 22, color: context.colors.ink),
    );
    // The highlight reaches past the row so the content never moves.
    final bleed = mobile ? AppSpace.x2 : AppSpace.x4;

    return Semantics(
      link: true,
      label: '${context.t(entry.title)} — ${context.t(entry.subtitle)}',
      child: HoverDetector(
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.go(widget.collection.pathOf(entry)),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: -bleed,
                  right: -bleed,
                  child: AnimatedOpacity(
                    opacity: _hovering ? 1 : 0,
                    duration: AppMotion.base,
                    curve: AppMotion.standard,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: context.colors.surface, borderRadius: AppRadius.mdAll),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: mobile ? AppSpace.x6 : AppSpace.x8),
                  child: Row(
                    spacing: mobile ? AppSpace.x4 : AppSpace.x6,
                    children: [
                      if (!mobile) SizedBox(width: 32, child: Eyebrow(_number(widget.index))),
                      AppLogo(path: entry.logo, size: mobile ? 48 : 56),
                      Expanded(
                        flex: 4,
                        child: mobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: AppSpace.x3,
                                children: [name, meta],
                              )
                            : name,
                      ),
                      if (desktop)
                        Expanded(
                          flex: 5,
                          child: Text(context.t(entry.summary),
                              style: text.bodySmall.copyWith(color: context.colors.inkMuted)),
                        ),
                      if (!mobile) SizedBox(width: desktop ? 220 : 180, child: meta),
                      arrow,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
