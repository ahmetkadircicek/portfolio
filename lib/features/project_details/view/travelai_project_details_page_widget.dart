import 'package:flutter/material.dart';
import 'package:portfolio/core/base/view/project_details_base_widget.dart';

class TravelAIProjectDetailsView extends StatelessWidget {
  const TravelAIProjectDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProjectDetailsBaseWidget(
      title: 'TravelAI — Smart Travel Companion',
      description:
          'TravelAI is a social travel platform I developed to enhance my Swift skills while exploring various OAuth implementations. The application creates a community where travelers can share their secret routes, hidden gems, and personalized experiences with others. Users can discover new activities, create and save interactive itineraries, and exchange travel insights through an intuitive social interface. The platform leverages AI to generate tailored recommendations based on user preferences and destinations. This project served as an excellent opportunity to deepen my understanding of social platform development, authentication systems, and creating engaging user experiences while helping travelers connect and enhance their journeys through shared knowledge.',
      iconPath: 'assets/images/travelai/travelai_logo.png',
      technologyTags: [
        'Swift',
        'UIKit',
        'Lottie',
        'Alamofire',
        'Google Gemini AI',
        'Firebase',
        'Social Sharing',
        'OAuth',
      ],
      screenshotPaths: [
        'assets/images/travelai/travelai_screenshots_5.png',
        'assets/images/travelai/travelai_screenshots_7.png',
        'assets/images/travelai/travelai_screenshots_2.png',
        'assets/images/travelai/travelai_screenshots_4.png',
        'assets/images/travelai/travelai_screenshots_1.png',
        'assets/images/travelai/travelai_screenshots_3.png',
        'assets/images/travelai/travelai_screenshots_6.png',
      ],
      states: [
        ProjectState(label: 'Under Early Development', color: Colors.blue),
      ],
    );
  }
}
