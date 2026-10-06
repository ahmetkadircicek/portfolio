import 'package:flutter/material.dart';
import 'package:portfolio/core/base/view/project_details_base_widget.dart';

class SevkiyatvarProjectDetailsView extends StatelessWidget {
  const SevkiyatvarProjectDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProjectDetailsBaseWidget(
      title: 'Sevkiyatvar Modernization',
      description:
          'Sevkiyatvar is a large-scale app modernization project I led for a logistics company, redesigning and rebuilding their existing system using Flutter. The project was initiated to address user feedback about the outdated interface and functionality of an earlier version. I implemented a cleaner, more intuitive UI/UX flow while maintaining the core business logic that users were familiar with. By decomposing the legacy code into reusable Flutter components and implementing state management with Provider, I was able to create a platform that significantly improved both driver and dispatcher user experiences. I focused on enhancing user experience while maintaining the core functionality that made the original app valuable to its users. This project demonstrates my ability to take established solutions and elevate them with modern development practices.',
      iconPath: 'assets/images/sevkiyatvar/sevkiyatvar_logo.png',
      technologyTags: [
        'Flutter',
        'Dart',
        'MVVM',
        'REST API',
        'Connectivity',
        'Provider',
      ],
      screenshotPaths: [
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_1.png',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_2.png',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_3.png',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_4.png',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_5.png',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_6.png',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_7.png',
      ],
      states: [
        ProjectState(label: 'Ready to Release', color: Colors.green),
      ],
    );
  }
}
