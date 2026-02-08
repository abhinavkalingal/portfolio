import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

// Projects Section - Showcase portfolio projects
class ProjectsSection extends StatelessWidget {
  final bool isDarkMode;

  const ProjectsSection({Key? key, required this.isDarkMode}) : super(key: key);

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
          // Section Title
          _buildSectionTitle(),
          const SizedBox(height: 60),

          // Projects Grid
          _buildProjectsGrid(isMobile),
        ],
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: const Text(
            'Featured Projects',
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

  // Projects Grid
  Widget _buildProjectsGrid(bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        if (isMobile) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth > 1200) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: isMobile ? 0.85 : 0.8,
          ),
          itemCount: AppConstants.projects.length,
          itemBuilder: (context, index) {
            return _ProjectCardWidget(
              project: AppConstants.projects[index],
              isDarkMode: isDarkMode,
            );
          },
        );
      },
    );
  }
}

class _ProjectCardWidget extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isDarkMode;

  const _ProjectCardWidget({required this.project, required this.isDarkMode});

  @override
  State<_ProjectCardWidget> createState() => _ProjectCardWidgetState();
}

class _ProjectCardWidgetState extends State<_ProjectCardWidget> {
  bool _isHovered = false;

  void _launchURL(String? url) async {
    if (url == null) return;
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isDarkMode
                ? AppTheme.cardDark.withOpacity(0.5)
                : AppTheme.cardLight,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primaryBlue.withOpacity(0.3)
                  : Colors.white.withOpacity(0.05),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.3 : 0.1),
                blurRadius: _isHovered ? 30 : 20,
                offset: Offset(0, _isHovered ? 15 : 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Image Container
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [_buildImage(), if (_isHovered) _buildOverlay()],
                  ),
                ),
                // Project Details
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project['title'],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: widget.isDarkMode
                                ? AppTheme.textLight
                                : AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            widget.project['description'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: AppTheme.textGrey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTechStack(widget.project['techStack'] as String),
                        const SizedBox(height: 20),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AnimatedScale(
      scale: _isHovered ? 1.1 : 1.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1)),
        child: widget.project['image'] != null
            ? Image.asset(widget.project['image'], fit: BoxFit.cover)
            : Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: AppTheme.primaryBlue.withOpacity(0.3),
                ),
              ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.2)),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.remove_red_eye, color: AppTheme.primaryBlue),
        ),
      ),
    );
  }

  Widget _buildTechStack(String techStack) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: techStack.split(', ').map((t) => _buildTechBadge(t)).toList(),
    );
  }

  Widget _buildTechBadge(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
      ),
      child: Text(
        tech,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryBlue,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildActionButton(
          'GitHub',
          Icons.code,
          () => _launchURL(widget.project['githubLink']),
        ),
        // Add Live Demo button logic if needed
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: AppTheme.primaryBlue),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
