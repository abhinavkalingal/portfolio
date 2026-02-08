import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

class ContactSection extends StatefulWidget {
  final bool isDarkMode;
  const ContactSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: AppConstants.email);
    if (!await launchUrl(emailUri)) {
      debugPrint('Could not launch email');
    }
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String email = _emailController.text;
      final String message = _messageController.text;

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: AppConstants.email,
        queryParameters: {
          'subject': 'Portfolio Contact: Message from $name',
          'body': 'Name: $name\nEmail: $email\n\n$message',
        },
      );

      if (!await launchUrl(emailUri)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open email app')),
        );
      } else {
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Opening email app...')));
      }
    }
  }

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
      decoration: BoxDecoration(
        gradient: widget.isDarkMode
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.darkBackground,
                  AppTheme.gradientStart.withOpacity(0.15),
                  AppTheme.gradientEnd.withOpacity(0.15),
                ],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.lightBackground,
                  AppTheme.primaryBlue.withOpacity(0.05),
                  AppTheme.lightBlue.withOpacity(0.05),
                ],
              ),
      ),
      child: Column(
        children: [
          _buildSectionTitle(),
          const SizedBox(height: 60),
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: const Text(
            'Get In Touch',
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
        const SizedBox(height: 20),
        Text(
          'Let\'s build something amazing together.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: AppTheme.textGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildContactInfo()),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _buildContactForm()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildContactInfo(),
        const SizedBox(height: 40),
        _buildContactForm(),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard(
          Icons.mail_outline,
          'Email Me',
          AppConstants.email,
          () => _launchEmail(),
        ),
        const SizedBox(height: 20),
        _buildInfoCard(
          Icons.location_on_outlined,
          'Location',
          'Kerala, India',
          null,
        ),
        const SizedBox(height: 40),
        _buildSocialGrid(),
      ],
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String title,
    String value,
    VoidCallback? onTap,
  ) {
    return _GlassCard(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppTheme.primaryBlue, size: 26),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.isDarkMode
                          ? AppTheme.textLight
                          : AppTheme.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialGrid() {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: [
        _buildSocialButton(Icons.code, 'GitHub', AppConstants.github),
        _buildSocialButton(
          Icons.work_outline,
          'LinkedIn',
          AppConstants.linkedin,
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isDarkMode
                ? AppTheme.cardDark.withOpacity(0.4)
                : AppTheme.cardLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppTheme.primaryBlue, size: 18),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.isDarkMode
                      ? AppTheme.textLight
                      : AppTheme.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return _GlassCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: _nameController,
              label: 'Your Name',
              icon: Icons.person_outline,
              validator: (v) => v!.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.mail_outline,
              validator: (v) =>
                  !v!.contains('@') ? 'Please enter a valid email' : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _messageController,
              label: 'Message',
              icon: Icons.chat_bubble_outline,
              maxLines: 5,
              validator: (v) => v!.isEmpty ? 'Please enter your message' : null,
            ),
            const SizedBox(height: 35),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: _handleSubmit,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'Send Message',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textLight,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: widget.isDarkMode
                ? AppTheme.textLight.withOpacity(0.8)
                : AppTheme.textDark.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            color: widget.isDarkMode ? AppTheme.textLight : AppTheme.textDark,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppTheme.primaryBlue, size: 20),
            filled: true,
            fillColor: widget.isDarkMode
                ? Colors.white.withOpacity(0.03)
                : Colors.black.withOpacity(0.01),
            hintText: 'Enter your ${label.toLowerCase()}...',
            hintStyle: TextStyle(
              color: AppTheme.textGrey.withOpacity(0.5),
              fontSize: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppTheme.primaryBlue,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
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
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.cardDark.withOpacity(0.4)
            : AppTheme.cardLight.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
