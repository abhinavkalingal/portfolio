import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme.dart';

// Skills Section - Display technical skills with animated progress indicators
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

  // Skill data with percentages (0.0 to 1.0)
  final List<Map<String, dynamic>> skills = [
    {
      'name': 'Flutter',
      'icon': Icons.flutter_dash,
      'percentage': 0.90, // 90%
      'color': const Color(0xFF2196F3),
    },
    {
      'name': 'Dart',
      'icon': Icons.code,
      'percentage': 0.85, // 85%
      'color': const Color(0xFF0277BD),
    },
    {
      'name': 'Firebase',
      'icon': Icons.local_fire_department,
      'percentage': 0.80, // 80%
      'color': const Color(0xFFFF6B00),
    },
    {
      'name': 'REST API',
      'icon': Icons.api,
      'percentage': 0.75, // 75%
      'color': const Color(0xFF4CAF50),
    },
    {
      'name': 'Git & GitHub',
      'icon': Icons.storage,
      'percentage': 0.85, // 85%
      'color': const Color(0xFF6A11CB),
    },
    {
      'name': 'UI/UX Design',
      'icon': Icons.design_services,
      'percentage': 0.80, // 80%
      'color': const Color(0xFF9C27B0),
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  // Initialize animations for each skill
  void _initializeAnimations() {
    _controllers = List.generate(
      skills.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 1500 + (index * 200)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    // Start animations with staggered delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        for (var i = 0; i < _controllers.length; i++) {
          Future.delayed(Duration(milliseconds: i * 100), () {
            if (mounted) _controllers[i].forward();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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
                  AppTheme.cardDark.withOpacity(0.5),
                  AppTheme.darkBackground,
                ],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.lightBackground,
                  AppTheme.primaryBlue.withOpacity(0.05),
                  AppTheme.lightBackground,
                ],
              ),
      ),
      child: Column(
        children: [
          // Section Title
          _buildSectionTitle(),
          const SizedBox(height: 60),

          // Skills Layout
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ],
      ),
    );
  }

  // Section Title with gradient effect
  Widget _buildSectionTitle() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'My Skills',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
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
          'Technical expertise and proficiency levels',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            color: widget.isDarkMode ? AppTheme.textGrey : AppTheme.textGrey,
          ),
        ),
      ],
    );
  }

  // Desktop Layout - Shows circular indicators and progress bars side by side
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side: Circular indicators
        Expanded(flex: 2, child: _buildCircularIndicators()),
        const SizedBox(width: 40),

        // Right side: Linear progress bars
        Expanded(flex: 3, child: _buildLinearProgressBars()),
      ],
    );
  }

  // Mobile Layout - Stacked vertically
  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildCircularIndicators(),
        const SizedBox(height: 40),
        _buildLinearProgressBars(),
      ],
    );
  }

  // Circular Indicators - Visual skill levels in circles
  Widget _buildCircularIndicators() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: skills.asMap().entries.map((entry) {
        int index = entry.key;
        var skill = entry.value;
        return _CircularSkillIndicator(
          skillName: skill['name'],
          percentage: skill['percentage'],
          icon: skill['icon'],
          color: skill['color'],
          animation: _animations[index],
          isDarkMode: widget.isDarkMode,
        );
      }).toList(),
    );
  }

  // Linear Progress Bars - Detailed skill breakdown with bars
  Widget _buildLinearProgressBars() {
    return Column(
      children: skills.asMap().entries.map((entry) {
        int index = entry.key;
        var skill = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _LinearSkillIndicator(
            skillName: skill['name'],
            percentage: skill['percentage'],
            icon: skill['icon'],
            color: skill['color'],
            animation: _animations[index],
            isDarkMode: widget.isDarkMode,
          ),
        );
      }).toList(),
    );
  }
}

// ============================================
// Circular Skill Indicator Widget
// ============================================
class _CircularSkillIndicator extends StatefulWidget {
  final String skillName;
  final double percentage;
  final IconData icon;
  final Color color;
  final Animation<double> animation;
  final bool isDarkMode;

  const _CircularSkillIndicator({
    required this.skillName,
    required this.percentage,
    required this.icon,
    required this.color,
    required this.animation,
    required this.isDarkMode,
  });

  @override
  State<_CircularSkillIndicator> createState() =>
      _CircularSkillIndicatorState();
}

class _CircularSkillIndicatorState extends State<_CircularSkillIndicator> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.color.withOpacity(0.3)
                    : Colors.black.withOpacity(widget.isDarkMode ? 0.3 : 0.1),
                blurRadius: _isHovered ? 20 : 10,
                offset: Offset(0, _isHovered ? 6 : 4),
              ),
            ],
          ),
          child: AnimatedBuilder(
            animation: widget.animation,
            builder: (context, child) {
              return CustomPaint(
                painter: _CircularProgressPainter(
                  progress: widget.animation.value * widget.percentage,
                  color: widget.color,
                  isDarkMode: widget.isDarkMode,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.icon, color: widget.color, size: 32),
                      const SizedBox(height: 8),
                      Text(
                        '${(widget.animation.value * widget.percentage * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: widget.isDarkMode
                              ? AppTheme.textLight
                              : AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.skillName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: widget.isDarkMode
                              ? AppTheme.textGrey
                              : AppTheme.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ============================================
// Custom Painter for Circular Progress
// ============================================
class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final bool isDarkMode;

  _CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final strokeWidth = 6.0;

    // Background circle
    final backgroundPaint = Paint()
      ..color = isDarkMode
          ? AppTheme.primaryBlue.withOpacity(0.1)
          : AppTheme.primaryBlue.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc with gradient
    final progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [color, color.withOpacity(0.6)],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      2 * math.pi * progress, // Sweep angle based on progress
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// ============================================
// Linear Skill Indicator Widget
// ============================================
class _LinearSkillIndicator extends StatefulWidget {
  final String skillName;
  final double percentage;
  final IconData icon;
  final Color color;
  final Animation<double> animation;
  final bool isDarkMode;

  const _LinearSkillIndicator({
    required this.skillName,
    required this.percentage,
    required this.icon,
    required this.color,
    required this.animation,
    required this.isDarkMode,
  });

  @override
  State<_LinearSkillIndicator> createState() => _LinearSkillIndicatorState();
}

class _LinearSkillIndicatorState extends State<_LinearSkillIndicator> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? widget.color.withOpacity(0.5)
                : (widget.isDarkMode
                      ? AppTheme.primaryBlue.withOpacity(0.1)
                      : AppTheme.primaryBlue.withOpacity(0.05)),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.color.withOpacity(0.2)
                  : Colors.black.withOpacity(widget.isDarkMode ? 0.2 : 0.08),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 6 : 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skill name, icon, and percentage
            Row(
              children: [
                // Icon with gradient background
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [widget.color, widget.color.withOpacity(0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),

                // Skill name
                Expanded(
                  child: Text(
                    widget.skillName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: widget.isDarkMode
                          ? AppTheme.textLight
                          : AppTheme.textDark,
                    ),
                  ),
                ),

                // Percentage text
                AnimatedBuilder(
                  animation: widget.animation,
                  builder: (context, child) {
                    return Text(
                      '${(widget.animation.value * widget.percentage * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: widget.color,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Animated progress bar
            AnimatedBuilder(
              animation: widget.animation,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      // Background bar
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: widget.isDarkMode
                              ? AppTheme.primaryBlue.withOpacity(0.1)
                              : AppTheme.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      // Progress bar with gradient
                      FractionallySizedBox(
                        widthFactor: widget.animation.value * widget.percentage,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.color,
                                widget.color.withOpacity(0.7),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: widget.color.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
