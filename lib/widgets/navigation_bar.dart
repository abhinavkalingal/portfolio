import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';

class CustomNavigationBar extends StatelessWidget {
  final Function(int) onMenuTap;
  final bool isDarkMode;
  final Function(bool) onThemeToggle;

  const CustomNavigationBar({
    Key? key,
    required this.onMenuTap,
    required this.isDarkMode,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 1024;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 40,
        vertical: 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppTheme.darkBackground.withOpacity(0.4)
                  : Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.08),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLogo(),
                if (isMobile)
                  _buildMobileMenu(context)
                else
                  _buildDesktopMenu(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onMenuTap(0),
        child: Text(
          'ABHINAV',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            fontFamily: 'Poppins',
            color: AppTheme.primaryBlue,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopMenu() {
    return Row(
      children: [
        _NavItem(title: 'Home', index: 0, onTap: onMenuTap),
        _NavItem(title: 'Experience', index: 2, onTap: onMenuTap),
        _NavItem(title: 'About', index: 1, onTap: onMenuTap),
        _NavItem(title: 'Skills', index: 3, onTap: onMenuTap),
        _NavItem(title: 'Projects', index: 4, onTap: onMenuTap),
        _NavItem(title: 'Contact', index: 5, onTap: onMenuTap),
        const SizedBox(width: 15),
        _buildThemeToggle(),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return Row(
      children: [
        _buildThemeToggle(),
        const SizedBox(width: 5),
        IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: isDarkMode ? Colors.white : Colors.black,
            size: 24,
          ),
          onPressed: () => _showMobileDrawer(context),
        ),
      ],
    );
  }

  Widget _buildThemeToggle() {
    return IconButton(
      icon: Icon(
        isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round_rounded,
        size: 20,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      onPressed: () => onThemeToggle(!isDarkMode),
    );
  }

  void _showMobileDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppTheme.cardDark.withOpacity(0.95)
                : Colors.white.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMobileItem(context, 'Home', 0, Icons.home_rounded),
              _buildMobileItem(context, 'Experience', 2, Icons.history_rounded),
              _buildMobileItem(context, 'About', 1, Icons.person_rounded),
              _buildMobileItem(context, 'Skills', 3, Icons.code_rounded),
              _buildMobileItem(context, 'Projects', 4, Icons.work_rounded),
              _buildMobileItem(context, 'Contact', 5, Icons.mail_rounded),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileItem(
    BuildContext context,
    String title,
    int index,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryBlue, size: 22),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      onTap: () {
        Navigator.pop(context);
        onMenuTap(index);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final int index;
  final Function(int) onTap;

  const _NavItem({
    required this.title,
    required this.index,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.index),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: _isHovered
                  ? AppTheme.primaryBlue
                  : (isDarkMode
                        ? Colors.white.withOpacity(0.85)
                        : Colors.black.withOpacity(0.75)),
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
