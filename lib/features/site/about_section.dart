import 'package:flutter/material.dart';
import 'package:portfolio/core/components/grid.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/features/site/parts.dart';

/// The home page's about section: Huawei in two parts, experience,
/// education, skills and the CV, on the same grid as the work.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final mobile = context.isMobile;
    final muted = type.bodySmall.copyWith(color: colors.inkMuted, height: 1.65);

    final huawei = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(context.t(Profile.huaweiLead), style: type.lead),
        ),
        SizedBox(height: mobile ? AppSpace.x5 : AppSpace.x10),
        Flex(
          direction: mobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (i, (title, body)) in Profile.huaweiParts.indexed) ...[
              if (i > 0) const SizedBox(width: AppSpace.x10, height: AppSpace.x5),
              _Flexible(
                expand: !mobile,
                child: DecoratedBox(
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.line))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppSpace.x4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.t(title), style: type.note.copyWith(color: colors.inkSubtle)),
                        const SizedBox(height: AppSpace.x2),
                        Text(context.t(body), style: muted),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );

    final experience = _Rows(rows: [
      for (final (period, place, role) in Profile.experience) (period, place, role),
    ]);
    const education = _Rows(rows: [Profile.education]);
    final skills = _Rows(rows: [
      for (final (group, tools) in Profile.skills) (group, L.same(tools), null),
    ], plain: true);

    Widget block(L label, Widget content, {double top = AppSpace.x14}) => Padding(
          padding: EdgeInsets.only(top: mobile ? AppSpace.x10 : top),
          child: mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [MonoLabel(context.t(label)), const SizedBox(height: AppSpace.x2), content],
                )
              : GridRow(cells: [
                  GridCell(start: 1, span: 3, child: MonoLabel(context.t(label))),
                  GridCell(start: 4, span: 9, child: content),
                ]),
        );

    return PageColumn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: Copy.about, detail: Copy.aboutRange),
          block(Copy.atHuawei, huawei, top: AppSpace.x10),
          block(Copy.experience, experience, top: AppSpace.x18),
          block(Copy.education, education),
          block(Copy.skills, skills),
          Padding(
            padding: const EdgeInsets.only(top: AppSpace.x8),
            child: mobile
                ? TextLink(label: '${context.t(Copy.downloadCv)} ↗', to: Profile.cv)
                : GridRow(cells: [
                    GridCell(start: 4, span: 9, child: TextLink(label: '${context.t(Copy.downloadCv)} ↗', to: Profile.cv)),
                  ]),
          ),
        ],
      ),
    );
  }
}

class _Flexible extends StatelessWidget {
  final bool expand;
  final Widget child;

  const _Flexible({required this.expand, required this.child});

  @override
  Widget build(BuildContext context) => expand ? Expanded(child: child) : child;
}

/// Ruled rows of a mono first column, a name and an optional detail on the
/// right; on phones the three stack.
class _Rows extends StatelessWidget {
  final List<(L, L, L?)> rows;

  /// Skills read as plain text, not as a name in medium weight.
  final bool plain;

  const _Rows({required this.rows, this.plain = false});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final mobile = context.isMobile;
    final first = type.note.copyWith(color: colors.inkSubtle);
    final name = plain ? type.bodySmall : type.bodySmall.copyWith(fontWeight: FontWeight.w500, fontSize: 16);
    final detail = type.bodySmall.copyWith(color: colors.inkMuted);

    return DecoratedBox(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.line))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (a, b, c) in rows)
            DecoratedBox(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.line))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: mobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.t(a), style: first),
                          const SizedBox(height: AppSpace.x1),
                          Text(context.t(b), style: name),
                          if (c != null) Text(context.t(c), style: detail),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          SizedBox(width: 200, child: Text(context.t(a), style: first)),
                          const SizedBox(width: AppSpace.x6),
                          Expanded(child: Text(context.t(b), style: name)),
                          if (c != null) ...[
                            const SizedBox(width: AppSpace.x6),
                            Text(context.t(c), style: detail),
                          ],
                        ],
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
