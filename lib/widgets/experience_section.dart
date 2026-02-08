import 'package:flutter/material.dart';
import '../theme.dart';

class ExperienceSection extends StatelessWidget {
  final bool isDarkMode;
  const ExperienceSection({Key? key, required this.isDarkMode})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 80 : 120,
      ),
      color: isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 80),
          _buildTimeline(isMobile),
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
            'Experience',
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

  Widget _buildTimeline(bool isMobile) {
    return Column(
      children: AppConstants.experiences.map((exp) {
        final index = AppConstants.experiences.indexOf(exp);
        return _ExperienceItem(
          experience: exp,
          isLast: index == AppConstants.experiences.length - 1,
          isMobile: isMobile,
          isDarkMode: isDarkMode,
        );
      }).toList(),
    );
  }
}

class _ExperienceItem extends StatefulWidget {
  final Map<String, dynamic> experience;
  final bool isLast;
  final bool isMobile;
  final bool isDarkMode;

  const _ExperienceItem({
    required this.experience,
    required this.isLast,
    required this.isMobile,
    required this.isDarkMode,
  });

  @override
  State<_ExperienceItem> createState() => _ExperienceItemState();
}

class _ExperienceItemState extends State<_ExperienceItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!widget.isMobile) ...[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.experience['period'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.experience['company'],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 40),
          ],
          _buildTimelineNode(),
          const SizedBox(width: 40),
          Expanded(flex: 5, child: _buildExperienceCard()),
        ],
      ),
    );
  }

  Widget _buildTimelineNode() {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isDarkMode ? AppTheme.darkBackground : Colors.white,
            border: Border.all(color: AppTheme.primaryBlue, width: 4),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryBlue.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        if (!widget.isLast)
          Expanded(
            child: Container(
              width: 2,
              color: AppTheme.primaryBlue.withOpacity(0.2),
            ),
          )
        else
          const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildExperienceCard() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 40),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: widget.isDarkMode
              ? AppTheme.cardDark.withOpacity(_isHovered ? 0.6 : 0.4)
              : Colors.white.withOpacity(_isHovered ? 1.0 : 0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryBlue.withOpacity(0.3)
                : Colors.white.withOpacity(0.05),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? AppTheme.glowShadow(AppTheme.primaryBlue)
              : AppTheme.premiumShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isMobile) ...[
              Text(
                widget.experience['period'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
              const SizedBox(height: 5),
            ],
            Text(
              widget.experience['role'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            if (widget.isMobile) ...[
              const SizedBox(height: 5),
              Text(
                widget.experience['company'],
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            const SizedBox(height: 15),
            Text(
              widget.experience['description'],
              style: TextStyle(
                fontSize: 16,
                height: 1.7,
                color: AppTheme.textGrey,
              ),
            ),
            const SizedBox(height: 25),
            ...(widget.experience['achievements'] as List).map(
              (achievement) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        achievement,
                        style: TextStyle(
                          fontSize: 15,
                          color: widget.isDarkMode
                              ? AppTheme.textLight.withOpacity(0.8)
                              : AppTheme.textDim,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
