import 'package:flutter/material.dart';
import 'package:portfolio/features/home/model/card_model.dart';
import 'package:portfolio/core/base/view/project_base_widget.dart';

class VilsaView extends StatelessWidget {
  const VilsaView({super.key});

  @override
  Widget build(BuildContext context) {
    const project = CardModel(
      title: 'VILSA',
      subtitle: 'Stock Market Portfolio Tracker',
      description:
          'A comprehensive stock market portfolio tracking application that I developed using Flutter with customizable market selection and dividend tracking',
      imagePath: 'assets/images/vilsa/vilsa_logo.jpg',
      category: 'Finance',
      firstColor: Color(0xFF1E88E5),
      secondColor: Color(0xFF0D47A1),
    );

    const features = [
      CardModel(
        title: 'Customizable Markets',
        subtitle: 'Add Markets On Demand',
        description:
            "VILSA allows you to add and track stocks from different markets according to your preferences, giving you complete control over which exchanges you want to monitor.",
        imagePath: 'assets/images/vilsa/image_mockup_vilsa_01.png',
        category: 'Market Customization',
        firstColor: Color(0xFF5908FA),
        secondColor: Color(0xFF9829E9),
      ),
      CardModel(
        title: 'Dividend Tracking',
        subtitle: 'Comprehensive Dividend Management',
        description:
            "Keep track of all your dividend payments with detailed records of past dividends and projections for future payments to optimize your income strategy.",
        imagePath: 'assets/images/vilsa/image_mockup_vilsa_02.png',
        category: 'Dividend Management',
        firstColor: Colors.white,
        secondColor: Color(0xFFFAFAFA),
      ),
      CardModel(
        title: 'Periodic Analysis',
        subtitle: 'Scheduled Portfolio Reviews',
        description:
            "Set up regular analysis intervals to evaluate your portfolio performance, with customizable timeframes for daily, weekly, monthly, or quarterly assessments.",
        imagePath: 'assets/images/vilsa/image_mockup_vilsa_03.png',
        category: 'Scheduled Analysis',
        firstColor: Colors.white,
        secondColor: Color(0xFFFAFAFA),
      ),
      CardModel(
        title: 'Customizable Interface',
        subtitle: 'Personalized Experience',
        description:
            "Create your ideal investment dashboard with customizable widgets, watchlists, and alerts to monitor exactly what matters to your investment strategy.",
        imagePath: 'assets/images/vilsa/image_mockup_vilsa_04.png',
        category: 'Personalized Experience',
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
