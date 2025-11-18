# 🎓 USJ-R Course Enrollment System

A modern Flutter application for managing student course enrollment at the University of San Jose-Recoletos (USJ-R).

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Dart](https://img.shields.io/badge/Dart-3.x-blue)
![State Management](https://img.shields.io/badge/State%20Management-Riverpod-green)

## 📋 Overview

The USJ-R Course Enrollment System is a comprehensive mobile application that allows students to register, browse available courses, enroll in subjects, and manage their academic profile. The application features a modern UI with USJ-R's official branding (Green and Gold) and implements industry-standard practices for state management and data persistence.

## ✨ Features

### Core Features
- 🔐 **Secure Authentication** - Login system with bcrypt password hashing
- 📝 **Student Registration** - Comprehensive registration form with validation
- 📚 **Course Browsing** - Browse courses organized by categories (1st Year, Major, Minor)
- ✅ **Course Enrollment** - Enroll in courses with unit limit tracking (24 units max)
- 👤 **Profile Management** - View and manage student information
- 💾 **Persistent Storage** - Data saved locally using SharedPreferences

### Advanced Features
- 📊 **Unit Tracking** - Real-time tracking of enrolled units
- 🎯 **Enrollment Status** - Track enrollment status for each course
- 🔄 **Drop Courses** - Contact admin to drop enrolled courses
- ✅ **Form Validation** - Comprehensive validation for all input fields
- 🎨 **USJ-R Branding** - Official university colors (Green #1B5E20, Gold #FFD700)
- 📱 **Responsive Design** - Works on various screen sizes

## 🏗️ Architecture

### Project Structure
```
lib/
├── core/
│   └── constants/
│       └── app_colors.dart          # Color constants
├── data/
│   └── sample_subjects.dart         # Sample course data
├── domain/
│   ├── models/                      # Data models
│   │   ├── student_profile.dart
│   │   ├── subject.dart
│   │   ├── enrollment.dart
│   │   └── enrolled_subject.dart
│   └── repositories/                # Repository interfaces
│       └── user_repository.dart
├── services/                        # Business logic layer
│   ├── authentication_service.dart
│   ├── enrollment_storage_service.dart
│   ├── password_hasher.dart
│   ├── subject_storage_service.dart
│   └── user_storage_service.dart
├── providers/                       # Riverpod state management
│   ├── enrollment_provider.dart
│   ├── student_profile_provider.dart
│   └── subject_provider.dart
├── presentation/                    # UI layer
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── enrollment_home_screen.dart
│   │   ├── subject_list_screen.dart
│   │   ├── my_subjects_screen.dart
│   │   └── profile_screen.dart
│   └── widgets/                     # Reusable UI components
│       ├── custom_app_bar.dart
│       ├── subject_card.dart
│       ├── enrolled_subject_card.dart
│       ├── enrollment_status_card.dart
│       └── bottom_bar.dart
└── main.dart                        # Application entry point
```

### Design Patterns
- **Repository Pattern** - Abstraction layer for data access
- **Provider Pattern** - State management using Riverpod
- **Clean Architecture** - Separation of concerns (Domain, Data, Presentation)
- **SOLID Principles** - Single Responsibility, Dependency Inversion

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| **Flutter 3.x** | Cross-platform UI framework |
| **Dart 3.x** | Programming language |
| **Riverpod** | State management solution |
| **SharedPreferences** | Local data persistence |
| **bcrypt** | Password hashing for security |
| **Google Fonts** | Typography (Poppins, Inter) |

## 📱 Screens

### 1. Login Screen
- User authentication
- Form validation
- Navigation to registration

### 2. Registration Screen (Student Info Form)
- First name, last name input
- Email validation (@usjr.edu.ph only)
- 10-digit student ID validation
- Password strength validation
- Course/degree selection
- Year level selection

### 3. Enrollment Home Screen (Dashboard)
- Enrollment status overview
- Unit tracking display
- Quick access to features
- Academic information section

### 4. Subject List Screen (Course Selection)
- Browse courses by category (tabs)
- View course details (instructor, schedule, capacity)
- Real-time unit tracking
- Enrollment confirmation dialog

### 5. My Subjects Screen (Enrollment Review)
- View enrolled courses
- Course details display
- Unit summary
- Drop course information

### 6. Profile Screen
- Student information display
- Full degree name
- Email and year level
- Logout functionality

## 🔄 Application Flow

```
┌─────────────┐
│   Login     │
└──────┬──────┘
       │
       ├──────────────┐
       │              │
       v              v
┌─────────────┐  ┌──────────────┐
│  Register   │  │     Home     │
│ (New User)  │  │  Dashboard   │
└──────┬──────┘  └──────┬───────┘
       │                │
       └────────┬───────┘
                │
                v
       ┌────────────────┐
       │  Browse        │
       │  Courses       │
       └────────┬───────┘
                │
                v
       ┌────────────────┐
       │  Enroll in     │
       │  Course        │
       └────────┬───────┘
                │
                v
       ┌────────────────┐
       │  My Courses    │
       │  (Review)      │
       └────────────────┘
```

## 🎯 State Management Flow

### Riverpod Providers

```dart
// Student Profile Provider
final currentStudentProfileProvider = FutureProvider<StudentProfile?>((ref) async {
  final service = ref.watch(userStorageServiceProvider);
  return await service.getUserProfile();
});

// Enrolled Subjects Provider
final enrolledSubjectsProvider = FutureProvider<List<EnrolledSubject>>((ref) async {
  // Returns list of enrolled subjects with status
});

// Total Units Provider (Computed State)
final totalEnrolledUnitsProvider = FutureProvider<int>((ref) async {
  final enrolledSubjects = await ref.watch(enrolledSubjectsProvider.future);
  return enrolledSubjects.fold(0, (sum, es) => sum + es.subject.units);
});
```

### Data Flow
1. **Registration**: User data → `UserStorageService` → SharedPreferences
2. **Enrollment**: Course selection → `EnrollmentProvider` → `EnrollmentStorageService`
3. **UI Updates**: Providers notify → UI rebuilds with `watch`
4. **State Reads**: UI reads state with `ref.watch(provider)`
5. **State Updates**: Actions update with `ref.read(provider.notifier).method()`

## ✅ Validation Rules

### Student ID
- Must be exactly **10 digits**
- Numbers only (no letters or special characters)
- Example: `2023031887`

### Email
- Must use **@usjr.edu.ph** domain only
- Format: `yourname@usjr.edu.ph`
- Case-insensitive validation

### Password
- Minimum **8 characters**
- Must contain:
  - At least one uppercase letter
  - At least one lowercase letter
  - At least one number
  - At least one special character

### Unit Limit
- Maximum **24 units** per enrollment period
- Real-time tracking and validation
- Warning when approaching limit

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Git

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

3. **Run the application**
   ```bash
   flutter run
   ```

### Running on Different Platforms

**Android Emulator:**
```bash
flutter run -d android
```

**iOS Simulator:**
```bash
flutter run -d ios
```

**Web Browser:**
```bash
flutter run -d chrome
```

**Windows Desktop:**
```bash
flutter run -d windows
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1        # State management
  shared_preferences: ^2.3.3      # Local storage
  bcrypt: ^1.1.3                  # Password hashing
  google_fonts: ^6.2.1            # Typography
```

## 🎨 Design System

### Color Palette (USJ-R Official)
- **Primary Green**: `#1B5E20` - Main brand color
- **Dark Green**: `#0D3D0F` - Headers and accents
- **Accent Gold**: `#FFD700` - Secondary brand color
- **Light Green**: `#4CAF50` - Success states

### Typography
- **Headings**: Poppins (Bold, Semi-bold)
- **Body Text**: Inter (Regular)
- **Labels**: Poppins (Medium)

### UI Components
- Rounded corners (8-12px border radius)
- Elevation and shadows for depth
- Consistent padding and spacing
- Material Design 3 principles

## 🧪 Testing

### Manual Testing Checklist
- [ ] Registration with valid data succeeds
- [ ] Registration with invalid email fails
- [ ] Registration with non-10-digit ID fails
- [ ] Login with correct credentials succeeds
- [ ] Login with wrong credentials fails
- [ ] Course enrollment updates unit count
- [ ] Cannot exceed 24 unit limit
- [ ] Profile displays full degree name
- [ ] Logout clears session
- [ ] Data persists after app restart

## 📝 Data Models

### StudentProfile
```dart
class StudentProfile {
  final String firstName;
  final String lastName;
  final String accountId;
  final String email;
  final String course;
  final String year;
}
```

### Subject (Course)
```dart
class Subject {
  final String id;
  final String code;
  final String name;
  final int units;
  final String instructor;
  final int capacity;
  final int enrolled;
  final String schedule;
  final SubjectType type;
}
```

### Enrollment
```dart
class Enrollment {
  final String studentId;
  final String subjectId;
  final DateTime enrollmentDate;
  final String status; // 'enrolled', 'pending_drop', 'dropped'
}
```

## 🔐 Security Features

- **Password Hashing**: bcrypt algorithm with salt
- **Input Validation**: All user inputs sanitized
- **Email Verification**: Domain restriction (@usjr.edu.ph)
- **Session Management**: Secure logout functionality

## 🐛 Known Issues & Limitations

- Drop course requires admin contact (not automated)
- No backend integration (local storage only)
- No real-time sync between devices
- Limited to 24 units per enrollment period

## 🚧 Future Enhancements

- [ ] Backend API integration
- [ ] Real-time notifications
- [ ] Grade viewing system
- [ ] Enrollment schedule calendar
- [ ] Payment integration
- [ ] Multi-semester support
- [ ] Admin dashboard
- [ ] Course prerequisites checking

## 👥 Contributors

- **Your Name** - Initial work and development

## 📄 License

This project is created for educational purposes as part of the Object-Oriented Programming course at the University of San Jose-Recoletos.

## 🙏 Acknowledgments

- University of San Jose-Recoletos for the project requirements
- Flutter team for the excellent framework
- Riverpod community for state management guidance

## 📞 Support

For questions or issues, please contact:
- Email: your.email@usjr.edu.ph
- GitHub Issues: [Project Issues](https://github.com/yourusername/repo/issues)

---

**Made with ❤️ for USJ-R** 🎓
