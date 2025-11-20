# USJ-R Course Enrollment App

A Flutter-based course enrollment system for the University of San Jose-Recoletos (USJ-R).

## 🎓 About

This application allows USJ-R students to:
- Browse available subjects by category (1st Year, Major, Minor)
- Enroll in subjects with unit limit validation (max 24 units)
- View enrolled subjects and manage enrollments
- Track enrollment status and unit counts

## 🎨 Design

**Official USJ-R Brand Colors:**
- Primary: Deep Green (#1B5E20)
- Accent: Gold (#FFD700)
- Motto: *Caritas et Scientia*

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android SDK for mobile development
- Chrome/Edge for web development

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/flutter-course-enrollment-app.git
   cd flutter-course-enrollment-app/my_course_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate provider files**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   # For web
   flutter run -d edge
   
   # For Android
   flutter run -d <device_id>
   ```

## 📱 Features

### Authentication
- Student registration with USJ-R email validation
- Secure login with hashed passwords
- Account ID validation (10-digit student ID)

### Enrollment Management
- Browse subjects by category
- Real-time unit tracking (0/24 units)
- Enrollment confirmation dialogs
- Subject capacity checking
- Drop subject requests (pending admin approval)

### UI/UX
- Responsive design for mobile and web
- Material Design 3
- Google Fonts (Poppins & Inter)
- Loading states and error handling
- Success/error notifications

## 🏗️ Architecture

### State Management
- **Riverpod** for state management
- Function-based providers for actions
- Auto-generated providers with `riverpod_annotation`

### Data Storage
- **SharedPreferences** for local data persistence
- JSON serialization for complex objects

### Project Structure
```
lib/
├── core/
│   └── constants/
│       ├── app_colors.dart
│       ├── app_strings.dart
│       └── app_constants.dart
├── domain/
│   └── models/
│       ├── subject.dart
│       ├── enrollment.dart
│       └── enrolled_subject.dart
├── presentation/
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── enrollment_home_screen.dart
│   │   ├── subject_list_screen.dart
│   │   └── my_subjects_screen.dart
│   └── widgets/
│       ├── subject_card.dart
│       ├── custom_app_bar.dart
│       └── enrollment_confirmation_dialog.dart
├── providers/
│   ├── enrollment_provider.dart
│   ├── subject_provider.dart
│   └── auth_provider.dart
└── services/
    ├── enrollment_storage_service.dart
    ├── subject_storage_service.dart
    └── user_storage_service.dart
```

## 🐛 Known Issues & Fixes

### Critical Bug Fix (Nov 19, 2025)
**Issue:** Provider disposal error during enrollment
**Solution:** Changed from class-based to function-based providers

📖 **See [BUGFIX_DOCUMENTATION.md](my_course_app/BUGFIX_DOCUMENTATION.md) for detailed information**

### Windows Path Issue
If you encounter Gradle build errors with spaces in the path:
```
Failed to create parent directory 'C:\Users\WINDOWS 11\...'
```

**Solution:** Move project to a path without spaces:
```bash
C:\Projects\flutter-course-enrollment-app
```

## 🔧 Development

### After Modifying Providers
Always regenerate the `.g.dart` files:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Hot Reload vs Hot Restart
- **Hot Reload (r):** UI changes only
- **Hot Restart (R):** Logic changes, provider updates
- **Full Rebuild:** After major changes or errors

### Testing
```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📦 Dependencies

### Core
- `flutter_riverpod: ^2.6.1` - State management
- `riverpod_annotation: ^2.6.1` - Provider code generation
- `shared_preferences: ^2.3.3` - Local storage

### UI
- `google_fonts: ^6.2.1` - Typography
- `crypto: ^3.0.6` - Password hashing

### Development
- `build_runner: ^2.4.14` - Code generation
- `riverpod_generator: ^2.6.3` - Provider generation

## 🎯 Roadmap

- [ ] Admin panel for enrollment approval
- [ ] Email notifications
- [ ] Schedule conflict detection
- [ ] Grade viewing
- [ ] Payment integration
- [ ] Mobile app optimization


## 📄 License

This project is developed for educational purposes for the University of San Jose-Recoletos.

## 🆘 Support

For issues or questions:
1. Check [BUGFIX_DOCUMENTATION.md](my_course_app/BUGFIX_DOCUMENTATION.md)
2. Review error messages carefully
3. Ensure all dependencies are installed
4. Verify `.g.dart` files are generated
