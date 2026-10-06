import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:iconify_flutter/icons/fa6_brands.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/constants/app_links.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/features/home/widget/sevkiyatvar_page_widget.dart';
import 'package:portfolio/features/home/widget/tunes_page_widget.dart';
import 'package:portfolio/features/home/widget/vilsa_page_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/padding_constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: context.isDesktop ? const _Desktop() : const _Compact(),
    );
  }
}

/// Full-height sections the user scrolls through freely.
class _Desktop extends StatefulWidget {
  const _Desktop();

  @override
  State<_Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<_Desktop> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: PageView(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        pageSnapping: false,
        physics: const ClampingScrollPhysics(),
        children: const [
          LandingPage(),
          TunesView(),
          VilsaView(),
          SevkiyatvarView(),
        ],
      ),
    );
  }
}

/// Phones and tablets: the landing card fills the screen and the project
/// sections follow at their natural height.
class _Compact extends StatelessWidget {
  const _Compact();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        LandingPage(),
        TunesView(),
        VilsaView(),
        SevkiyatvarView(),
      ],
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    return Material(
      child: SizedBox(
        // Short landscape phones still get a readable card.
        height: context.isDesktop ? context.height : context.height.clamp(560.0, double.infinity),
        width: context.width,
        child: Container(
          decoration: BoxDecoration(
            color: context.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          margin: context.pageMargin,
          padding: mobile ? PaddingConstants.allMedium : PaddingConstants.allLarge,
          child: Column(
            children: [
              if (mobile)
                const _MobileTop()
              else
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TopLeft(),
                    _TopCenter(),
                    _TopRight(),
                  ],
                ),
              const _Center(),
              if (mobile)
                const _MobileBottom()
              else
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: _BottomLeft()),
                    Expanded(child: _BottomRight()),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileTop extends StatelessWidget {
  const _MobileTop();

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 12,
      children: [
        _TopCenter(radius: 40),
        _NameAndTitle(alignment: CrossAxisAlignment.center),
      ],
    );
  }
}

class _MobileBottom extends StatelessWidget {
  const _MobileBottom();

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 20,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20,
          runSpacing: 12,
          children: [
            _DownloadCvButton(),
            _RequestProjectButton(),
            _ProjectsButton(),
          ],
        ),
        _TechStack(alignment: CrossAxisAlignment.center),
      ],
    );
  }
}

class _TopCenter extends StatelessWidget {
  final double radius;
  const _TopCenter({this.radius = 60});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      backgroundImage: const AssetImage('assets/images/common/profile.webp'),
    );
  }
}

class _BottomRight extends StatelessWidget {
  const _BottomRight();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_ProjectsButton()],
    );
  }
}

class _ProjectsButton extends StatelessWidget {
  const _ProjectsButton();

  @override
  Widget build(BuildContext context) {
    return HoverDetector(
      child: GestureDetector(
        onTap: () => context.go('/projects'),
        // The shimmer animates forever; keep its repaints to itself.
        child: RepaintBoundary(
          child: Shimmer.fromColors(
            baseColor: context.onPrimary,
            highlightColor: Colors.yellow[700]!,
            child: Text(
              'Projects',
              style: GoogleFonts.montserrat(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomLeft extends StatelessWidget {
  const _BottomLeft();

  @override
  Widget build(BuildContext context) {
    return const _TechStack(alignment: CrossAxisAlignment.start);
  }
}

class _TechStack extends StatelessWidget {
  final CrossAxisAlignment alignment;
  const _TechStack({required this.alignment});

  @override
  Widget build(BuildContext context) {
    final color = context.onPrimary.withAlpha(204);
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          'Tech Stack',
          style: GoogleFonts.montserrat(
            fontSize: 14,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Iconify(IconParkSolid.adobe_photoshop, color: color),
            Iconify(IconParkSolid.adobe_illustrate, color: color),
            Iconify(Ci.adobe_xd, color: color),
            Iconify(IconParkSolid.figma, color: color),
            Iconify(Fa6Brands.swift, color: color),
            Iconify(MaterialSymbols.flutter, color: color),
            Iconify(SimpleIcons.microsoftoffice, color: color),
            Iconify(SimpleIcons.blender, color: color),
          ],
        ),
      ],
    );
  }
}

class _Center extends StatelessWidget {
  const _Center();

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SizedBox(
              width: context.width * (mobile ? 0.8 : (context.isTablet ? 0.6 : 0.4)),
              // The shape loops forever; isolate it so the text and the rest
              // of the card are not repainted with every frame.
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
          ),
          Padding(
            padding: mobile ? PaddingConstants.symmetricHorizontalSmall : EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: mobile ? 160 : 200,
                    height: mobile ? 40 : 50,
                    child: Image.asset(
                      'assets/images/common/signature.webp',
                      fit: BoxFit.fitWidth,
                      opacity: const AlwaysStoppedAnimation(0.8),
                      excludeFromSemantics: true,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    'MAKE IT SIMPLE',
                    style: GoogleFonts.cardo(
                      fontSize: 96,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 14,
                    ),
                  ),
                ),
                SizedBox(
                  width: 450,
                  child: Text(
                    'I develop user-friendly mobile apps that improve user experience and help businesses grow.',
                    style: GoogleFonts.montserrat(
                      fontSize: mobile ? 14 : 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopRight extends StatelessWidget {
  const _TopRight();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          const _DownloadCvButton(),
          context.spacerWidth(1),
          const _RequestProjectButton(),
        ],
      ),
    );
  }
}

class _DownloadCvButton extends StatelessWidget {
  const _DownloadCvButton();

  @override
  Widget build(BuildContext context) {
    return HoverDetector(
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(AppLinks.cv), webOnlyWindowName: '_blank'),
        child: Text(
          'Download CV',
          style: GoogleFonts.montserrat(fontSize: 14, color: context.onPrimary.withAlpha(204)),
        ),
      ),
    );
  }
}

class _RequestProjectButton extends StatelessWidget {
  const _RequestProjectButton();

  @override
  Widget build(BuildContext context) {
    return HoverDetector(
      child: GestureDetector(
        onTap: () => context.go('/contact'),
        child: Text(
          'Request a project',
          style: GoogleFonts.montserrat(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _TopLeft extends StatelessWidget {
  const _TopLeft();

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: _NameAndTitle(alignment: CrossAxisAlignment.start),
    );
  }
}

class _NameAndTitle extends StatelessWidget {
  final CrossAxisAlignment alignment;
  const _NameAndTitle({required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ahmet Kadir Çiçek',
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.bold, color: context.onPrimary.withAlpha(204)),
        ),
        Text(
          'Cross and Native Mobile Developer',
          style: GoogleFonts.montserrat(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
