import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/components/hover_link.dart';
import 'package:portfolio/core/components/page_frame.dart';
import 'package:portfolio/core/components/primary_button.dart';
import 'package:portfolio/core/components/reveal.dart';
import 'package:portfolio/core/components/section_header.dart';
import 'package:portfolio/core/constants/app_links.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

/// Closing call to action and footer. This is the only place on the home
/// page that leads to the contact form.
class ContactCtaSection extends StatelessWidget {
  final VoidCallback onBackToTop;

  const ContactCtaSection({super.key, required this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final mobile = context.isMobile;
    final footerStyle = text.bodySmall.copyWith(color: AppColors.onInkMuted);

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
            decoration: const BoxDecoration(color: AppColors.ink, borderRadius: AppRadius.lgAll),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Eyebrow('Have an app in mind?', color: AppColors.onInkMuted),
                const SizedBox(height: AppSpace.x6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    mobile ? 'LET\'S MAKE\nIT SIMPLE' : 'LET\'S MAKE IT SIMPLE',
                    style: text.display.copyWith(color: AppColors.onInk),
                  ),
                ),
                const SizedBox(height: AppSpace.x6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Text(
                    'Tell me about your project and I\'ll get back to you as soon as possible.',
                    style: text.bodyLarge.copyWith(color: AppColors.onInkMuted),
                  ),
                ),
                const SizedBox(height: AppSpace.x8),
                PrimaryButton(label: 'Request a project', inverted: true, onPressed: () => context.go('/contact')),
                SizedBox(height: mobile ? AppSpace.x16 : AppSpace.x24),
                Divider(height: 1, thickness: 1, color: AppColors.onInk.withValues(alpha: 0.15)),
                const SizedBox(height: AppSpace.x6),
                Flex(
                  direction: mobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: mobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: AppSpace.x4,
                  children: [
                    Text('© ${DateTime.now().year} Ahmet Kadir Çiçek', style: footerStyle),
                    Wrap(
                      spacing: AppSpace.x6,
                      runSpacing: AppSpace.x3,
                      children: [
                        HoverLink(
                          label: 'GitHub',
                          icon: LinkIcon.external,
                          color: AppColors.onInk,
                          style: text.bodySmall,
                          onTap: () => launchUrl(Uri.parse(AppLinks.github), webOnlyWindowName: '_blank'),
                        ),
                        HoverLink(
                          label: 'Back to top',
                          icon: LinkIcon.up,
                          color: AppColors.onInk,
                          style: text.bodySmall,
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
