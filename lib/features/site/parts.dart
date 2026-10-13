import 'package:flutter/material.dart';
import 'package:portfolio/core/components/grid.dart';
import 'package:portfolio/core/components/pressable.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Upper-case mono label in the muted ink, e.g. `INTRO`.
class MonoLabel extends StatelessWidget {
  final String text;
  final Color? color;

  const MonoLabel(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: context.type.label.copyWith(color: color ?? context.colors.inkSubtle));
  }
}

/// A section's opening line: its name and a short range over a dark rule.
class SectionHeader extends StatelessWidget {
  final L title;
  final L detail;

  const SectionHeader({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final title = Semantics(header: true, child: MonoLabel(context.t(this.title), color: colors.ink));
    return DecoratedBox(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.ink))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpace.x4),
        child: context.isMobile
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [title, MonoLabel(context.t(detail))],
              )
            : GridRow(cells: [
                GridCell(start: 1, span: 3, child: title),
                GridCell(start: 4, span: 9, child: MonoLabel(context.t(detail))),
              ]),
      ),
    );
  }
}

/// A text link with an underline on hover.
class TextLink extends StatelessWidget {
  final String label;
  final String to;
  final TextStyle? style;

  const TextLink({super.key, required this.label, required this.to, this.style});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.type.link;
    return Pressable(
      to: to,
      builder: (context, hovered, _) => Align(
        alignment: Alignment.centerLeft,
        widthFactor: 1,
        child: Text(
          label,
          style: style.copyWith(
            decoration: hovered ? TextDecoration.underline : TextDecoration.none,
            decorationColor: style.color,
          ),
        ),
      ),
    );
  }
}

/// The dark closing band of every page: "Say hello.", the email and
/// LinkedIn, then the footer.
class ContactBand extends StatelessWidget {
  final VoidCallback? onTop;

  const ContactBand({super.key, this.onTop});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final mobile = context.isMobile;
    final onBlock = colors.onBlock;
    final muted = colors.onBlockMuted;
    final note = type.label.copyWith(color: muted, letterSpacing: 0);

    final say = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.t(Copy.sayHello), style: type.display.copyWith(color: onBlock)),
        const SizedBox(height: AppSpace.x8),
        Wrap(
          spacing: AppSpace.x10,
          runSpacing: AppSpace.x2,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TextLink(
              label: Profile.email,
              to: 'mailto:${Profile.email}',
              style: type.descriptor.copyWith(color: onBlock, fontSize: mobile ? 24 : 36),
            ),
            TextLink(label: 'LinkedIn ↗', to: Profile.linkedin, style: type.link.copyWith(color: onBlock)),
          ],
        ),
      ],
    );

    final links = Wrap(
      spacing: AppSpace.x6,
      children: [
        TextLink(label: 'GitHub', to: Profile.github, style: note),
        TextLink(label: 'LinkedIn', to: Profile.linkedin, style: note),
        TextLink(label: 'Medium', to: Profile.medium, style: note),
      ],
    );
    final top = Pressable(
      onTap: onTop,
      to: onTop == null ? '/' : null,
      builder: (context, _, __) => Center(widthFactor: 1, child: Text('${context.t(Copy.top)} ↑', style: note)),
    );
    final copyright = Text('© ${DateTime.now().year} ${Profile.name}', style: note);
    final source = TextLink(label: context.t(Copy.builtWith), to: Profile.source, style: note);

    return Semantics(
      container: true,
      child: ColoredBox(
        color: colors.block,
        child: PageColumn(
          child: Padding(
            padding: EdgeInsets.only(top: mobile ? AppSpace.x20 : AppSpace.x30, bottom: AppSpace.x6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (mobile) ...[
                  MonoLabel(context.t(Copy.contact), color: muted),
                  const SizedBox(height: AppSpace.x5),
                  say,
                ] else
                  GridRow(crossAxisAlignment: CrossAxisAlignment.end, cells: [
                    GridCell(
                      start: 1,
                      span: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: AppSpace.x4),
                        child: MonoLabel(context.t(Copy.contact), color: muted),
                      ),
                    ),
                    GridCell(start: 4, span: 9, child: say),
                  ]),
                SizedBox(height: mobile ? AppSpace.x16 : AppSpace.x30),
                DecoratedBox(
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: onBlock.withValues(alpha: 0.18)))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppSpace.x3),
                    child: mobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              links,
                              source,
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [copyright, top]),
                            ],
                          )
                        : GridRow(crossAxisAlignment: CrossAxisAlignment.center, cells: [
                            GridCell(start: 1, span: 3, child: copyright),
                            GridCell(start: 4, span: 5, child: links),
                            GridCell(start: 9, span: 3, child: source),
                            GridCell(start: 12, span: 1, child: Align(alignment: Alignment.centerRight, child: top)),
                          ]),
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
