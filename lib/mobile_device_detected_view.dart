import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/constants/padding_constants.dart';

class MobileDeviceDetectedView extends StatelessWidget {
  const MobileDeviceDetectedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: PaddingConstants.allLarge * 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: Align(
                  heightFactor: 0.9,
                  child: Transform.scale(
                    scale: 1.2,
                    child: Image.asset(
                      'assets/images/common/mobile_alert.png',
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
              ),
              Text(
                'Mobil Cihaz Algılandı',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Üzgünüm, bu portfolio şu anda sadece masaüstü görünümü desteklemektedir. En iyi deneyim için lütfen bir masaüstü bilgisayar veya laptop ile ziyaret ediniz.',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Mobil uyumlu versiyonu yakında hizmetinizde olacaktır!',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
