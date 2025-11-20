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

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String email = _emailController.text;
      final String message = _messageController.text;

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'abhinav.fltr@gmail.com', 
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
          _sectionTitle(),
          const SizedBox(height: 60),
          isMobile ? _mobileLayout() : _desktopLayout(),
        ],
      ),
    );
  }

  Widget _sectionTitle() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'Get In Touch',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? AppTheme.textLight : AppTheme.textDark,
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
        const SizedBox(height: 20),
        Text(
          'Feel free to reach out for collaborations or just a friendly hello',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: widget.isDarkMode ? AppTheme.textGrey : AppTheme.textGrey,
          ),
        ),
      ],
    );
  }

  Widget _desktopLayout() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(flex: 2, child: _contactInfo()),
      const SizedBox(width: 60),
      Expanded(flex: 3, child: _contactForm()),
    ],
  );

  Widget _mobileLayout() => Column(
    children: [_contactInfo(), const SizedBox(height: 40), _contactForm()],
  );

  Widget _contactInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Let\'s Connect',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: widget.isDarkMode ? AppTheme.textLight : AppTheme.textDark,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        'I\'m always interested in hearing about new projects and opportunities.',
        style: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: widget.isDarkMode ? AppTheme.textGrey : AppTheme.textGrey,
        ),
      ),
      const SizedBox(height: 40),
      _contactItem(
        Icons.email,
        'Email',
        AppConstants.email,
        'mailto:${AppConstants.email}',
      ),
      const SizedBox(height: 20),
      _contactItem(
        Icons.work,
        'LinkedIn',
        'linkedin.com/in/abhi',
        AppConstants.linkedin,
      ),
      const SizedBox(height: 20),
      _contactItem(
        Icons.code,
        'GitHub',
        'github.com/abhi',
        AppConstants.github,
      ),
      const SizedBox(height: 40),
      _socialIcons(),
    ],
  );

  Widget _contactItem(IconData icon, String label, String value, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.textLight, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: widget.isDarkMode
                        ? AppTheme.textGrey
                        : AppTheme.textGrey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
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
    );
  }

  Widget _socialIcons() => Row(
    children: [
      _socialIcon(Icons.email, AppConstants.email),
      const SizedBox(width: 15),
      _socialIcon(Icons.work, AppConstants.linkedin),
      const SizedBox(width: 15),
      _socialIcon(Icons.code, AppConstants.github),
    ],
  );

  Widget _socialIcon(IconData icon, String url) => GestureDetector(
    onTap: () => _launchURL(url),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isDarkMode
              ? AppTheme.primaryBlue.withOpacity(0.3)
              : AppTheme.primaryBlue.withOpacity(0.2),
        ),
      ),
      child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
    ),
  );

  Widget _contactForm() => Container(
    padding: const EdgeInsets.all(30),
    decoration: BoxDecoration(
      color: widget.isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _textField(
            controller: _nameController,
            label: 'Name',
            icon: Icons.person,
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter your name'
                : null,
          ),
          const SizedBox(height: 20),
          _textField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Please enter your email';
              if (!value.contains('@')) return 'Please enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 20),
          _textField(
            controller: _messageController,
            label: 'Message',
            icon: Icons.message,
            maxLines: 5,
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter your message'
                : null,
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _handleSubmit,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Send Message',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textLight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) => TextFormField(
    controller: controller,
    maxLines: maxLines,
    keyboardType: keyboardType,
    validator: validator,
    style: TextStyle(
      color: widget.isDarkMode ? AppTheme.textLight : AppTheme.textDark,
    ),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: widget.isDarkMode ? AppTheme.textGrey : AppTheme.textGrey,
      ),
      prefixIcon: Icon(icon, color: AppTheme.primaryBlue),
      filled: true,
      fillColor: widget.isDarkMode
          ? AppTheme.darkBackground.withOpacity(0.5)
          : AppTheme.lightBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: widget.isDarkMode
              ? AppTheme.primaryBlue.withOpacity(0.3)
              : AppTheme.primaryBlue.withOpacity(0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
  );
}
