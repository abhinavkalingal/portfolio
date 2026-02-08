import 'package:flutter/material.dart';
import '../theme.dart';

class HeroSection extends StatelessWidget {
  final bool isDarkMode;
  const HeroSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 1024;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 600 : 800),
      child: Stack(
        children: [
          _buildBackgroundGradient(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: isMobile ? 40 : 100,
            ),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGradient() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.7, -0.2),
            radius: 0.8,
            colors: [AppTheme.primaryBlue.withOpacity(0.1), Colors.transparent],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildContent()),
        const SizedBox(width: 40),
        Expanded(flex: 2, child: _buildProfileImage()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildProfileImage(),
        const SizedBox(height: 60),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAvailableBadge(),
        const SizedBox(height: 30),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Abhinav ',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primaryBlue,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: 'K',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Flutter Developer',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w800,
            color: isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 30),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const Text(
            AppConstants.heroDescription,
            style: TextStyle(
              fontSize: 18,
              height: 1.6,
              color: AppTheme.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 50),
        Row(
          children: [
            _buildPrimaryButton('Download CV', Icons.file_download_outlined),
            const SizedBox(width: 20),
            _buildSecondaryButton('Let\'s Talk', Icons.chat_bubble_outline),
          ],
        ),
      ],
    );
  }

  Widget _buildAvailableBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check_circle, size: 14, color: AppTheme.primaryBlue),
          SizedBox(width: 8),
          Text(
            'Available for work',
            style: TextStyle(
              color: AppTheme.primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(String text, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            width: 8,
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
              color: Colors.black.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
      ),
    );
  }
}
