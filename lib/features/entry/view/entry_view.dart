import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:portfolio/core/components/app_logo.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
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
import 'package:url_launcher/url_launcher.dart';

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
      label: 'All ${collection.title.toLowerCase()}',
      icon: LinkIcon.back,
      onTap: () => context.go(collection.path),
    );

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(child: _Title(collection: collection, entry: entry)),
        SizedBox(height: mobile ? AppSpace.x8 : AppSpace.x12),
        Reveal(child: _Body(entry: entry)),
        if (entry.link != null) ...[
          const SizedBox(height: AppSpace.x8),
          Reveal(child: _LinkCard(link: entry.link!)),
        ],
      ],
    );
    final hasDeck = entry.highlights.isNotEmpty;
    final deck = Reveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpace.x4,
        children: [
          // Stacked, the deck opens the page and needs no label.
          if (desktop) const Eyebrow('Highlights'),
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
      // Stacked, the images lead and the text follows.
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480), child: deck)),
          SizedBox(height: mobile ? AppSpace.x12 : AppSpace.x16),
          intro,
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
        Eyebrow('$number / ${two(collection.entries.length)}  —  ${entry.label}'),
        const SizedBox(height: AppSpace.x3),
        // Every entry page's title has the same size, set by the longest one.
        Semantics(header: true, child: UniformLine(entry.title.toUpperCase(), all: allEntryTitles, style: text.h1)),
        const SizedBox(height: AppSpace.x2),
        Text(entry.subtitle, style: text.bodyLarge.copyWith(color: AppColors.inkMuted)),
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
        // Statuses first, then every tag, in one wrap.
        if (entry.statuses.isNotEmpty || entry.tags.isNotEmpty)
          Wrap(
            spacing: AppSpace.x2,
            runSpacing: AppSpace.x2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final s in entry.statuses) Pill.status(s.label, color: s.color),
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
    final paragraph = text.bodyLarge.copyWith(color: AppColors.inkMuted, height: 1.7);
    final point = text.body.copyWith(color: AppColors.inkMuted, height: 1.7);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppLayout.readingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.x4,
        children: [
          Text(entry.overview, style: paragraph),
          if (entry.points.isNotEmpty) const SizedBox(height: AppSpace.x2),
          for (final p in entry.points)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpace.x3,
              children: [
                // A small square, lined up with the first line of text.
                Padding(
                  padding: EdgeInsets.only(top: (point.fontSize ?? 16) * 0.75),
                  child: const SizedBox.square(dimension: 6, child: ColoredBox(color: AppColors.inkSubtle)),
                ),
                Expanded(child: Text(p, style: point)),
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
      label: link.label,
      excludeSemantics: true,
      child: HoverDetector(
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: () => launchUrl(address, webOnlyWindowName: '_blank'),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppLayout.readingWidth),
              child: AnimatedContainer(
                duration: AppMotion.base,
                curve: AppMotion.standard,
                padding: const EdgeInsets.all(AppSpace.x4),
                decoration: BoxDecoration(
                  color: _hovering ? AppColors.surfaceHover : AppColors.surface,
                  borderRadius: AppRadius.mdAll,
                ),
                child: Row(
                  spacing: AppSpace.x4,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: AppColors.canvas, borderRadius: AppRadius.smAll),
                      child: link.isGithub
                          ? const Iconify(SimpleIcons.github, color: AppColors.ink, size: 24)
                          : const Icon(Icons.language, color: AppColors.ink, size: 24),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 2,
                        children: [
                          Text(link.label, style: text.title),
                          Text(
                            '${address.host}${address.path}',
                            style: text.bodySmall.copyWith(color: AppColors.inkMuted),
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
                      child: const Icon(Icons.north_east, size: 18, color: AppColors.ink),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
