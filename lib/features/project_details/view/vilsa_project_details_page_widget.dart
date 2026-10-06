import 'package:flutter/material.dart';
import 'package:portfolio/core/base/view/project_details_base_widget.dart';

class VilsaProjectDetailsView extends StatelessWidget {
  const VilsaProjectDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProjectDetailsBaseWidget(
      title: 'Vilsa — E-Commerce App',
      description:
          'Vilsa is a robust mobile e-commerce app that I developed for a small business client using Flutter with Firebase as the backend. The app provides users with a seamless shopping experience for a wide range of products, featuring an intuitive UI/UX design that emphasizes ease of navigation and visual appeal. As the sole developer on this project, I implemented comprehensive features including user authentication, real-time product updates, and secure payment integration.',
      iconPath: 'assets/images/vilsa/vilsa_logo.jpg',
      technologyTags: [
        'Flutter',
        'Dart',
        'Firebase',
        'Provider',
        'MVVM',
        'Figma',
        'Charts',
      ],
      screenshotPaths: [
        'assets/images/vilsa/vilsa_screenshots_1.png',
        'assets/images/vilsa/vilsa_screenshots_2.png',
        'assets/images/vilsa/vilsa_screenshots_3.png',
        'assets/images/vilsa/vilsa_screenshots_4.png',
        'assets/images/vilsa/vilsa_screenshots_5.png',
        'assets/images/vilsa/vilsa_screenshots_6.png',
        'assets/images/vilsa/vilsa_screenshots_7.png',
      ],
      states: [
        ProjectState(label: 'Ready to Release', color: Colors.green),
        ProjectState(
          label: 'Github',
          color: Colors.black,
          url: 'https://github.com/ahmetkadircicek/vilsa',
        ),
      ],
    );
  }
}
