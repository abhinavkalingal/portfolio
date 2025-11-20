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
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.cardDark.withOpacity(0.95)
            : AppTheme.cardLight.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: isDarkMode
                ? AppTheme.primaryBlue.withOpacity(0.2)
                : AppTheme.primaryBlue.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          if (isMobile) _buildMobileMenu(context) else _buildDesktopMenu(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return ShaderMask(
      shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
      child: const Text(
        'Abhinav',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDesktopMenu() {
    return Row(
      children: [
        _AnimatedNavItem(
          title: 'Home',
          index: 0,
          onTap: onMenuTap,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(width: 30),
        _AnimatedNavItem(
          title: 'About',
          index: 1,
          onTap: onMenuTap,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(width: 30),
        _AnimatedNavItem(
          title: 'Skills',
          index: 2,
          onTap: onMenuTap,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(width: 30),
        _AnimatedNavItem(
          title: 'Projects',
          index: 3,
          onTap: onMenuTap,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(width: 30),
        _AnimatedNavItem(
          title: 'Contact',
          index: 4,
          onTap: onMenuTap,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(width: 30),
        _buildThemeToggle(),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return Row(
      children: [
        _buildThemeToggle(),
        const SizedBox(width: 8),
        _HamburgerMenuButton(
          onPressed: () => _showMobileDrawer(context),
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

  Widget _buildThemeToggle() {
    return _ThemeToggleButton(isDarkMode: isDarkMode, onToggle: onThemeToggle);
  }

  void _showMobileDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppTheme.textGrey.withOpacity(0.5)
                    : AppTheme.textGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _buildMobileMenuItem(context, 'Home', 0, Icons.home),
            _buildMobileMenuItem(context, 'About', 1, Icons.person),
            _buildMobileMenuItem(context, 'Skills', 2, Icons.code),
            _buildMobileMenuItem(context, 'Projects', 3, Icons.work),
            _buildMobileMenuItem(context, 'Contact', 4, Icons.mail),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(
    BuildContext context,
    String title,
    int index,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppTheme.primaryBlue,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: isDarkMode ? AppTheme.textLight : AppTheme.textDark,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onMenuTap(index);
      },
    );
  }
}

class _AnimatedNavItem extends StatefulWidget {
  final String title;
  final int index;
  final Function(int) onTap;
  final bool isDarkMode;

  const _AnimatedNavItem({
    required this.title,
    required this.index,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  State<_AnimatedNavItem> createState() => _AnimatedNavItemState();
}

class _AnimatedNavItemState extends State<_AnimatedNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 16,
                fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                fontFamily: 'Poppins',
                color: _isHovered
                    ? AppTheme.primaryBlue
                    : (widget.isDarkMode
                        ? AppTheme.textLight
                        : AppTheme.textDark),
                letterSpacing: _isHovered ? 0.5 : 0,
              ),
              child: Text(widget.title),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: 2,
              width: _isHovered ? 30 : 0,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onToggle;

  const _ThemeToggleButton({required this.isDarkMode, required this.onToggle});

  @override
  State<_ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<_ThemeToggleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onToggle(!widget.isDarkMode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.primaryBlue.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: _isHovered
                ? AppTheme.primaryBlue
                : (widget.isDarkMode ? AppTheme.textLight : AppTheme.textDark),
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _HamburgerMenuButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isDarkMode;

  const _HamburgerMenuButton({
    required this.onPressed,
    required this.isDarkMode,
  });

  @override
  State<_HamburgerMenuButton> createState() => _HamburgerMenuButtonState();
}

class _HamburgerMenuButtonState extends State<_HamburgerMenuButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.primaryBlue.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.menu,
            color: _isHovered
                ? AppTheme.primaryBlue
                : (widget.isDarkMode ? AppTheme.textLight : AppTheme.textDark),
            size: 24,
          ),
        ),
      ),
    );
  }
}
