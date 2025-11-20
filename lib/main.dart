import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets/navigation_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer_section.dart';

void main() {
  runApp(const MyPortfolioApp());
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
      title: 'Portfolio-Abhinav',
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
    if (index == 2) targetKey = _skillsKey;
    if (index == 3) targetKey = _projectsKey;
    if (index == 4) targetKey = _contactKey;

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
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
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Container(
                  key: _heroKey,
                  child: HeroSection(isDarkMode: widget.isDarkMode),
                ),
                Container(
                  key: _aboutKey,
                  child: AboutSection(isDarkMode: widget.isDarkMode),
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
