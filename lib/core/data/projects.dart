import 'package:flutter/painting.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Every project on the site, in page order. The home page, the project
/// pages and the router all read from this list.
class Project {
  /// Route segment: `/projects/<slug>`.
  final String slug;
  final String name;
  final String subtitle;

  /// One or two sentences for the home page.
  final String summary;

  /// Full text of the project page.
  final String overview;
  final String category;
  final String logo;
  final List<String> technologies;
  final List<String> screenshots;
  final List<ProjectStatus> statuses;
  final String? repositoryUrl;

  /// Highlights shown as image cards on the home page. Only featured
  /// projects have them.
  final List<ProjectFeature> features;

  const Project({
    required this.slug,
    required this.name,
    required this.subtitle,
    required this.summary,
    required this.overview,
    required this.category,
    required this.logo,
    required this.technologies,
    required this.screenshots,
    required this.statuses,
    this.repositoryUrl,
    this.features = const [],
  });

  bool get isFeatured => features.isNotEmpty;

  /// Main framework or language, e.g. `Flutter`.
  String get builtWith => technologies.first;
}

class ProjectFeature {
  final String title;
  final String description;
  final String label;
  final String image;
  final List<Color> colors;

  const ProjectFeature({
    required this.title,
    required this.description,
    required this.label,
    required this.image,
    this.colors = AppColors.cardLight,
  });
}

enum ProjectStatus {
  readyToRelease('Ready to Release', AppColors.statusReady),
  underDevelopment('Under Development', AppColors.statusProgress),
  earlyDevelopment('Under Early Development', AppColors.statusEarly),
  earlyProject('Early Project', AppColors.statusArchive);

  final String label;
  final Color color;
  const ProjectStatus(this.label, this.color);
}

class Projects {
  Projects._();

  static Project? bySlug(String? slug) {
    for (final project in all) {
      if (project.slug == slug) return project;
    }
    return null;
  }

  static List<Project> get featured => all.where((p) => p.isFeatured).toList();
  static List<Project> get others => all.where((p) => !p.isFeatured).toList();

