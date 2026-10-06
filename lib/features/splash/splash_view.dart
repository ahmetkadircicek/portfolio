import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/utils/performance_logger.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final GifController signatureController;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  final _logger = PerformanceLogger.instance;

  @override
  void initState() {
    super.initState();
    _logger.startOperation('SplashViewInitialization');

    _logger.startOperation('SplashControllerInitialization');
    signatureController = GifController(vsync: this);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _logger.endOperation('SplashControllerInitialization');

    _navigateToNextScreen();
    _logger.endOperation('SplashViewInitialization');
  }

  Future<void> _navigateToNextScreen() async {
    _logger.startOperation('SplashScreenDelay');
    await Future.delayed(const Duration(seconds: 3));
    _logger.endOperation('SplashScreenDelay');

    if (mounted) {
      _logger.startOperation('SplashNavigationTransition');
      _fadeController.reverse().then((_) {
        _logger.logMessage('Navigating from Splash to Home');
        context.go('/home');
        _logger.endOperation('SplashNavigationTransition');
      });
    }
  }

  @override
  void dispose() {
    _logger.startOperation('SplashViewDispose');
    _fadeController.dispose();
    signatureController.dispose();
    _logger.endOperation('SplashViewDispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logger.startOperation('SplashViewBuild');
    final result = FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Center(
                  child: Gif(
                    fps: 30,
                    autostart: Autostart.once,
                    controller: signatureController,
                    image: const AssetImage('assets/images/common/signature_animated.webp'),
                  ),
                ),
              ),
              context.spacerFixedHeight(20),
              Text(
                'Hello, I am Ahmet Kadir ÇİÇEK.',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              context.spacerFixedHeight(4),
              Text(
                'Cross and Native Mobile Application Developer',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    _logger.endOperation('SplashViewBuild');
    return result;
  }
}
