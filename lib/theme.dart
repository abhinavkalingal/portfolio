import 'package:flutter/material.dart';

// App Theme Configuration
class AppTheme {
  // Primary Blue Theme Colors (based on user preference)
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color darkBlue = Color(0xFF1976D2);
  static const Color lightBlue = Color(0xFF64B5F6);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF6A11CB);
  static const Color gradientEnd = Color(0xFF2575FC);

  // Accent Gradient Colors
  static const Color accentGradientStart = Color(0xFFFF6B6B);
  static const Color accentGradientEnd = Color(0xFFFFD93D);

  // Background Colors
  static const Color darkBackground = Color(0xFF0A0E27);
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color cardDark = Color(0xFF1E1E2E);
  static const Color cardLight = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFF6B7280);

  // Primary Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Accent Gradient
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentGradientStart, accentGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: darkBackground,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: textLight,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: textLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: textLight),
      bodyMedium: TextStyle(fontSize: 14, color: textGrey),
    ),
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: lightBackground,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: textDark),
      bodyMedium: TextStyle(fontSize: 14, color: textGrey),
    ),
  );
}

// App Constants
class AppConstants {
  // Personal Information
  static const String name = "Abhinav K";
  static const String jobTitle = "Flutter Developer";
  static const String email = "abhinav.fltr@gmail.com";
  static const String linkedin = "www.linkedin.com/in/abhinav-kallingal-764834316i";
  static const String github = "https://github.com/abhinavkalingal";

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
}
