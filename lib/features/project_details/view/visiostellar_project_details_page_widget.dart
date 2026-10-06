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
      iconPath: 'assets/images/visiostellar/visiostellar_logo.jpeg',
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
        'assets/images/visiostellar/visiostellar_screenshots_1.png',
        'assets/images/visiostellar/visiostellar_screenshots_4.png',
        'assets/images/visiostellar/visiostellar_screenshots_3.png',
        'assets/images/visiostellar/visiostellar_screenshots_5.png',
        'assets/images/visiostellar/visiostellar_screenshots_7.png',
        'assets/images/visiostellar/visiostellar_screenshots_6.png',
        'assets/images/visiostellar/visiostellar_screenshots_2.png',
      ],
      states: [
        ProjectState(label: 'Early Project', color: Colors.purple),
      ],
    );
  }
}
