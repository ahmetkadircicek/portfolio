import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:iconify_flutter/icons/fa6_brands.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/init/service/firebase_service.dart';
import 'package:portfolio/core/utils/performance_logger.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/padding_constants.dart';

import 'package:portfolio/features/home/widget/sevkiyatvar_page_widget.dart';
import 'package:portfolio/features/home/widget/tunes_page_widget.dart';
import 'package:portfolio/features/home/widget/vilsa_page_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    PerformanceLogger.instance.startOperation('HomeViewBuild');
    final result = Material(
      child: context.isDesktop ? const _Desktop() : Container(),
    );
    PerformanceLogger.instance.endOperation('HomeViewBuild');
    return result;
  }
}

class _Desktop extends StatefulWidget {
  const _Desktop();

  @override
  State<_Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<_Desktop> {
  final PageController _pageController = PageController();
  final _logger = PerformanceLogger.instance;

  @override
  void initState() {
    super.initState();
    _logger.startOperation('DesktopHomeInitialization');
    _logger.logMessage('Desktop home page controller initialized');
    _logger.endOperation('DesktopHomeInitialization');
  }

  @override
  void dispose() {
    _logger.startOperation('DesktopHomeDispose');
    _pageController.dispose();
    _logger.endOperation('DesktopHomeDispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logger.startOperation('DesktopHomeBuild');
    final result = SizedBox(
      height: context.height,
      width: context.width,
      child: PageView(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        pageSnapping: false,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) {
          _logger.logMessage('Home page changed to index: $index');
        },
        children: const [
          LandingPage(),
          TunesView(),
          VilsaView(),
          SevkiyatvarView(),
        ],
      ),
    );
    _logger.endOperation('DesktopHomeBuild');
    return result;
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  late final GifController shapeController;
  final _logger = PerformanceLogger.instance;

  @override
  void initState() {
    super.initState();
    _logger.startOperation('LandingPageInitialization');
    _logger.startOperation('GifControllerInitialization');
    shapeController = GifController(vsync: this);
    _logger.endOperation('GifControllerInitialization');
    _logger.endOperation('LandingPageInitialization');
  }

  @override
  void dispose() {
    _logger.startOperation('LandingPageDispose');
    shapeController.dispose();
    _logger.endOperation('LandingPageDispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logger.startOperation('LandingPageBuild');
    final result = Material(
      child: SizedBox(
        height: context.height,
        width: context.width,
        child: Container(
          decoration: BoxDecoration(
            color: context.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          margin: PaddingConstants.allLarge + PaddingConstants.symmetricHorizontalLarge,
          padding: PaddingConstants.allLarge,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopLeft(),
                  _TopCenter(),
                  _TopRight(),
                ],
              ),
              _Center(shapeController),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: _BottomLeft()),
                  Expanded(child: _BottomRight()),
                ],
              )
            ],
          ),
        ),
      ),
    );
    _logger.endOperation('LandingPageBuild');
    return result;
  }
}

class _TopCenter extends StatelessWidget {
  const _TopCenter();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 60,
      backgroundImage: AssetImage('assets/images/common/profile.webp'),
    );
  }
}

class _BottomRight extends StatelessWidget {
  const _BottomRight();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        HoverDetector(
          child: GestureDetector(
            onTap: () => context.go('/projects'),
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
      ],
    );
  }
}

class _BottomLeft extends StatelessWidget {
  const _BottomLeft();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tech Stack',
          style: GoogleFonts.montserrat(
            fontSize: 14,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Iconify(IconParkSolid.adobe_photoshop, color: context.onPrimary.withAlpha(204)),
            Iconify(IconParkSolid.adobe_illustrate, color: context.onPrimary.withAlpha(204)),
            Iconify(Ci.adobe_xd, color: context.onPrimary.withAlpha(204)),
            Iconify(IconParkSolid.figma, color: context.onPrimary.withAlpha(204)),
            Iconify(Fa6Brands.swift, color: context.onPrimary.withAlpha(204)),
            Iconify(MaterialSymbols.flutter, color: context.onPrimary.withAlpha(204)),
            Iconify(SimpleIcons.microsoftoffice, color: context.onPrimary.withAlpha(204)),
            Iconify(SimpleIcons.blender, color: context.onPrimary.withAlpha(204)),
          ],
        ),
      ],
    );
  }
}

class _Center extends StatelessWidget {
  final GifController shapeController;
  const _Center(this.shapeController);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Opacity(
              opacity: 0.3,
              child: SizedBox(
                width: context.width * 0.4,
                child: Gif(
                  repeat: ImageRepeat.repeat,
                  autostart: Autostart.loop,
                  controller: shapeController,
                  image: const AssetImage('assets/images/common/shape.webp'),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.asset(
                      'assets/images/common/signature.webp',
                      fit: BoxFit.fitWidth,
                    ),
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
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
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
          HoverDetector(
            child: GestureDetector(
              onTap: () async {
                await FirebaseService().downloadFromUrl();
              },
              child: Text(
                'Download CV',
                style: GoogleFonts.montserrat(fontSize: 14, color: context.onPrimary.withAlpha(204)),
              ),
            ),
          ),
          context.spacerWidth(1),
          HoverDetector(
            child: GestureDetector(
              onTap: () => context.go('/contact'),
              child: Text(
                'Request a project',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopLeft extends StatelessWidget {
  const _TopLeft();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    );
  }
}
