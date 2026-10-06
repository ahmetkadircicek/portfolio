import 'package:flutter/material.dart';
import 'package:portfolio/features/home/model/card_model.dart';
import 'package:portfolio/core/base/view/project_base_widget.dart';

class TunesView extends StatelessWidget {
  const TunesView({super.key});

  @override
  Widget build(BuildContext context) {
    const project = CardModel(
      title: 'TUNES.AI',
      subtitle: 'AI-Driven Music Platform',
      description:
          'A revolutionary music platform powered by AI that I developed from scratch using Flutter and Firebase',
      imagePath: 'assets/images/tunes/tunes_logo.webp',
      category: 'Music',
      firstColor: Color(0xFFFE6C11),
      secondColor: Color(0xFFC63B08),
    );

    const features = [
      CardModel(
        title: 'Personalized',
        subtitle: 'AI-Powered Creation',
        description:
            "Tunes.AI creates a personalized musical experience with AI-generated songs tailored to your unique preferences and mood.",
        imagePath: 'assets/images/tunes/image_mockup_tunes_01.webp',
        category: 'AI-Powered Creation',
        firstColor: Color(0xFFFE6C11),
        secondColor: Color(0xFFC63B08),
      ),
      CardModel(
        title: 'High Performance',
        subtitle: 'Optimized Playback',
        description:
            "Experience uninterrupted music with our Flutter-built platform featuring advanced AudioManager and lightning-fast streaming capabilities.",
        imagePath: 'assets/images/tunes/image_mockup_tunes_02.webp',
        category: 'Optimized Playback',
        firstColor: Colors.white,
        secondColor: Color(0xFFFAFAFA),
      ),
      CardModel(
        title: 'Cloud-Integrated',
        subtitle: 'Smart Storage',
        description:
            "Tunes.AI leverages Firebase for reliable cloud storage and implements efficient caching systems for instant access to your favorite tracks.",
        imagePath: 'assets/images/tunes/image_mockup_tunes_03.webp',
        category: 'Smart Storage',
        firstColor: Colors.white,
        secondColor: Color(0xFFFAFAFA),
      ),
      CardModel(
        title: 'User-Friendly',
        subtitle: 'Modern Interface',
        description:
            "Our minimalist design philosophy creates an intuitive experience that adapts to your listening habits while maintaining elegant simplicity.",
        imagePath: 'assets/images/tunes/image_mockup_tunes_04.webp',
        category: 'Modern Interface',
        firstColor: Colors.white,
        secondColor: Color(0xFFFAFAFA),
      ),
    ];

    return const ProjectBaseView(
      project: project,
      features: features,
    );
  }
}
