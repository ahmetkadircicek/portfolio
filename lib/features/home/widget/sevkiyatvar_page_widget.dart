import 'package:flutter/material.dart';
import 'package:portfolio/features/home/model/card_model.dart';
import 'package:portfolio/core/base/view/project_base_widget.dart';

class SevkiyatvarView extends StatelessWidget {
  const SevkiyatvarView({super.key});

  @override
  Widget build(BuildContext context) {
    const project = CardModel(
      title: 'SEVKIYATVAR',
      subtitle: 'Logistics Management Platform',
      description:
          'An existing logistics platform that I helped enhance and optimize for better shipping and logistics management',
      imagePath: 'assets/images/sevkiyatvar/sevkiyatvar_logo.webp',
      category: 'Logistics',
      firstColor: Color(0xFF34A853),
      secondColor: Color(0xFF1E7E34),
    );

    const features = [
      CardModel(
        title: 'User-Friendly Interface',
        subtitle: 'Modern Design',
        description:
            "I redesigned the Sevkiyatvar application to create a more intuitive and user-friendly interface. I improved the user experience by simplifying complex logistics processes.",
        imagePath: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_01.webp',
        category: 'Modern Design',
        firstColor: Color(0xFF677685),
        secondColor: Color(0xFF495459),
      ),
      CardModel(
        title: 'Real-Time Tracking',
        subtitle: 'Instant Monitoring',
        description:
            "By adding real-time tracking functionality for shipping processes, I enabled users to track their cargo instantly. I implemented GPS integration to enable route optimization.",
        imagePath: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_02.webp',
        category: 'Instant Monitoring',
        firstColor: Colors.white,
        secondColor: Color(0xFFFAFAFA),
      ),
      CardModel(
        title: 'Advanced Reporting',
        subtitle: 'Data Analysis',
        description:
            "I enhanced measurement and reporting capabilities for shipping performance by adding comprehensive analytical tools. Users can now access detailed statistics and customizable reports.",
        imagePath: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_03.webp',
        category: 'Data Analysis',
        firstColor: Colors.white,
        secondColor: Color(0xFFFAFAFA),
      ),
      CardModel(
        title: 'Android & iOS Support',
        subtitle: 'Cross-Platform Mobility',
        description:
            "I developed the application to work flawlessly on both Android and iOS platforms, ensuring compatibility with the latest device models. Users can access their logistics data seamlessly across both operating systems with real-time synchronization.",
        imagePath: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_04.webp',
        category: 'Mobile Platforms',
        firstColor: Colors.white,
        secondColor: Color(0xFFFAFAFA),
      ),
    ];

    return const ProjectBaseView(
      slug: 'sevkiyatvar',
      project: project,
      features: features,
    );
  }
}
