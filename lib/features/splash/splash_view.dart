import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  /// What the landing page shows first; fetched while the signature plays so
  /// the home page appears complete instead of filling in.
  static const _landingImages = [
    'assets/images/common/profile.webp',
    'assets/images/common/signature.webp',
    'assets/images/common/shape.webp',
  ];

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    // Starts downloading the landing page's display font.
    GoogleFonts.cardo(fontWeight: FontWeight.w900);

    _timer = Timer(const Duration(seconds: 3), _navigateToNextScreen);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final path in _landingImages) {
      precacheImage(AssetImage(path), context);
    }
  }

  Future<void> _navigateToNextScreen() async {
    await _fadeController.reverse();
    // Replaces the splash in the browser history; otherwise Back would land
    // on the splash and bounce to /home again.
    if (mounted) Router.neglect(context, () => context.go('/home'));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200 * 126 / 480,
                  child: Image.asset(
                    // Plays once (the file's loop count is 1).
                    'assets/images/common/signature_animated.webp',
                    excludeFromSemantics: true,
                  ),
                ),
                context.spacerFixedHeight(20),
                Text(
                  'Hello, I am Ahmet Kadir ÇİÇEK.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                context.spacerFixedHeight(4),
                Text(
                  'Cross and Native Mobile Application Developer',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
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
