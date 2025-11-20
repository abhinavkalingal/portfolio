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
          child: Text(
            'My Projects',
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
        const SizedBox(height: 20),
        Text(
          'Recent work and personal projects',
          style: TextStyle(
            fontSize: 18,
            color: isDarkMode ? AppTheme.textGrey : AppTheme.textGrey,
          ),
        ),
      ],
    );
  }

  // Projects Grid with Enhanced Layout
  Widget _buildProjectsGrid(bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Better responsive layout
        int crossAxisCount;
        if (isMobile) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth > 1400) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 900) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isMobile ? 20 : 30,
            mainAxisSpacing: isMobile ? 20 : 30,
            childAspectRatio: isMobile
                ? 0.85
                : (crossAxisCount == 3 ? 0.75 : 1.1),
          ),
          itemCount: AppConstants.projects.length,
          itemBuilder: (context, index) {
            final project = AppConstants.projects[index];
            return _buildProjectCard(
              project['title'] as String,
              project['description'] as String,
              project['techStack'] as String,
              project['githubLink'] as String,
              index,
            );
          },
        );
      },
    );
  }

  // Project Card with Hover Effect
  Widget _buildProjectCard(
    String title,
    String description,
    String techStack,
    String githubLink,
    int index,
  ) {
    return _ProjectCardWidget(
      title: title,
      description: description,
      techStack: techStack,
      githubLink: githubLink,
      index: index,
      isDarkMode: isDarkMode,
    );
  }
}

// Stateful Project Card Widget for Hover Effect
class _ProjectCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final String techStack;
  final String githubLink;
  final int index;
  final bool isDarkMode;

  const _ProjectCardWidget({
    required this.title,
    required this.description,
    required this.techStack,
    required this.githubLink,
    required this.index,
    required this.isDarkMode,
  });

  @override
  State<_ProjectCardWidget> createState() => _ProjectCardWidgetState();
}

class _ProjectCardWidgetState extends State<_ProjectCardWidget>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Launch URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Different gradient for each project card
    final gradients = [
      AppTheme.primaryGradient,
      const LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      const LinearGradient(
        colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      const LinearGradient(
        colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ];

    final selectedGradient = gradients[widget.index % gradients.length];

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: widget.isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primaryBlue
                  : (widget.isDarkMode
                        ? AppTheme.primaryBlue.withOpacity(0.1)
                        : AppTheme.primaryBlue.withOpacity(0.05)),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppTheme.primaryBlue.withOpacity(0.25)
                    : Colors.black.withOpacity(widget.isDarkMode ? 0.3 : 0.08),
                blurRadius: _isHovered ? 30 : 15,
                offset: Offset(0, _isHovered ? 12 : 6),
                spreadRadius: _isHovered ? 2 : 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with gradient accent
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: selectedGradient.scale(0.15),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                child: Row(
                  children: [
                    // Project Icon with gradient
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: selectedGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: selectedGradient.colors.first.withOpacity(
                              0.4,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.code,
                        color: AppTheme.textLight,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Project Title
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: widget.isDarkMode
                              ? AppTheme.textLight
                              : AppTheme.textDark,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Description
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.7,
                          color: widget.isDarkMode
                              ? AppTheme.textGrey
                              : AppTheme.textGrey,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),

                      // Tech Stack Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.techStack.split(', ').map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: widget.isDarkMode
                                  ? AppTheme.primaryBlue.withOpacity(0.15)
                                  : AppTheme.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: widget.isDarkMode
                                    ? AppTheme.primaryBlue.withOpacity(0.3)
                                    : AppTheme.primaryBlue.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: widget.isDarkMode
                                    ? AppTheme.primaryBlue.withOpacity(0.9)
                                    : AppTheme.primaryBlue,
                                letterSpacing: 0.2,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const Spacer(),

                      // Action Buttons Row
                      Row(
                        children: [
                          // GitHub Button
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: selectedGradient,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: _isHovered
                                    ? [
                                        BoxShadow(
                                          color: selectedGradient.colors.first
                                              .withOpacity(0.4),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () => _launchURL(widget.githubLink),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.code,
                                          size: 20,
                                          color: AppTheme.textLight,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'View Code',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.textLight,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Live Demo Button (Optional)
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: widget.isDarkMode
                                    ? AppTheme.primaryBlue.withOpacity(0.5)
                                    : AppTheme.primaryBlue,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () => _launchURL(widget.githubLink),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  child: Icon(
                                    Icons.launch,
                                    size: 20,
                                    color: widget.isDarkMode
                                        ? AppTheme.primaryBlue
                                        : AppTheme.primaryBlue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
