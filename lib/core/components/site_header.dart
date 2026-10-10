import 'package:flutter/material.dart';
import 'package:portfolio/core/components/web_link.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/components/language_switch.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/components/page_frame.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Top bar of every page except home: the name leads back home, [trailing]
/// holds the page's own controls.
class SiteHeader extends StatelessWidget {
  final Widget? trailing;

  /// Shown under the bar on phones, where it does not fit beside the name.
  final Widget? bottom;

  /// What the name does when tapped; defaults to going to the home page.
  final VoidCallback? onHome;

  /// Less padding, for the bar that slides over the home page.
  final bool compact;

  const SiteHeader({super.key, this.trailing, this.bottom, this.onHome, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    return PageFrame(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: compact ? AppSpace.x3 : (mobile ? AppSpace.x4 : AppSpace.x6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpace.x4,
          children: [
            Row(
              children: [
                // Without page controls the name takes the free width, so a
                // phone wraps the title instead of pushing the language
                // switch off the screen.
                if (trailing == null)
                  Expanded(child: Align(alignment: Alignment.centerLeft, child: HomeMark(onTap: onHome)))
                else ...[
                  HomeMark(onTap: onHome),
                  const Spacer(),
                  Flexible(flex: 4, child: trailing!),
                ],
                const SizedBox(width: AppSpace.x4),
                const TopControls(),
              ],
            ),
            ?bottom,
          ],
        ),
      ),
    );
  }
}

/// Avatar, name and title; leads back to the home page.
class HomeMark extends StatelessWidget {
  final bool linksHome;
  final bool showAvatar;
  final VoidCallback? onTap;

  const HomeMark({super.key, this.linksHome = true, this.showAvatar = true, this.onTap});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final mark = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpace.x3,
      children: [
        if (showAvatar)
          CircleAvatar(
            radius: 20,
            backgroundColor: context.colors.surface,
            backgroundImage: const AssetImage('assets/images/common/profile.jpg'),
          ),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ahmet Kadir Çiçek', style: text.title.copyWith(height: 1.3)),
              Text(context.t(S.role), style: text.bodySmall.copyWith(height: 1.3, color: context.colors.inkMuted)),
            ],
          ),
        ),
      ],
    );
    if (!linksHome) return mark;
    return Semantics(
      link: true,
      label: context.t(S.home),
      child: HoverDetector(
        child: onTap != null
            ? GestureDetector(onTap: onTap, child: mark)
            : WebLink(to: '/', builder: (context, follow) => GestureDetector(onTap: follow, child: mark)),
      ),
    );
  }
}
