import 'package:flutter/material.dart';
import '../theme.dart';

class AboutSection extends StatelessWidget {
  final bool isDarkMode;

  const AboutSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 1024; // Better threshold for split layout

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 80 : 120,
      ),
      color: isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground,
      child: Column(
        children: [
          _buildSectionHeader(),
          const SizedBox(height: 60),
          if (isMobile) _buildMobileLayout() else _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: const Text(
            'About Me',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 6,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildSideProfile()),
        const SizedBox(width: 60),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _buildInfoCard(),
              const SizedBox(height: 30),
              _buildEducationCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildSideProfile(),
        const SizedBox(height: 40),
        _buildInfoCard(),
        const SizedBox(height: 30),
        _buildEducationCard(),
      ],
    );
  }

  Widget _buildSideProfile() {
    return _GlassCard(
      child: Column(
        children: [
          Center(
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryBlue.withOpacity(0.2),
                  width: 6,
                ),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/Gemini_Generated_Image_bwe7rbwe7rbwe7rb.png',
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Abhinav Kallingal',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.primaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSimpleStat('2+', 'Years Exp'),
              _buildVerticalDivider(),
              _buildSimpleStat('15+', 'Projects'),
              _buildVerticalDivider(),
              _buildSimpleStat('3+', 'Awards'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildSimpleStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppTheme.textGrey),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(Icons.auto_awesome, 'Introduction'),
          const SizedBox(height: 20),
          Text(
            AppConstants.aboutText,
            style: TextStyle(
              fontSize: 17,
              height: 1.8,
              color: isDarkMode
                  ? AppTheme.textLight.withOpacity(0.85)
                  : AppTheme.textDim,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard() {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(Icons.school_rounded, 'Education'),
          const SizedBox(height: 25),
          _buildTimelineItem(
            'Higher Secondary Education',
            'GMHSS Perinthalmanna',
            '2023 - 2025',
          ),
          const SizedBox(height: 30),
          _buildTimelineItem(
            'Flutter Dev Career Certification',
            'Oxdo Technologies Pvt Ltd',
            '2025',
          ),
        ],
      ),
    );
  }

  Widget _buildCardTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryBlue, size: 28),
        const SizedBox(width: 15),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(String title, String subtitle, String date) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          height: 12,
          width: 12,
          decoration: const BoxDecoration(
            color: AppTheme.primaryBlue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppTheme.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                date,
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.primaryBlue.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.cardDark.withOpacity(0.4)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
          width: 1.5,
        ),
        boxShadow: AppTheme.premiumShadow,
      ),
      child: child,
    );
  }
}
