import 'package:flutter/material.dart';
import 'package:portfolio/core/base/view/project_details_base_widget.dart';

class VisiostellarProjectDetailsView extends StatelessWidget {
  const VisiostellarProjectDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProjectDetailsBaseWidget(
      title: 'Visiostellar — iOS Astronomy App',
      description:
          'Visiostellar is an iOS astronomy application I built when I first started my mobile development career. Developed entirely in Swift with UIKit, this app was my introduction to iOS development fundamentals. I implemented the user interface using Storyboard and Auto Layout constraints to create a responsive design across different iOS devices. The app provides users with astronomical information, celestial object tracking, and educational content about space. This project helped me gain valuable experience with Swift programming patterns, iOS navigation systems, and Apple\'s design guidelines.',
      iconPath: 'assets/images/visiostellar/visiostellar_logo.webp',
      technologyTags: [
        'Swift',
        'UIKit',
        'Storyboard',
        'Auto Layout',
        'iOS',
        'Xcode',
        'MVC',
      ],
      screenshotPaths: [
        'assets/images/visiostellar/visiostellar_screenshots_1.webp',
        'assets/images/visiostellar/visiostellar_screenshots_4.webp',
        'assets/images/visiostellar/visiostellar_screenshots_3.webp',
        'assets/images/visiostellar/visiostellar_screenshots_5.webp',
        'assets/images/visiostellar/visiostellar_screenshots_7.webp',
        'assets/images/visiostellar/visiostellar_screenshots_6.webp',
        'assets/images/visiostellar/visiostellar_screenshots_2.webp',
      ],
      states: [
        ProjectState(label: 'Early Project', color: Colors.purple),
      ],
    );
  }
}
