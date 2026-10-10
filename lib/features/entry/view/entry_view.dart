import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:portfolio/core/components/web_link.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/components/app_logo.dart';
import 'package:portfolio/core/components/pressable.dart';
import 'package:portfolio/core/components/hover_link.dart';
import 'package:portfolio/core/components/page_frame.dart';
import 'package:portfolio/core/components/pill.dart';
import 'package:portfolio/core/components/reveal.dart';
import 'package:portfolio/core/components/section_header.dart';
import 'package:portfolio/core/components/site_header.dart';
import 'package:portfolio/core/data/entry.dart';
import 'package:portfolio/core/components/uniform_line.dart';
import 'package:portfolio/core/data/collections.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/features/entry/widget/highlight_deck.dart';

/// The page of any entry, at `/<collection>/<slug>`: title with statuses and
/// tags, the overview and points, the link, and the highlight deck when the
/// entry has one. The header leads back to the collection's section.
class EntryView extends StatelessWidget {
  final Collection collection;
  final Entry entry;

  const EntryView({super.key, required this.collection, required this.entry});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final desktop = context.isDesktop;
    final back = HoverLink(
      label: context.t(S.all(collection.title)),
      icon: LinkIcon.back,
      to: collection.path,
    );

    final title = Reveal(child: _Title(collection: collection, entry: entry));
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(child: _Body(entry: entry)),
        if (entry.link != null) ...[
          const SizedBox(height: AppSpace.x8),
          Reveal(child: _LinkCard(link: entry.link!)),
        ],
      ],
    );
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [title, SizedBox(height: mobile ? AppSpace.x8 : AppSpace.x12), body],
    );
    final hasDeck = entry.highlights.isNotEmpty;
    final deck = Reveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpace.x4,
        children: [
          // Stacked, the deck sits right under the title and needs no label.
          if (desktop) Eyebrow(context.t(S.highlights)),
          HighlightDeck(key: ValueKey(entry.slug), slides: entry.highlights),
        ],
      ),
    );

    final Widget content;
    if (!hasDeck) {
      content = intro;
    } else if (desktop) {
      content = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.x24,
        children: [Expanded(flex: 7, child: intro), Expanded(flex: 4, child: deck)],
      );
    } else {
      // Stacked, the title leads, the images follow and the text comes last.
      final gap = SizedBox(height: mobile ? AppSpace.x8 : AppSpace.x12);
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          title,
          gap,
          Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480), child: deck)),
          gap,
          body,
        ],
      );
    }

    return Scaffold(
      body: Column(
        children: [
          // Phones have no room beside the name; the link goes under it.
          mobile
              ? SiteHeader(bottom: Align(alignment: Alignment.centerLeft, child: back))
              : SiteHeader(trailing: Align(alignment: Alignment.centerRight, child: back)),
          Expanded(
            child: SingleChildScrollView(
              primary: true,
              child: PageFrame(
                child: Padding(
                  padding: EdgeInsets.only(top: mobile ? AppSpace.x6 : AppSpace.x12, bottom: context.sectionGap),
                  child: content,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final Collection collection;
  final Entry entry;

  const _Title({required this.collection, required this.entry});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final mobile = context.isMobile;
    String two(int n) => n.toString().padLeft(2, '0');
    final number = two(collection.entries.indexOf(entry) + 1);
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow('$number / ${two(collection.entries.length)}  —  ${context.t(entry.label)}'),
        const SizedBox(height: AppSpace.x3),
        // Every entry page's title has the same size, set by the longest one.
        Semantics(
            header: true,
            child: UniformLine(context.t(entry.title).toUpperCase(),
                all: allEntryTitles(context.language), style: text.h1)),
        const SizedBox(height: AppSpace.x2),
        Text(context.t(entry.subtitle), style: text.bodyLarge.copyWith(color: context.colors.inkMuted)),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpace.x6,
      children: [
        if (mobile) ...[
          AppLogo(path: entry.logo, size: 72),
          heading,
        ] else
          Row(
            spacing: AppSpace.x8,
            children: [AppLogo(path: entry.logo, size: 112), Expanded(child: heading)],
          ),
        if (entry.facts.isNotEmpty)
          Wrap(
            spacing: AppSpace.x12,
            runSpacing: AppSpace.x4,
            children: [
              for (final fact in entry.facts)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpace.x1,
                  children: [Eyebrow(context.t(fact.label)), Text(context.t(fact.value), style: text.title)],
                ),
            ],
          ),
        // Statuses first, then every tag, in one wrap.
        if (entry.statuses.isNotEmpty || entry.tags.isNotEmpty)
          Wrap(
            spacing: AppSpace.x2,
            runSpacing: AppSpace.x2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final s in entry.statuses) Pill.status(context.t(s.label), color: s.colorIn(context.colors)),
              for (final t in entry.tags) Pill(t),
            ],
          ),
      ],
    );
  }
}

/// The overview, then the points as a list.
class _Body extends StatelessWidget {
  final Entry entry;

  const _Body({required this.entry});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final paragraph = text.bodyLarge.copyWith(color: context.colors.inkMuted, height: 1.7);
    final point = text.body.copyWith(color: context.colors.inkMuted, height: 1.7);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppLayout.readingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.x4,
        children: [
          Text(context.t(entry.overview), style: paragraph),
          if (entry.points.isNotEmpty) const SizedBox(height: AppSpace.x2),
          for (final p in entry.points)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpace.x3,
              children: [
                // A small square, lined up with the first line of text.
                Padding(
                  padding: EdgeInsets.only(top: (point.fontSize ?? 16) * 0.75),
                  child: SizedBox.square(dimension: 6, child: ColoredBox(color: context.colors.inkSubtle)),
                ),
                Expanded(child: Text(context.t(p), style: point)),
              ],
            ),
        ],
      ),
    );
  }
}

/// The entry's outside link as a card after the text: an icon, the label
/// and address, and an arrow out.
class _LinkCard extends StatefulWidget {
  final EntryLink link;

  const _LinkCard({required this.link});

  @override
  State<_LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<_LinkCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final link = widget.link;
    final address = Uri.parse(link.url);
    return Semantics(
      link: true,
      label: context.t(link.label),
      excludeSemantics: true,
      child: WebLink(
        to: link.url,
        builder: (context, follow) => Pressable(
          onPressed: follow,
          radius: AppRadius.mdAll,
          onActiveChanged: (active) => setState(() => _hovering = active),
          builder: (context, _) => ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppLayout.readingWidth),
            child: AnimatedContainer(
              duration: AppMotion.base,
              curve: AppMotion.standard,
              padding: const EdgeInsets.all(AppSpace.x4),
              decoration: BoxDecoration(
                color: _hovering ? context.colors.surfaceHover : context.colors.surface,
                borderRadius: AppRadius.mdAll,
              ),
              child: Row(
                spacing: AppSpace.x4,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: context.colors.canvas, borderRadius: AppRadius.smAll),
                    child: link.isGithub
                        ? Iconify(SimpleIcons.github, color: context.colors.ink, size: 24)
                        : Icon(Icons.language, color: context.colors.ink, size: 24),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(context.t(link.label), style: text.title),
                        Text(
                          '${address.host}${address.path}',
                          style: text.bodySmall.copyWith(color: context.colors.inkMuted),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  AnimatedSlide(
                    offset: _hovering ? const Offset(0.15, -0.15) : Offset.zero,
                    duration: AppMotion.base,
                    curve: AppMotion.standard,
                    child: Icon(Icons.north_east, size: 18, color: context.colors.ink),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