  static const all = [
    Project(
      slug: 'tunes',
      name: 'Tunes.AI',
      subtitle: 'AI-Driven Music Platform',
      summary: 'A revolutionary music platform powered by AI that I developed from scratch using Flutter and Firebase.',
      overview:
          'Tunes.AI is a revolutionary music platform powered by AI that I developed from scratch using Flutter and Firebase. This app streamlines the music discovery process by intelligently creating custom playlists based on your listening patterns. The project journey included 3 weeks of market research, 2 weeks of focused UI/UX design, 5 weeks of Flutter + Firebase MVP coding, 2 weeks of feature expansion and polish, 2 weeks of testing & debugging, and 1 week of performance tuning and release prep. I also implemented Google AdMob for monetization, learning valuable lessons about app revenues. This project highlights my ability to take an idea from concept to market as a full-stack app developer.',
      category: 'Music',
      logo: 'assets/images/tunes/tunes_logo.webp',
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'Provider',
        'MVVM',
        'Figma',
        'Replicate',
        'REST API',
        'Google AdMob'
      ],
      screenshots: [
        'assets/images/tunes/tunes_screenshots_1.webp',
        'assets/images/tunes/tunes_screenshots_8.webp',
        'assets/images/tunes/tunes_screenshots_2.webp',
        'assets/images/tunes/tunes_screenshots_3.webp',
        'assets/images/tunes/tunes_screenshots_4.webp',
        'assets/images/tunes/tunes_screenshots_5.webp',
        'assets/images/tunes/tunes_screenshots_6.webp',
      ],
      statuses: [ProjectStatus.readyToRelease],
      features: [
        ProjectFeature(
          title: 'Personalized',
          description:
              'Tunes.AI creates a personalized musical experience with AI-generated songs tailored to your unique preferences and mood.',
          label: 'AI-Powered Creation',
          image: 'assets/images/tunes/image_mockup_tunes_01.webp',
          colors: [Color(0xFFFE6C11), Color(0xFFC63B08)],
        ),
        ProjectFeature(
          title: 'High Performance',
          description:
              'Experience uninterrupted music with our Flutter-built platform featuring advanced AudioManager and lightning-fast streaming capabilities.',
          label: 'Optimized Playback',
          image: 'assets/images/tunes/image_mockup_tunes_02.webp',
        ),
        ProjectFeature(
          title: 'Cloud-Integrated',
          description:
              'Tunes.AI leverages Firebase for reliable cloud storage and implements efficient caching systems for instant access to your favorite tracks.',
          label: 'Smart Storage',
          image: 'assets/images/tunes/image_mockup_tunes_03.webp',
        ),
        ProjectFeature(
          title: 'User-Friendly',
          description:
              'Our minimalist design philosophy creates an intuitive experience that adapts to your listening habits while maintaining elegant simplicity.',
          label: 'Modern Interface',
          image: 'assets/images/tunes/image_mockup_tunes_04.webp',
        ),
      ],
    ),
    Project(
      slug: 'vilsa',
      name: 'Vilsa',
      subtitle: 'Stock Market Portfolio Tracker',
      summary:
          'A comprehensive stock market portfolio tracking application that I developed using Flutter with customizable market selection and dividend tracking.',
      // The old project page described an e-commerce app; the home page
      // texts and the screenshots show the portfolio tracker, so the page
      // uses those.
      overview:
          'Vilsa is a comprehensive stock market portfolio tracking application that I developed using Flutter with customizable market selection and dividend tracking. It allows you to add and track stocks from different markets according to your preferences, giving you complete control over which exchanges you want to monitor. You can keep track of all your dividend payments with detailed records of past dividends and projections for future payments, set up regular analysis intervals with daily, weekly, monthly or quarterly timeframes, and build your ideal investment dashboard with customizable widgets, watchlists and alerts.',
      category: 'Finance',
      logo: 'assets/images/vilsa/vilsa_logo.webp',
      technologies: ['Flutter', 'Dart', 'Firebase', 'Provider', 'MVVM', 'Figma', 'Charts'],
      screenshots: [
        'assets/images/vilsa/vilsa_screenshots_1.webp',
        'assets/images/vilsa/vilsa_screenshots_2.webp',
        'assets/images/vilsa/vilsa_screenshots_3.webp',
        'assets/images/vilsa/vilsa_screenshots_4.webp',
        'assets/images/vilsa/vilsa_screenshots_5.webp',
        'assets/images/vilsa/vilsa_screenshots_6.webp',
        'assets/images/vilsa/vilsa_screenshots_7.webp',
      ],
      statuses: [ProjectStatus.readyToRelease],
      repositoryUrl: 'https://github.com/ahmetkadircicek/vilsa',
      features: [
        ProjectFeature(
          title: 'Customizable Markets',
          description:
              'VILSA allows you to add and track stocks from different markets according to your preferences, giving you complete control over which exchanges you want to monitor.',
          label: 'Market Customization',
          image: 'assets/images/vilsa/image_mockup_vilsa_01.webp',
          colors: [Color(0xFF5908FA), Color(0xFF9829E9)],
        ),
        ProjectFeature(
          title: 'Dividend Tracking',
          description:
              'Keep track of all your dividend payments with detailed records of past dividends and projections for future payments to optimize your income strategy.',
          label: 'Dividend Management',
          image: 'assets/images/vilsa/image_mockup_vilsa_02.webp',
        ),
        ProjectFeature(
          title: 'Periodic Analysis',
          description:
              'Set up regular analysis intervals to evaluate your portfolio performance, with customizable timeframes for daily, weekly, monthly, or quarterly assessments.',
          label: 'Scheduled Analysis',
          image: 'assets/images/vilsa/image_mockup_vilsa_03.webp',
        ),
        ProjectFeature(
          title: 'Customizable Interface',
          description:
              'Create your ideal investment dashboard with customizable widgets, watchlists, and alerts to monitor exactly what matters to your investment strategy.',
          label: 'Personalized Experience',
          image: 'assets/images/vilsa/image_mockup_vilsa_04.webp',
        ),
      ],
    ),
    Project(
      slug: 'sevkiyatvar',
      name: 'Sevkiyatvar',
      subtitle: 'Logistics Management Platform',
      summary:
          'An existing logistics platform that I helped enhance and optimize for better shipping and logistics management.',
      overview:
          'Sevkiyatvar is a large-scale app modernization project I led for a logistics company, redesigning and rebuilding their existing system using Flutter. The project was initiated to address user feedback about the outdated interface and functionality of an earlier version. I implemented a cleaner, more intuitive UI/UX flow while maintaining the core business logic that users were familiar with. By decomposing the legacy code into reusable Flutter components and implementing state management with Provider, I was able to create a platform that significantly improved both driver and dispatcher user experiences. I focused on enhancing user experience while maintaining the core functionality that made the original app valuable to its users. This project demonstrates my ability to take established solutions and elevate them with modern development practices.',
      category: 'Logistics',
      logo: 'assets/images/sevkiyatvar/sevkiyatvar_logo.webp',
      technologies: ['Flutter', 'Dart', 'MVVM', 'REST API', 'Connectivity', 'Provider'],
      screenshots: [
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_1.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_2.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_3.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_4.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_5.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_6.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_7.webp',
      ],
      statuses: [ProjectStatus.readyToRelease],
      features: [
        ProjectFeature(
          title: 'User-Friendly Interface',
          description:
              'I redesigned the Sevkiyatvar application to create a more intuitive and user-friendly interface. I improved the user experience by simplifying complex logistics processes.',
          label: 'Modern Design',
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_01.webp',
          colors: [Color(0xFF677685), Color(0xFF495459)],
        ),
        ProjectFeature(
          title: 'Real-Time Tracking',
          description:
              'By adding real-time tracking functionality for shipping processes, I enabled users to track their cargo instantly. I implemented GPS integration to enable route optimization.',
          label: 'Instant Monitoring',
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_02.webp',
        ),
        ProjectFeature(
          title: 'Advanced Reporting',
          description:
              'I enhanced measurement and reporting capabilities for shipping performance by adding comprehensive analytical tools. Users can now access detailed statistics and customizable reports.',
          label: 'Data Analysis',
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_03.webp',
        ),
        ProjectFeature(
          title: 'Android & iOS Support',
          description:
              'I developed the application to work flawlessly on both Android and iOS platforms, ensuring compatibility with the latest device models. Users can access their logistics data seamlessly across both operating systems with real-time synchronization.',
          label: 'Mobile Platforms',
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_04.webp',
        ),
      ],
    ),
    Project(
      slug: 'travelai',
      name: 'TravelAI',
      subtitle: 'Smart Travel Companion',
      summary:
          'A social travel platform where travelers share secret routes and hidden gems, with AI-generated recommendations.',
      overview:
          'TravelAI is a social travel platform I developed to enhance my Swift skills while exploring various OAuth implementations. The application creates a community where travelers can share their secret routes, hidden gems, and personalized experiences with others. Users can discover new activities, create and save interactive itineraries, and exchange travel insights through an intuitive social interface. The platform leverages AI to generate tailored recommendations based on user preferences and destinations. This project served as an excellent opportunity to deepen my understanding of social platform development, authentication systems, and creating engaging user experiences while helping travelers connect and enhance their journeys through shared knowledge.',
      category: 'Travel',
      logo: 'assets/images/travelai/travelai_logo.webp',
      technologies: [
        'Swift',
        'UIKit',
        'Lottie',
        'Alamofire',
        'Google Gemini AI',
        'Firebase',
        'Social Sharing',
        'OAuth'
      ],
      screenshots: [
        'assets/images/travelai/travelai_screenshots_5.webp',
        'assets/images/travelai/travelai_screenshots_7.webp',
        'assets/images/travelai/travelai_screenshots_2.webp',
        'assets/images/travelai/travelai_screenshots_4.webp',
        'assets/images/travelai/travelai_screenshots_1.webp',
        'assets/images/travelai/travelai_screenshots_3.webp',
        'assets/images/travelai/travelai_screenshots_6.webp',
      ],
      statuses: [ProjectStatus.earlyDevelopment],
    ),
    Project(
      slug: 'visiostellar',
      name: 'Visiostellar',
      subtitle: 'iOS Astronomy App',
      summary: 'My first iOS app: astronomical information, celestial object tracking and space education in Swift.',
      overview:
          'Visiostellar is an iOS astronomy application I built when I first started my mobile development career. Developed entirely in Swift with UIKit, this app was my introduction to iOS development fundamentals. I implemented the user interface using Storyboard and Auto Layout constraints to create a responsive design across different iOS devices. The app provides users with astronomical information, celestial object tracking, and educational content about space. This project helped me gain valuable experience with Swift programming patterns, iOS navigation systems, and Apple\'s design guidelines.',
      category: 'Education',
      logo: 'assets/images/visiostellar/visiostellar_logo.webp',
      technologies: ['Swift', 'UIKit', 'Storyboard', 'Auto Layout', 'iOS', 'Xcode', 'MVC'],
      screenshots: [
        'assets/images/visiostellar/visiostellar_screenshots_1.webp',
        'assets/images/visiostellar/visiostellar_screenshots_4.webp',
        'assets/images/visiostellar/visiostellar_screenshots_3.webp',
        'assets/images/visiostellar/visiostellar_screenshots_5.webp',
        'assets/images/visiostellar/visiostellar_screenshots_7.webp',
        'assets/images/visiostellar/visiostellar_screenshots_6.webp',
        'assets/images/visiostellar/visiostellar_screenshots_2.webp',
      ],
      statuses: [ProjectStatus.earlyProject],
    ),
    Project(
      slug: 'peasy',
      name: 'Peasy',
      subtitle: 'Self-Checkout App',
      summary: 'A self-checkout app using NFC, built as a graduation project with a team of four.',
      overview:
          'Peasy is a mobile application developed as part of my graduation project with a team of 4 members. The app solves customer queue waiting problems by enabling self-checkout through NFC technology. Users can simply scan products with their phones and complete their purchases without waiting in line. The system includes a sophisticated backend service that recommends similar products based on the customer\'s purchase history and current selections. This project allowed me to gain experience in collaborative development, NFC integration, and recommendation systems while creating a practical solution for retail environments.',
      category: 'Retail',
      logo: 'assets/images/peasy/peasy_logo.webp',
      technologies: ['Flutter', 'Dart', 'NFC', 'Firebase', 'REST API', 'Recommendation Systems', 'Team Collaboration'],
      screenshots: [
        'assets/images/peasy/peasy_screenshots_1.webp',
        'assets/images/peasy/peasy_screenshots_6.webp',
        'assets/images/peasy/peasy_screenshots_7.webp',
        'assets/images/peasy/peasy_screenshots_2.webp',
        'assets/images/peasy/peasy_screenshots_3.webp',
        'assets/images/peasy/peasy_screenshots_4.webp',
        'assets/images/peasy/peasy_screenshots_5.webp',
      ],
      statuses: [ProjectStatus.underDevelopment],
      repositoryUrl: 'https://github.com/ahmetkadircicek/peasy',
    ),
  ];
}
