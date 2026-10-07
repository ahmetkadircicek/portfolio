import 'package:flutter/painting.dart';
import 'package:portfolio/core/data/entry.dart';

/// Every project on the site, in page order. Adding an entry here adds its
/// row on the home page and its page at `/projects/<slug>`.
const projects = Collection(
  id: 'projects',
  title: 'Projects',
  collapsedOnPhones: true,
  entries: [
    Entry(
      slug: 'tunes',
      title: 'Tunes.AI',
      subtitle: 'AI-Driven Music Platform',
      summary: 'A revolutionary music platform powered by AI that I developed from scratch using Flutter and Firebase.',
      overview:
          'Tunes.AI is a revolutionary music platform powered by AI that I developed from scratch using Flutter and Firebase. This app streamlines the music discovery process by intelligently creating custom playlists based on your listening patterns. The project journey included 3 weeks of market research, 2 weeks of focused UI/UX design, 5 weeks of Flutter + Firebase MVP coding, 2 weeks of feature expansion and polish, 2 weeks of testing & debugging, and 1 week of performance tuning and release prep. I also implemented Google AdMob for monetization, learning valuable lessons about app revenues. This project highlights my ability to take an idea from concept to market as a full-stack app developer.',
      label: 'Music',
      logo: 'assets/images/tunes/tunes_logo.webp',
      tags: ['Flutter', 'Dart', 'Firebase', 'Provider', 'MVVM', 'Figma', 'Replicate', 'REST API', 'Google AdMob'],
      statuses: [EntryStatus.readyToRelease],
      screenshots: [
        'assets/images/tunes/tunes_screenshots_1.webp',
        'assets/images/tunes/tunes_screenshots_8.webp',
        'assets/images/tunes/tunes_screenshots_2.webp',
        'assets/images/tunes/tunes_screenshots_3.webp',
        'assets/images/tunes/tunes_screenshots_4.webp',
        'assets/images/tunes/tunes_screenshots_5.webp',
        'assets/images/tunes/tunes_screenshots_6.webp',
      ],
      highlights: [
        Highlight(
          title: 'Personalized',
          description:
              'Tunes.AI creates a personalized musical experience with AI-generated songs tailored to your unique preferences and mood.',
          label: 'AI-Powered Creation',
          image: 'assets/images/tunes/image_mockup_tunes_01.webp',
          colors: [Color(0xFFFE6C11), Color(0xFFC63B08)],
        ),
        Highlight(
          title: 'High Performance',
          description:
              'Experience uninterrupted music with our Flutter-built platform featuring advanced AudioManager and lightning-fast streaming capabilities.',
          label: 'Optimized Playback',
          image: 'assets/images/tunes/image_mockup_tunes_02.webp',
        ),
        Highlight(
          title: 'Cloud-Integrated',
          description:
              'Tunes.AI leverages Firebase for reliable cloud storage and implements efficient caching systems for instant access to your favorite tracks.',
          label: 'Smart Storage',
          image: 'assets/images/tunes/image_mockup_tunes_03.webp',
        ),
        Highlight(
          title: 'User-Friendly',
          description:
              'Our minimalist design philosophy creates an intuitive experience that adapts to your listening habits while maintaining elegant simplicity.',
          label: 'Modern Interface',
          image: 'assets/images/tunes/image_mockup_tunes_04.webp',
        ),
      ],
    ),
    Entry(
      slug: 'vilsa',
      title: 'Vilsa',
      subtitle: 'Stock Market Portfolio Tracker',
      summary:
          'A comprehensive stock market portfolio tracking application that I developed using Flutter with customizable market selection and dividend tracking.',
      // The old project page described an e-commerce app; the home page
      // texts and the screenshots show the portfolio tracker, so the page
      // uses those.
      overview:
          'Vilsa is a comprehensive stock market portfolio tracking application that I developed using Flutter with customizable market selection and dividend tracking. It allows you to add and track stocks from different markets according to your preferences, giving you complete control over which exchanges you want to monitor. You can keep track of all your dividend payments with detailed records of past dividends and projections for future payments, set up regular analysis intervals with daily, weekly, monthly or quarterly timeframes, and build your ideal investment dashboard with customizable widgets, watchlists and alerts.',
      label: 'Finance',
      logo: 'assets/images/vilsa/vilsa_logo.webp',
      tags: ['Flutter', 'Dart', 'Firebase', 'Provider', 'MVVM', 'Figma', 'Charts'],
      statuses: [EntryStatus.readyToRelease],
      link: EntryLink.github('https://github.com/ahmetkadircicek/vilsa'),
      screenshots: [
        'assets/images/vilsa/vilsa_screenshots_1.webp',
        'assets/images/vilsa/vilsa_screenshots_2.webp',
        'assets/images/vilsa/vilsa_screenshots_3.webp',
        'assets/images/vilsa/vilsa_screenshots_4.webp',
        'assets/images/vilsa/vilsa_screenshots_5.webp',
        'assets/images/vilsa/vilsa_screenshots_6.webp',
        'assets/images/vilsa/vilsa_screenshots_7.webp',
      ],
      highlights: [
        Highlight(
          title: 'Customizable Markets',
          description:
              'VILSA allows you to add and track stocks from different markets according to your preferences, giving you complete control over which exchanges you want to monitor.',
          label: 'Market Customization',
          image: 'assets/images/vilsa/image_mockup_vilsa_01.webp',
          colors: [Color(0xFF5908FA), Color(0xFF9829E9)],
        ),
        Highlight(
          title: 'Dividend Tracking',
          description:
              'Keep track of all your dividend payments with detailed records of past dividends and projections for future payments to optimize your income strategy.',
          label: 'Dividend Management',
          image: 'assets/images/vilsa/image_mockup_vilsa_02.webp',
        ),
        Highlight(
          title: 'Periodic Analysis',
          description:
              'Set up regular analysis intervals to evaluate your portfolio performance, with customizable timeframes for daily, weekly, monthly, or quarterly assessments.',
          label: 'Scheduled Analysis',
          image: 'assets/images/vilsa/image_mockup_vilsa_03.webp',
        ),
        Highlight(
          title: 'Customizable Interface',
          description:
              'Create your ideal investment dashboard with customizable widgets, watchlists, and alerts to monitor exactly what matters to your investment strategy.',
          label: 'Personalized Experience',
          image: 'assets/images/vilsa/image_mockup_vilsa_04.webp',
        ),
      ],
    ),
    Entry(
      slug: 'sevkiyatvar',
      title: 'Sevkiyatvar',
      subtitle: 'Logistics Management Platform',
      summary:
          'An existing logistics platform that I helped enhance and optimize for better shipping and logistics management.',
      overview:
          'Sevkiyatvar is a large-scale app modernization project I led for a logistics company, redesigning and rebuilding their existing system using Flutter. The project was initiated to address user feedback about the outdated interface and functionality of an earlier version. I implemented a cleaner, more intuitive UI/UX flow while maintaining the core business logic that users were familiar with. By decomposing the legacy code into reusable Flutter components and implementing state management with Provider, I was able to create a platform that significantly improved both driver and dispatcher user experiences. I focused on enhancing user experience while maintaining the core functionality that made the original app valuable to its users. This project demonstrates my ability to take established solutions and elevate them with modern development practices.',
      label: 'Logistics',
      logo: 'assets/images/sevkiyatvar/sevkiyatvar_logo.webp',
      tags: ['Flutter', 'Dart', 'MVVM', 'REST API', 'Connectivity', 'Provider'],
      statuses: [EntryStatus.readyToRelease],
      screenshots: [
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_1.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_2.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_3.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_4.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_5.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_6.webp',
        'assets/images/sevkiyatvar/sevkiyatvar_screenshots_7.webp',
      ],
      highlights: [
        Highlight(
          title: 'User-Friendly Interface',
          description:
              'I redesigned the Sevkiyatvar application to create a more intuitive and user-friendly interface. I improved the user experience by simplifying complex logistics processes.',
          label: 'Modern Design',
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_01.webp',
          colors: [Color(0xFF677685), Color(0xFF495459)],
        ),
        Highlight(
          title: 'Real-Time Tracking',
          description:
              'By adding real-time tracking functionality for shipping processes, I enabled users to track their cargo instantly. I implemented GPS integration to enable route optimization.',
          label: 'Instant Monitoring',
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_02.webp',
        ),
        Highlight(
          title: 'Advanced Reporting',
          description:
              'I enhanced measurement and reporting capabilities for shipping performance by adding comprehensive analytical tools. Users can now access detailed statistics and customizable reports.',
          label: 'Data Analysis',
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_03.webp',
        ),
        Highlight(
          title: 'Android & iOS Support',
          description:
              'I developed the application to work flawlessly on both Android and iOS platforms, ensuring compatibility with the latest device models. Users can access their logistics data seamlessly across both operating systems with real-time synchronization.',
          label: 'Mobile Platforms',
          image: 'assets/images/sevkiyatvar/image_mockup_sevkiyatvar_04.webp',
        ),
      ],
    ),
    Entry(
      slug: 'travelai',
      title: 'TravelAI',
      subtitle: 'Smart Travel Companion',
      summary:
          'A social travel platform where travelers share secret routes and hidden gems, with AI-generated recommendations.',
      overview:
          'TravelAI is a social travel platform I developed to enhance my Swift skills while exploring various OAuth implementations. The application creates a community where travelers can share their secret routes, hidden gems, and personalized experiences with others. Users can discover new activities, create and save interactive itineraries, and exchange travel insights through an intuitive social interface. The platform leverages AI to generate tailored recommendations based on user preferences and destinations. This project served as an excellent opportunity to deepen my understanding of social platform development, authentication systems, and creating engaging user experiences while helping travelers connect and enhance their journeys through shared knowledge.',
      label: 'Travel',
      logo: 'assets/images/travelai/travelai_logo.webp',
      tags: ['Swift', 'UIKit', 'Lottie', 'Alamofire', 'Google Gemini AI', 'Firebase', 'Social Sharing', 'OAuth'],
      screenshots: [
        'assets/images/travelai/travelai_screenshots_5.webp',
        'assets/images/travelai/travelai_screenshots_7.webp',
        'assets/images/travelai/travelai_screenshots_2.webp',
        'assets/images/travelai/travelai_screenshots_4.webp',
        'assets/images/travelai/travelai_screenshots_1.webp',
        'assets/images/travelai/travelai_screenshots_3.webp',
        'assets/images/travelai/travelai_screenshots_6.webp',
      ],
      highlights: [
        Highlight(
          title: 'One-Tap Login',
          description:
              'Sign in with Apple, Microsoft, Google or Facebook, the OAuth flows this project was built to explore.',
          label: 'Social Sign-In',
          image: 'assets/images/travelai/travelai_screenshots_2.webp',
          colors: [Color(0xFF16C964), Color(0xFF00994A)],
        ),
        Highlight(
          title: 'Create Your Trip',
          description: 'Pick a country and a city on the globe and TravelAI builds a trip around them.',
          label: 'Trip Planner',
          image: 'assets/images/travelai/travelai_screenshots_3.webp',
        ),
        Highlight(
          title: 'Places to See',
          description: 'Gemini AI suggests the places to see at each destination as a checklist to save and tick off.',
          label: 'AI Itineraries',
          image: 'assets/images/travelai/travelai_screenshots_6.webp',
        ),
        Highlight(
          title: 'Shared Routes',
          description: 'Browse the trips other travelers saved and filter them by continent.',
          label: 'Discover',
          image: 'assets/images/travelai/travelai_screenshots_4.webp',
        ),
      ],
      statuses: [EntryStatus.earlyDevelopment],
    ),
    Entry(
      slug: 'visiostellar',
      title: 'Visiostellar',
      subtitle: 'iOS Astronomy App',
      summary: 'My first iOS app: astronomical information, celestial object tracking and space education in Swift.',
      overview:
          'Visiostellar is an iOS astronomy application I built when I first started my mobile development career. Developed entirely in Swift with UIKit, this app was my introduction to iOS development fundamentals. I implemented the user interface using Storyboard and Auto Layout constraints to create a responsive design across different iOS devices. The app provides users with astronomical information, celestial object tracking, and educational content about space. This project helped me gain valuable experience with Swift programming patterns, iOS navigation systems, and Apple\'s design guidelines.',
      label: 'Education',
      logo: 'assets/images/visiostellar/visiostellar_logo.webp',
      tags: ['Swift', 'UIKit', 'Storyboard', 'Auto Layout', 'iOS', 'Xcode', 'MVC'],
      screenshots: [
        'assets/images/visiostellar/visiostellar_screenshots_1.webp',
        'assets/images/visiostellar/visiostellar_screenshots_4.webp',
        'assets/images/visiostellar/visiostellar_screenshots_3.webp',
        'assets/images/visiostellar/visiostellar_screenshots_5.webp',
        'assets/images/visiostellar/visiostellar_screenshots_7.webp',
        'assets/images/visiostellar/visiostellar_screenshots_6.webp',
        'assets/images/visiostellar/visiostellar_screenshots_2.webp',
      ],
      highlights: [
        Highlight(
          title: 'NASA Feed',
          description: 'The latest NASA stories with images and short summaries, right on the home screen.',
          label: 'Space News',
          image: 'assets/images/visiostellar/visiostellar_screenshots_3.webp',
          colors: [Color(0xFF2A3157), Color(0xFF0E1226)],
        ),
        Highlight(
          title: 'Explore Topics',
          description: 'Browse the archive by topic, from rover discoveries to launches and the ISS.',
          label: 'Search',
          image: 'assets/images/visiostellar/visiostellar_screenshots_5.webp',
        ),
        Highlight(
          title: 'Read in Depth',
          description: 'Each story opens to a longer summary with a link to the full article on nasa.gov.',
          label: 'Article Detail',
          image: 'assets/images/visiostellar/visiostellar_screenshots_6.webp',
        ),
        Highlight(
          title: 'Find a Mission',
          description: 'Results update as you type, for example every SpaceX resupply mission.',
          label: 'Live Search',
          image: 'assets/images/visiostellar/visiostellar_screenshots_4.webp',
        ),
      ],
      statuses: [EntryStatus.earlyProject],
    ),
    Entry(
      slug: 'peasy',
      title: 'Peasy',
      subtitle: 'Self-Checkout App',
      summary: 'A self-checkout app using NFC, built as a graduation project with a team of four.',
      overview:
          'Peasy is a mobile application developed as part of my graduation project with a team of 4 members. The app solves customer queue waiting problems by enabling self-checkout through NFC technology. Users can simply scan products with their phones and complete their purchases without waiting in line. The system includes a sophisticated backend service that recommends similar products based on the customer\'s purchase history and current selections. This project allowed me to gain experience in collaborative development, NFC integration, and recommendation systems while creating a practical solution for retail environments.',
      label: 'Retail',
      logo: 'assets/images/peasy/peasy_logo.webp',
      tags: ['Flutter', 'Dart', 'NFC', 'Firebase', 'REST API', 'Recommendation Systems', 'Team Collaboration'],
      screenshots: [
        'assets/images/peasy/peasy_screenshots_1.webp',
        'assets/images/peasy/peasy_screenshots_6.webp',
        'assets/images/peasy/peasy_screenshots_7.webp',
        'assets/images/peasy/peasy_screenshots_2.webp',
        'assets/images/peasy/peasy_screenshots_3.webp',
        'assets/images/peasy/peasy_screenshots_4.webp',
        'assets/images/peasy/peasy_screenshots_5.webp',
      ],
      highlights: [
        Highlight(
          title: 'Tap to Scan',
          description: 'Hold the phone near a product\'s NFC tag to add it to the cart.',
          label: 'NFC Checkout',
          image: 'assets/images/peasy/peasy_screenshots_3.webp',
          colors: [Color(0xFF1652B8), Color(0xFF07245E)],
        ),
        Highlight(
          title: 'Scan Any Product',
          description: 'Products without a tag go into the cart by scanning their barcode.',
          label: 'Barcode Scanner',
          image: 'assets/images/peasy/peasy_screenshots_2.webp',
        ),
        Highlight(
          title: 'Pay in the App',
          description: 'Pay with a saved card, Apple Pay, Google Pay or PayPal and skip the queue.',
          label: 'Payments',
          image: 'assets/images/peasy/peasy_screenshots_5.webp',
        ),
        Highlight(
          title: 'Find the Aisle',
          description: 'See which section a product is in and whether it is in stock or on discount.',
          label: 'Store Map',
          image: 'assets/images/peasy/peasy_screenshots_6.webp',
        ),
      ],
      statuses: [EntryStatus.underDevelopment],
      link: EntryLink.github('https://github.com/ahmetkadircicek/peasy'),
    ),
  ],
);
