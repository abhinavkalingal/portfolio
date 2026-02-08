import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'theme.dart';
import 'widgets/navigation_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/footer_section.dart';

import 'features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'features/portfolio/domain/usecases/get_experiences.dart';
import 'features/portfolio/domain/usecases/get_projects.dart';
import 'features/portfolio/domain/usecases/get_skills.dart';
import 'features/portfolio/presentation/providers/portfolio_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Note: Firebase requires platform-specific configuration (google-services.json etc.)
  // We keep it commented out or handled safely for the initial transition.
  try {
    // await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final dataSource = PortfolioRemoteDataSourceImpl(
              firestore: FirebaseFirestore.instance,
            );
            final repository = PortfolioRepositoryImpl(
              remoteDataSource: dataSource,
            );
            return PortfolioProvider(
              getProjectsUseCase: GetProjectsUseCase(repository),
              getSkillsUseCase: GetSkillsUseCase(repository),
              getExperiencesUseCase: GetExperiencesUseCase(repository),
            )..fetchPortfolioData();
          },
        ),
      ],
      child: const MyPortfolioApp(),
    ),
  );
}

class MyPortfolioApp extends StatefulWidget {
  const MyPortfolioApp({Key? key}) : super(key: key);

  @override
  State<MyPortfolioApp> createState() => _MyPortfolioAppState();
}

class _MyPortfolioAppState extends State<MyPortfolioApp> {
  bool _isDarkMode = true;

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio - ${AppConstants.name}',
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: PortfolioHomePage(
        isDarkMode: _isDarkMode,
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeToggle;

  const PortfolioHomePage({
    Key? key,
    required this.isDarkMode,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    GlobalKey? targetKey;

    if (index == 0) targetKey = _heroKey;
    if (index == 1) targetKey = _aboutKey;
    if (index == 2) targetKey = _experienceKey;
    if (index == 3) targetKey = _skillsKey;
    if (index == 4) targetKey = _projectsKey;
    if (index == 5) targetKey = _contactKey;

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? AppTheme.darkBackground
          : AppTheme.lightBackground,
      body: Stack(
        children: [
          // Background Glows
          if (widget.isDarkMode)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.2,
                    colors: [
                      AppTheme.primaryBlue.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Spacer for Floating Navigation Bar
                const SizedBox(height: 100),

                Container(
                  key: _heroKey,
                  child: HeroSection(isDarkMode: widget.isDarkMode),
                ),
                Container(
                  key: _aboutKey,
                  child: AboutSection(isDarkMode: widget.isDarkMode),
                ),
                Container(
                  key: _experienceKey,
                  child: ExperienceSection(isDarkMode: widget.isDarkMode),
                ),
                Container(
                  key: _skillsKey,
                  child: SkillsSection(isDarkMode: widget.isDarkMode),
                ),
                Container(
                  key: _projectsKey,
                  child: ProjectsSection(isDarkMode: widget.isDarkMode),
                ),
                Container(
                  key: _contactKey,
                  child: ContactSection(isDarkMode: widget.isDarkMode),
                ),
                FooterSection(isDarkMode: widget.isDarkMode),
              ],
            ),
          ),

          // Floating Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavigationBar(
              onMenuTap: _scrollToSection,
              isDarkMode: widget.isDarkMode,
              onThemeToggle: widget.onThemeToggle,
            ),
          ),
        ],
      ),
    );
  }
}
