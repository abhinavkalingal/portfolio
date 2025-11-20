# 🚀 Flutter Portfolio Website

A professional, modern, and responsive portfolio website built with Flutter for showcasing skills, projects, and experience as a Flutter Developer.

## ✨ Features

- **Modern & Clean Design**: Beautiful gradient colors and professional layout
- **Fully Responsive**: Works seamlessly on desktop, tablet, and mobile devices
- **Dark/Light Theme Toggle**: Switch between dark and light modes
- **Smooth Animations**: Elegant scroll animations and hover effects
- **Interactive Navigation**: Fixed navigation bar with smooth scrolling to sections
- **Project Showcase**: Display your best projects with descriptions and GitHub links
- **Contact Form**: Functional contact form (demo mode)
- **Social Links**: Quick access to email, LinkedIn, and GitHub

## 📱 Sections

1. **Navigation Bar**: Logo, menu items (Home, About, Skills, Projects, Contact), and theme toggle
2. **Hero Section**: Profile picture, name, job title, and introduction with call-to-action buttons
3. **About Section**: Personal introduction, education background, and career goals
4. **Skills Section**: Technical skills displayed with animated icon cards
5. **Projects Section**: Portfolio projects with descriptions, tech stack, and GitHub links
6. **Contact Section**: Contact information and message form
7. **Footer**: Quick links, contact info, and copyright

## 🎨 Design Features

- **Gradient Backgrounds**: Beautiful blue gradient theme (#2196F3)
- **Modern Typography**: Poppins font family for clean, modern look
- **Hover Effects**: Interactive cards and buttons with smooth transitions
- **Shadow Effects**: Professional card shadows for depth
- **Rounded Corners**: Consistent 16px border radius throughout
- **No Neon Effects**: Clean, professional appearance (as per user preference)

## 🛠️ Technologies Used

- **Flutter**: Cross-platform framework
- **Dart**: Programming language
- **Material Design**: UI components
- **url_launcher**: For opening external links

## 📂 Project Structure

```
lib/
├── main.dart                    # Main entry point and app structure
├── theme.dart                   # Theme configuration and constants
└── widgets/
    ├── navigation_bar.dart      # Custom navigation bar
    ├── hero_section.dart        # Hero/landing section
    ├── about_section.dart       # About me section
    ├── skills_section.dart      # Technical skills section
    ├── projects_section.dart    # Projects showcase section
    ├── contact_section.dart     # Contact form and info
    └── footer_section.dart      # Footer component
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.9.2 or higher)
- Dart SDK
- Chrome browser (for web development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/abhi_portfolio.git
cd abhi_portfolio
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:

**For Web:**
```bash
flutter run -d chrome
```

**For Mobile (Android):**
```bash
flutter run -d android
```

**For Mobile (iOS):**
```bash
flutter run -d ios
```

## 🎯 Customization

### Update Personal Information

Edit the constants in `lib/theme.dart`:

```dart
class AppConstants {
  static const String name = "Your Name";
  static const String jobTitle = "Your Job Title";
  static const String email = "your.email@example.com";
  static const String linkedin = "https://linkedin.com/in/yourprofile";
  static const String github = "https://github.com/yourusername";
  
  // Update about text, education, skills, and projects
}
```

### Change Theme Colors

Modify colors in `lib/theme.dart`:

```dart
class AppTheme {
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color gradientStart = Color(0xFF6A11CB);
  static const Color gradientEnd = Color(0xFF2575FC);
  // Add more custom colors
}
```

### Add Profile Picture

Replace the placeholder image URL in `lib/widgets/hero_section.dart`:

```dart
image: const DecorationImage(
  image: NetworkImage('YOUR_IMAGE_URL'),
  fit: BoxFit.cover,
),
```

Or use local assets:
1. Add image to `assets/images/` folder
2. Update `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
```
3. Use `AssetImage('assets/images/profile.jpg')`

## 📝 Key Components

### Responsive Layout
The app uses `MediaQuery` to determine screen size and adjusts layout accordingly:
- Desktop: Side-by-side layouts
- Mobile: Stacked vertical layouts

### Smooth Scrolling
Navigation items trigger smooth scrolling to specific sections using `GlobalKey` and `Scrollable.ensureVisible()`.

### Theme Toggle
Dark and light themes are implemented with state management, allowing users to switch preferences.

### Hover Effects
Interactive cards use `MouseRegion` and `AnimationController` for smooth hover animations.

## 🎓 Education & Certification

- Higher Secondary Education - GMHSS Perinthalmanna (2023-2025)
- Flutter Development Course - Oxdo Technologies Pvt Ltd, Kerala (2025)

## 📧 Contact

- **Email**: abhi@example.com
- **LinkedIn**: [linkedin.com/in/abhi](https://linkedin.com/in/abhi)
- **GitHub**: [github.com/abhi](https://github.com/abhi)

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for UI guidelines
- Oxdo Technologies for Flutter development training

---

**Built with Flutter ❤️**

© 2025 Abhi | Flutter Developer
