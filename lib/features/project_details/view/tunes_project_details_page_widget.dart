import 'package:flutter/material.dart';
import 'package:portfolio/core/base/view/project_details_base_widget.dart';

class TunesProjectDetailsView extends StatelessWidget {
  const TunesProjectDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProjectDetailsBaseWidget(
      title: 'Tunes.AI — AI Powered Music Platform',
      description:
          'Tunes.AI is a revolutionary music platform powered by AI that I developed from scratch using Flutter and Firebase. This app streamlines the music discovery process by intelligently creating custom playlists based on your listening patterns. The project journey included 3 weeks of market research, 2 weeks of focused UI/UX design, 5 weeks of Flutter + Firebase MVP coding, 2 weeks of feature expansion and polish, 2 weeks of testing & debugging, and 1 week of performance tuning and release prep. I also implemented Google AdMob for monetization, learning valuable lessons about app revenues. This project highlights my ability to take an idea from concept to market as a full-stack app developer.',
      iconPath: 'assets/images/tunes/tunes_logo.jpg',
      technologyTags: [
        'Flutter',
        'Dart',
        'Firebase',
        'Provider',
        'MVVM',
        'Figma',
        'Replicate',
        'REST API',
        'Google AdMob',
      ],
      screenshotPaths: [
        'assets/images/tunes/tunes_screenshots_1.png',
        'assets/images/tunes/tunes_screenshots_8.png',
        'assets/images/tunes/tunes_screenshots_2.png',
        'assets/images/tunes/tunes_screenshots_3.png',
        'assets/images/tunes/tunes_screenshots_4.png',
        'assets/images/tunes/tunes_screenshots_5.png',
        'assets/images/tunes/tunes_screenshots_6.png',
      ],
      states: [
        ProjectState(label: 'Ready to Release', color: Colors.green),
      ],
    );
  }
}
