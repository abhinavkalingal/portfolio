import 'package:flutter/material.dart';

// App Theme Configuration
class AppTheme {
  // Premium Color Palette
  static const Color primaryBlue = Color(
    0xFF2563EB,
  ); // Vibrant Blue from screenshot
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color darkBlue = Color(0xFF1D4ED8);
  static const Color lightBlue = Color(0xFF60A5FA);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF3B82F6);
  static const Color gradientEnd = Color(0xFF8B5CF6); // Purple-600

  // Accent Gradient Colors
  static const Color accentGradientStart = Color(0xFFF43F5E); // Rose-500
  static const Color accentGradientEnd = Color(0xFFFB923C); // Amber-400

  // Background Surface Colors
  static const Color darkBackground = Color(0xFF020617); // Slate-950
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color cardDark = Color(0xFF0F172A); // Slate-900
  static const Color cardLight = Colors.white;

  // Premium Text Colors
  static const Color textDark = Color(0xFF0F172A);
  static const Color textLight = Color(0xFFF8FAFC);
  static const Color textGrey = Color(0xFF64748B); // Slate-500
  static const Color textDim = Color(0xFF475569); // Slate-600

  // Primary Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentGradientStart, accentGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Reusable Shadow System
  static List<BoxShadow> premiumShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> glowShadow(Color color) => [
    BoxShadow(color: color.withOpacity(0.3), blurRadius: 20, spreadRadius: 2),
  ];

  // Dark Theme Definition
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: darkBackground,
    fontFamily: 'Poppins',
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: textLight,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: textLight,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textLight,
      ),
      bodyLarge: TextStyle(fontSize: 18, color: textLight, height: 1.6),
      bodyMedium: TextStyle(fontSize: 16, color: textGrey, height: 1.6),
    ),
  );

  // Light Theme Definition
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: lightBackground,
    fontFamily: 'Poppins',
    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: textDark,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textDark,
      ),
      bodyLarge: TextStyle(fontSize: 18, color: textDark, height: 1.6),
      bodyMedium: TextStyle(fontSize: 16, color: textGrey, height: 1.6),
    ),
  );
}

// App Constants
class AppConstants {
  // Personal Information
  static const String name = "Abhinav Kallingal";
  static const String jobTitle = "Flutter Developer";
  static const String email = "abhinav.fltr@gmail.com";
  static const String linkedin =
      "www.linkedin.com/in/abhinav-kallingal-764834316i";
  static const String github = "https://github.com/abhinavkalingal";

  // Hero Section
  static const String heroDescription =
      "Architecting high-performance Flutter applications with a focus on immersive UX and scalable engineering.";

  // About Section
  static const String aboutText =
      "I'm a passionate Flutter Developer with expertise in building beautiful, "
      "responsive mobile and web applications. I completed my Higher Secondary Education "
      "from GMHSS Perinthalmanna (2023-2025) and earned certification in Flutter Development "
      "from Oxdo Technologies Pvt Ltd. I'm eager to contribute to innovative projects and "
      "continuously learn new technologies to create impactful user experiences.";

  // Education
  static const String education =
      "Higher Secondary Education - GMHSS Perinthalmanna (2023-2025)\n"
      "Flutter Development Course - Oxdo Technologies Pvt Ltd, Perinthalmanna, Kerala (2025)";

  // Career Goal
  static const String careerGoal =
      "To become a skilled full-stack developer, creating innovative solutions "
      "that make a positive impact while continuously learning and growing in the tech industry.";

  // Skills
  static const List<Map<String, String>> skills = [
    {"name": "Flutter", "icon": "🎯"},
    {"name": "Dart", "icon": "💙"},
    {"name": "Firebase", "icon": "🔥"},
    {"name": "REST API", "icon": "🌐"},
    {"name": "Git", "icon": "📦"},
    {"name": "UI/UX Design", "icon": "🎨"},
  ];

  // Projects
  static const List<Map<String, dynamic>> projects = [
    {
      "title": "Deep Café App",
      "description":
          "A modern café management app with online ordering, real-time updates",
      "techStack": "Flutter, Firebase",
      "githubLink": "https://github.com/anasoxdo/deep_cafe.git",
    },
    {
      "title": "CRM Management System",
      "description":
          "Developed a Customer Relationship Management (CRM) system with three modules – Admin, Employee, and Customer – to manage customer details, service tickets, and internal communication efficiently. The system helps small and medium businesses streamline daily operations and enhance customer support.",
      "techStack": "Flutter, Firebase, Riverpod, github",
      "githubLink": "https://github.com/anasoxdo/crm_admin.git",
    },
    {
      "title": "Weather App",
      "description":
          "Real-time weather forecasting app with beautiful UI and location-based weather updates.",
      "techStack": "Flutter, OpenWeather API, Geolocator",
      "githubLink": "https://github.com/abhi/weather-app",
    },
    {
      "title": "Netflix Ui Clone ",
      "description":
          "A Netflix-inspired Flutter UI clone that replicates the modern look and feel of the Netflix mobile app. Includes interactive carousels, movie detail pages, smooth animations, and responsive design for all devices.",
      "techStack": "Flutter, Dart, Bloc, github",
      "githubLink": "https://github.com/abhinavkalingal/netflix_ui_clone.git",
    },
  ];
  // Experience
  static const List<Map<String, dynamic>> experiences = [
    {
      "company": "Oxdo Technologies Pvt Ltd",
      "role": "Flutter Developer Trainee",
      "period": "2024 - Present",
      "description":
          "Leading mobile app development using Flutter. Implementing clean architecture, state management with Riverpod, and complex UI animations. Collaborating with cross-functional teams to deliver high-quality products.",
      "achievements": [
        "Architected and deployed 3+ production-ready apps",
        "Optimized app performance by 40% using best practices",
        "Designed and implemented high-fidelity UI components",
      ],
    },
    {
      "company": "Freelance Developer",
      "role": "Full Stack Contributor",
      "period": "2023 - 2024",
      "description":
          "Worked on diverse projects ranging from small business websites to complex mobile applications. Focused on delivering user-centric solutions using Flutter and Firebase.",
      "achievements": [
        "Developed a scalable CRM for local businesses",
        "Integrated multi-role authentication and real-time databases",
        "Collaborated with clients to define product roadmaps",
      ],
    },
  ];
}
