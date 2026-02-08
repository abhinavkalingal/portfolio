import 'package:flutter/material.dart';
import '../theme.dart';

class SkillsSection extends StatefulWidget {
  final bool isDarkMode;
  const SkillsSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Development',
      'skills': [
        {
          'name': 'Flutter',
          'level': 0.95,
          'icon': Icons.flutter_dash,
          'color': Color(0xFF02569B),
        },
        {
          'name': 'Dart',
          'level': 0.90,
          'icon': Icons.code,
          'color': Color(0xFF00B4AB),
        },
        {
          'name': 'Provider/Riverpod',
          'level': 0.85,
          'icon': Icons.layers,
          'color': Color(0xFF3B82F6),
        },
        {
          'name': 'BLoC Pattern',
          'level': 0.80,
          'icon': Icons.settings_input_component,
          'color': Color(0xFF536DFE),
        },
      ],
    },
    {
      'title': 'Backend & Tools',
      'skills': [
        {
          'name': 'Firebase',
          'level': 0.88,
          'icon': Icons.local_fire_department,
          'color': Color(0xFFFFA000),
        },
        {
          'name': 'REST APIs',
          'level': 0.85,
          'icon': Icons.api,
          'color': Color(0xFF4CAF50),
        },
        {
          'name': 'Git & GitHub',
          'level': 0.92,
          'icon': Icons.terminal,
          'color': Color(0xFF6E5494),
        },
        {
          'name': 'App Deployment',
          'level': 0.75,
          'icon': Icons.cloud_upload,
          'color': Color(0xFF2196F3),
        },
      ],
    },
    {
      'title': 'Design & Others',
      'skills': [
        {
          'name': 'UI/UX Design',
          'level': 0.80,
          'icon': Icons.design_services,
          'color': Color(0xFFE91E63),
        },
        {
          'name': 'Figma',
          'level': 0.75,
          'icon': Icons.draw,
          'color': Color(0xFFF24E1E),
        },
        {
          'name': 'Responsive Design',
          'level': 0.90,
          'icon': Icons.devices_other,
          'color': Color(0xFF673AB7),
        },
        {
          'name': 'Clean Architecture',
          'level': 0.85,
          'icon': Icons.architecture,
          'color': Color(0xFF607D8B),
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      categories.length * 4,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      ),
    );

    _animations = _controllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeOutQuart))
        .toList();

    _startAnimations();
  }

  void _startAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 1024;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 80 : 120,
      ),
      color: widget.isDarkMode
          ? AppTheme.darkBackground
          : AppTheme.lightBackground,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 80),
          if (isMobile) _buildMobileLayout() else _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: const Text(
            'Technical Proficiency',
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
          'A showcase of my technological stack and design toolkit.',
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
    return Column(
      children: categories.asMap().entries.map((entry) {
        int catIndex = entry.key;
        var category = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category['title'],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: 2.8,
                ),
                itemCount: (category['skills'] as List).length,
                itemBuilder: (context, index) {
                  int skillIndex = catIndex * 4 + index;
                  return _SkillCard(
                    skill: category['skills'][index],
                    animation: _animations[skillIndex],
                    isDarkMode: widget.isDarkMode,
                  );
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: categories.asMap().entries.map((entry) {
        int catIndex = entry.key;
        var category = entry.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Text(
                category['title'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...(category['skills'] as List).asMap().entries.map((skillEntry) {
              int index = skillEntry.key;
              int skillIndex = catIndex * 4 + index;
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _SkillCard(
                  skill: skillEntry.value,
                  animation: _animations[skillIndex],
                  isDarkMode: widget.isDarkMode,
                ),
              );
            }).toList(),
          ],
        );
      }).toList(),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Map<String, dynamic> skill;
  final Animation<double> animation;
  final bool isDarkMode;

  const _SkillCard({
    required this.skill,
    required this.animation,
    required this.isDarkMode,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color accentColor = widget.skill['color'];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: widget.isDarkMode
              ? AppTheme.cardDark.withOpacity(_isHovered ? 0.6 : 0.4)
              : Colors.white.withOpacity(_isHovered ? 1.0 : 0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? accentColor.withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? AppTheme.glowShadow(accentColor)
              : AppTheme.premiumShadow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accentColor, accentColor.withOpacity(0.3)],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            widget.skill['icon'],
                            color: accentColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.skill['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildProgressBar(accentColor),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          '${(widget.skill['level'] * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: accentColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(Color color) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              widthFactor: widget.animation.value * widget.skill['level'],
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.6)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    if (_isHovered)
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
