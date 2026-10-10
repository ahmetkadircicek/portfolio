import 'package:flutter/material.dart';
import 'package:portfolio/core/components/web_link.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/components/hover_link.dart';
import 'package:portfolio/core/components/page_frame.dart';
import 'package:portfolio/core/components/primary_button.dart';
import 'package:portfolio/core/components/reveal.dart';
import 'package:portfolio/core/components/section_header.dart';
import 'package:portfolio/core/constants/app_links.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Closing call to action and footer. This is the only place on the home
/// page that leads to the contact form.
class ContactCtaSection extends StatelessWidget {
  final VoidCallback onBackToTop;

  const ContactCtaSection({super.key, required this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final mobile = context.isMobile;
    final footerStyle = text.bodySmall.copyWith(color: context.colors.onBlockMuted);

    return PageFrame(
      child: Padding(
        padding: EdgeInsets.only(bottom: context.gutter / (mobile ? 1 : 2)),
        child: Reveal(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              mobile ? AppSpace.x6 : AppSpace.x16,
              mobile ? AppSpace.x16 : AppSpace.x24,
              mobile ? AppSpace.x6 : AppSpace.x16,
              AppSpace.x8,
            ),
            decoration: BoxDecoration(color: context.colors.block, borderRadius: AppRadius.lgAll),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Eyebrow(context.t(S.ctaEyebrow), color: context.colors.onBlockMuted),
                const SizedBox(height: AppSpace.x6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    mobile ? context.t(S.ctaTitle).replaceFirst(RegExp(r' (?=\S+ \S+$)'), '\n') : context.t(S.ctaTitle),
                    style: text.h1.copyWith(color: context.colors.onBlock),
                  ),
                ),
                const SizedBox(height: AppSpace.x6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Text(
                    context.t(S.ctaBody),
                    style: text.bodyLarge.copyWith(color: context.colors.onBlockMuted),
                  ),
                ),
                const SizedBox(height: AppSpace.x8),
                WebLink(
                  to: '/contact',
                  builder: (context, follow) =>
                      PrimaryButton(label: context.t(S.requestProject), inverted: true, onPressed: follow),
                ),
                SizedBox(height: mobile ? AppSpace.x16 : AppSpace.x24),
                Divider(height: 1, thickness: 1, color: context.colors.onBlock.withValues(alpha: 0.15)),
                const SizedBox(height: AppSpace.x6),
                Flex(
                  direction: mobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: mobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: AppSpace.x4,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSpace.x1,
                      children: [
                        Text(context.t(S.now), style: footerStyle),
                        Text('© ${DateTime.now().year} Ahmet Kadir Çiçek', style: footerStyle),
                      ],
                    ),
                    Wrap(
                      spacing: AppSpace.x6,
                      runSpacing: AppSpace.x3,
                      children: [
                        for (final (label, to) in [
                          ('GitHub', AppLinks.github),
                          ('LinkedIn', AppLinks.linkedin),
                          ('Medium', AppLinks.medium),
                        ])
                          HoverLink(label: label, icon: LinkIcon.external, color: context.colors.onBlock, to: to),
                        HoverLink(
                          label: context.t(S.backToTop),
                          icon: LinkIcon.up,
                          color: context.colors.onBlock,
                          onTap: onBackToTop,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
