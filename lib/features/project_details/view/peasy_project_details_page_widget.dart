import 'package:flutter/material.dart';
import 'package:portfolio/core/base/view/project_details_base_widget.dart';

class PeasyProjectDetailsView extends StatelessWidget {
  const PeasyProjectDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProjectDetailsBaseWidget(
      title: 'Peasy — Self-Checkout App',
      description:
          'Peasy is a mobile application developed as part of my graduation project with a team of 4 members. The app solves customer queue waiting problems by enabling self-checkout through NFC technology. Users can simply scan products with their phones and complete their purchases without waiting in line. The system includes a sophisticated backend service that recommends similar products based on the customer\'s purchase history and current selections. This project allowed me to gain experience in collaborative development, NFC integration, and recommendation systems while creating a practical solution for retail environments.',
      iconPath: 'assets/images/peasy/peasy_logo.webp',
      technologyTags: [
        'Flutter',
        'Dart',
        'NFC',
        'Firebase',
        'REST API',
        'Recommendation Systems',
        'Team Collaboration',
      ],
      screenshotPaths: [
        'assets/images/peasy/peasy_screenshots_1.webp',
        'assets/images/peasy/peasy_screenshots_6.webp',
        'assets/images/peasy/peasy_screenshots_7.webp',
        'assets/images/peasy/peasy_screenshots_3.webp',
        'assets/images/peasy/peasy_screenshots_3.webp',
        'assets/images/peasy/peasy_screenshots_4.webp',
        'assets/images/peasy/peasy_screenshots_5.webp',
      ],
      states: [
        ProjectState(label: 'Under Development', color: Colors.orange),
        ProjectState(
          label: 'Github',
          color: Colors.black,
          url: 'https://github.com/ahmetkadircicek/peasy',
        ),
      ],
    );
  }
}
