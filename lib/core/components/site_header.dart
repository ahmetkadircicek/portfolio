import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  const SiteHeader({super.key, this.trailing, this.bottom});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    return PageFrame(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mobile ? AppSpace.x4 : AppSpace.x6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpace.x4,
          children: [
            Row(
              children: [
                const HomeMark(),
                const Spacer(),
                if (trailing != null) Flexible(flex: 4, child: trailing!),
              ],
            ),
            if (bottom != null) bottom!,
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

  const HomeMark({super.key, this.linksHome = true, this.showAvatar = true});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final mark = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpace.x3,
      children: [
        if (showAvatar)
          const CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.surface,
            backgroundImage: AssetImage('assets/images/common/profile.jpg'),
          ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ahmet Kadir Çiçek', style: text.title.copyWith(height: 1.3)),
            Text('Cross and Native Mobile Developer',
                style: text.bodySmall.copyWith(height: 1.3, color: AppColors.inkMuted)),
          ],
        ),
      ],
    );
    if (!linksHome) return mark;
    return Semantics(
      link: true,
      label: 'Home',
      child: HoverDetector(
        child: GestureDetector(onTap: () => context.go('/home'), child: mark),
      ),
    );
  }
}
