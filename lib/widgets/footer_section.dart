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
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground,
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Footer Content
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),

          const SizedBox(height: 50),

          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDarkMode
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

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
        const SizedBox(height: 40),
        _buildQuickLinks(),
        const SizedBox(height: 40),
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
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Crafting high-performance digital experiences\nwith Flutter and modern design principles.',
          style: TextStyle(fontSize: 15, height: 1.8, color: AppTheme.textGrey),
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
          'Explore',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 25),
        _buildFooterLink('About Me'),
        _buildFooterLink('Key Skills'),
        _buildFooterLink('Portfolio'),
        _buildFooterLink('Get In Touch'),
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
            letterSpacing: 0.5,
            color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 25),
        _buildInfoRow(Icons.email_outlined, AppConstants.email),
        const SizedBox(height: 15),
        _buildInfoRow(Icons.location_on_outlined, 'Kerala, India'),
      ],
    );
  }

  // Footer Link
  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: TextStyle(fontSize: 15, color: AppTheme.textGrey),
        ),
      ),
    );
  }

  // Info Row
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.primaryBlue),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 15, color: AppTheme.textGrey),
          ),
        ),
      ],
    );
  }

  // Copyright
  Widget _buildCopyright() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '© 2025 ${AppConstants.name} | Built with ',
          style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
        ),
        const Icon(Icons.favorite, color: Colors.red, size: 14),
        Text(
          ' using Flutter',
          style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
        ),
      ],
    );
  }
}
