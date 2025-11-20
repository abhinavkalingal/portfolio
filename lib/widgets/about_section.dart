import 'package:flutter/material.dart';
import '../theme.dart';

class AboutSection extends StatelessWidget {
  final bool isDarkMode;

  const AboutSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: isMobile ? 60 : 100,
      ),
      color: isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground,
      child: Column(
        children: [
          buildTitle(),
          const SizedBox(height: 60),
          isMobile ? buildMobileLayout() : buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'About Me',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: buildInfoCard()),
        const SizedBox(width: 40),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              buildEducationCard(),
              const SizedBox(height: 30),
              buildCareerGoalCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMobileLayout() {
    return Column(
      children: [
        buildInfoCard(),
        const SizedBox(height: 30),
        buildEducationCard(),
        const SizedBox(height: 30),
        buildCareerGoalCard(),
      ],
    );
  }

  Widget buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person, color: AppTheme.textLight, size: 24),
              ),
              const SizedBox(width: 15),
              Text(
                'Introduction',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            AppConstants.aboutText,
            style: TextStyle(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEducationCard() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppTheme.accentGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.school, color: AppTheme.textLight, size: 24),
              ),
              const SizedBox(width: 15),
              Text(
                'Education',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          buildEducationItem('Higher Secondary Education', 'GMHSS Perinthalmanna', '2023 - 2025'),
          const SizedBox(height: 15),
          buildEducationItem('Flutter Development Course', 'Oxdo Technologies Pvt Ltd, Perinthalmanna, Kerala', '2025'),
        ],
      ),
    );
  }

  Widget buildEducationItem(String degree, String institution, String year) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                degree,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                institution,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textGrey,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                year,
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.textGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCareerGoalCard() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [AppTheme.gradientStart.withOpacity(0.3), AppTheme.gradientEnd.withOpacity(0.3)]
              : [AppTheme.primaryBlue.withOpacity(0.1), AppTheme.lightBlue.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDarkMode
              ? AppTheme.primaryBlue.withOpacity(0.3)
              : AppTheme.primaryBlue.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.rocket_launch, color: AppTheme.textLight, size: 24),
              ),
              const SizedBox(width: 15),
              Text(
                'Career Goal',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            AppConstants.careerGoal,
            style: TextStyle(
              fontSize: 16,
              height: 1.8,
              color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
