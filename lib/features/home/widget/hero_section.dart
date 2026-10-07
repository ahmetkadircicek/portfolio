import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/components/language_switch.dart';
import 'package:portfolio/core/components/hover_link.dart';
import 'package:portfolio/core/components/section_header.dart';
import 'package:portfolio/core/components/site_header.dart';
import 'package:portfolio/core/constants/app_links.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

/// First screen: a rounded card that fills the viewport with the name, the
/// signature, "MAKE IT SIMPLE" over the 3D shape, the tech stack and the way
/// down to the work.
class HeroSection extends StatelessWidget {
  final VoidCallback onShowWork;

  const HeroSection({super.key, required this.onShowWork});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final gutter = context.gutter;
    return SizedBox(
      // Short landscape phones still get a readable card.
      height: context.isDesktop ? context.height : context.height.clamp(600.0, double.infinity),
      child: Container(
        margin: EdgeInsets.all(gutter / (mobile ? 1 : 2)),
        padding: EdgeInsets.all(mobile ? AppSpace.x4 : AppSpace.x8),
        decoration: BoxDecoration(color: context.colors.surface, borderRadius: AppRadius.lgAll),
        child: Column(
          children: [
            mobile ? const _MobileTop() : const _Top(),
            const Expanded(child: _Center()),
            mobile ? _MobileBottom(onShowWork: onShowWork) : _Bottom(onShowWork: onShowWork),
          ],
        ),
      ),
    );
  }
}

void _openCv() => launchUrl(Uri.parse(AppLinks.cv), webOnlyWindowName: '_blank');

class _Top extends StatelessWidget {
  const _Top();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Align(alignment: Alignment.centerLeft, child: HomeMark(linksHome: false, showAvatar: false)),
        ),
        const _Avatar(radius: 48),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpace.x4,
              children: [
                HoverLink(label: context.t(S.downloadCv), icon: LinkIcon.external, onTap: _openCv),
                const TopControls(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileTop extends StatelessWidget {
  const _MobileTop();

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final top = Column(
      spacing: AppSpace.x3,
      children: [
        const _Avatar(radius: 36),
        Column(
          children: [
            Text('Ahmet Kadir Çiçek', style: text.title),
            Text(context.t(S.role), style: text.bodySmall.copyWith(color: context.colors.inkMuted)),
          ],
        ),
      ],
    );
    return Stack(
      children: [
        Center(child: top),
        const Positioned(top: 0, right: 0, child: TopControls()),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  final double radius;
  const _Avatar({required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: context.colors.canvas,
      backgroundImage: const AssetImage('assets/images/common/profile.jpg'),
    );
  }
}

class _Center extends StatelessWidget {
  const _Center();

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final text = context.text;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: context.width * (mobile ? 0.8 : (context.isTablet ? 0.6 : 0.4)),
          // The shape loops forever; isolate it so the text and the rest of
          // the card are not repainted with every frame.
          child: RepaintBoundary(
            child: Image.asset(
              'assets/images/common/shape.webp',
              fit: BoxFit.contain,
              opacity: const AlwaysStoppedAnimation(0.3),
              gaplessPlayback: true,
              excludeFromSemantics: true,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: mobile ? 160 : 200,
              height: mobile ? 40 : 50,
              child: Image.asset(
                'assets/images/common/signature.webp',
                fit: BoxFit.fitWidth,
                opacity: const AlwaysStoppedAnimation(0.8),
                excludeFromSemantics: true,
              ),
            ),
            const SizedBox(height: AppSpace.x2),
            FittedBox(
              child: Semantics(
                header: true,
                child: Text('MAKE IT SIMPLE', style: text.display),
              ),
            ),
            const SizedBox(height: AppSpace.x4),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Text(
                context.t(S.heroLine),
                style: text.bodyLarge.copyWith(color: context.colors.inkMuted),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Bottom extends StatelessWidget {
  final VoidCallback onShowWork;
  const _Bottom({required this.onShowWork});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(child: _TechStack(alignment: CrossAxisAlignment.start)),
        HoverLink(label: context.t(projects.title), icon: LinkIcon.down, onTap: onShowWork),
      ],
    );
  }
}

class _MobileBottom extends StatelessWidget {
  final VoidCallback onShowWork;
  const _MobileBottom({required this.onShowWork});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpace.x6,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpace.x6,
          runSpacing: AppSpace.x3,
          children: [
            HoverLink(label: context.t(S.downloadCv), icon: LinkIcon.external, onTap: _openCv),
            HoverLink(label: context.t(projects.title), icon: LinkIcon.down, onTap: onShowWork),
          ],
        ),
        const _TechStack(alignment: CrossAxisAlignment.center),
      ],
    );
  }
}

class _TechStack extends StatelessWidget {
  final CrossAxisAlignment alignment;
  const _TechStack({required this.alignment});

  // From the Technical Skills section of the CV.
  static const _stack = [
    ('Swift', SimpleIcons.swift),
    ('Flutter', SimpleIcons.flutter),
    ('Dart', SimpleIcons.dart),
    ('HarmonyOS', SimpleIcons.harmonyos),
    ('TypeScript', SimpleIcons.typescript),
    ('JavaScript', SimpleIcons.javascript),
    ('Python', SimpleIcons.python),
    ('Firebase', SimpleIcons.firebase),
  ];

  @override
  Widget build(BuildContext context) {
    // Phones keep all eight chips on one line.
    final chip = context.isMobile ? 34.0 : 40.0;
    final chipGap = context.isMobile ? AppSpace.x1 : AppSpace.x2;
    return Semantics(
      label: '${context.t(S.techStack)}: ${_stack.map((e) => e.$1).join(', ')}',
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: alignment,
        spacing: AppSpace.x2,
        children: [
          Eyebrow(context.t(S.techStack)),
          Wrap(
            spacing: chipGap,
            children: [
              for (final (_, icon) in _stack)
                Container(
                  width: chip,
                  height: chip,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: context.colors.canvas, borderRadius: BorderRadius.circular(chip * 0.3)),
                  child: Iconify(icon, color: context.colors.ink, size: chip / 2),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
