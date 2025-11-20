import 'package:flutter/material.dart';
import '../theme.dart';

// Footer Component
class FooterSection extends StatelessWidget {
  final bool isDarkMode;

  const FooterSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.cardDark,
                  AppTheme.gradientStart.withOpacity(0.2),
                  AppTheme.gradientEnd.withOpacity(0.2),
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.cardLight,
                  AppTheme.primaryBlue.withOpacity(0.05),
                  AppTheme.lightBlue.withOpacity(0.05),
                ],
              ),
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? AppTheme.primaryBlue.withOpacity(0.2)
                : AppTheme.primaryBlue.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Footer Content
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),

          const SizedBox(height: 30),

          // Divider
          Container(
            height: 1,
            color: isDarkMode
                ? AppTheme.primaryBlue.withOpacity(0.2)
                : AppTheme.primaryBlue.withOpacity(0.1),
          ),

          const SizedBox(height: 20),

          // Copyright
          _buildCopyright(),
        ],
      ),
    );
  }

  // Desktop Layout
  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo and Description
        Expanded(flex: 2, child: _buildLogoSection()),

        const SizedBox(width: 60),

        // Quick Links
        Expanded(child: _buildQuickLinks()),

        const SizedBox(width: 60),

        // Contact Info
        Expanded(child: _buildContactInfo()),
      ],
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogoSection(),
        const SizedBox(height: 30),
        _buildQuickLinks(),
        const SizedBox(height: 30),
        _buildContactInfo(),
      ],
    );
  }

  // Logo Section
  Widget _buildLogoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: const Text(
            '<Abhi/>',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Flutter Developer building beautiful\nand functional applications.',
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            color: isDarkMode ? AppTheme.textGrey : AppTheme.textGrey,
          ),
        ),
      ],
    );
  }

  // Quick Links
  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 15),
        _buildFooterLink('Home'),
        _buildFooterLink('About'),
        _buildFooterLink('Skills'),
        _buildFooterLink('Projects'),
        _buildFooterLink('Contact'),
      ],
    );
  }

  // Contact Info
  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 15),
        _buildInfoRow(Icons.email, AppConstants.email),
        const SizedBox(height: 10),
        _buildInfoRow(Icons.location_on, 'Kerala, India'),
      ],
    );
  }

  // Footer Link
  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? AppTheme.textGrey : AppTheme.textGrey,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  // Info Row
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isDarkMode ? AppTheme.primaryBlue : AppTheme.primaryBlue,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? AppTheme.textGrey : AppTheme.textGrey,
            ),
          ),
        ),
      ],
    );
  }

  // Copyright
  Widget _buildCopyright() {
    return Text(
      '© 2025 ${AppConstants.name} | Built with Flutter ',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: isDarkMode ? AppTheme.textGrey : AppTheme.textGrey,
      ),
    );
  }
}
