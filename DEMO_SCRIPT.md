# 🎬 USJ-R Course Enrollment App - Complete Demo Script

## Table of Contents
1. [Quick Data Linking Explanation (1 minute)](#quick-data-linking)
2. [App Walkthrough (6-7 minutes)](#app-walkthrough)
3. [Data Synchronization Technical Deep Dive (3-4 minutes)](#data-synchronization)

---

## Quick Data Linking

### "How Data Links Across Screens" (2-3 minutes)

"Let me explain how data flows and stays synchronized across all screens using **Riverpod** (our Provider logic).

---

#### **The Provider Logic (ChangeNotifier Alternative)**

"We use **Riverpod** instead of ChangeNotifier. Here's the provider that manages enrollment data:

```dart
// enrollment_provider.dart
@riverpod
Future<List<Enrollment>> studentEnrollments(StudentEnrollmentsRef ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  
  final enrollmentService = EnrollmentStorageService();
  return await enrollmentService.getEnrollments(user['accountID']);
}

@riverpod
class EnrollmentActions extends _$EnrollmentActions {
  @override
  FutureOr<void> build() {}
  
  Future<String> enrollInSubject(String subjectId) async {
    final enrollmentService = EnrollmentStorageService();
    final result = await enrollmentService.enrollSubject(subjectId);
    
    // THIS IS KEY: Refresh all screens watching this provider
    ref.invalidate(studentEnrollmentsProvider);
    return result;
  }
}
```

**Why Riverpod over ChangeNotifier?**
- Compile-time safety
- No BuildContext needed
- Automatic disposal
- Better for our architecture"

---

#### **SCREEN 1: Browse Subjects (UPDATE Data - Enroll)**

```dart
// subject_list_screen.dart
class SubjectListScreen extends ConsumerWidget {
  Future<void> _enrollInSubject(WidgetRef ref, String subjectId) async {
    // WRITE: Enroll in subject
    final result = await ref.read(
      enrollmentActionsProvider.notifier
    ).enrollInSubject(subjectId);
    
    // Provider automatically refreshes all watching screens!
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result))
    );
  }
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrollmentsAsync = ref.watch(studentEnrollmentsProvider);
    
    return enrollmentsAsync.when(
      data: (enrollments) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final subject = subjects[index];
            final isEnrolled = enrollments.any((e) => e.subjectId == subject.id);
            
            return SubjectCard(
              subject: subject,
              trailing: isEnrolled 
                ? Chip(label: Text('Already Enrolled'))
                : ElevatedButton(
                    onPressed: () => _enrollInSubject(ref, subject.id),
                    child: Text('Enroll'),
                  ),
            );
          },
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  }
}
```

---

#### **SCREEN 2: Dashboard (READ Data - Display Units)**

```dart
// enrollment_home_screen.dart
class EnrollmentHomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // READ: Watch enrollment data
    final enrollmentsAsync = ref.watch(studentEnrollmentsProvider);
    
    return enrollmentsAsync.when(
      data: (enrollments) {
        // Calculate from enrollment data
        final totalUnits = enrollments.fold<int>(
          0, (sum, e) => sum + e.units
        );
        final remainingUnits = 24 - totalUnits;
        
        return Column(
          children: [
            Text('${enrollments.length} Courses Enrolled'),
            Text('Units: $totalUnits / 24'),
            Text('$remainingUnits units remaining'),
            LinearProgressIndicator(
              value: totalUnits / 24,
            ),
          ],
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  }
}
```

---

#### **SCREEN 3: My Courses (READ Data - Display List)**

```dart
// my_subjects_screen.dart
class MySubjectsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // READ: Watch the SAME provider as Dashboard
    final enrollmentsAsync = ref.watch(studentEnrollmentsProvider);
    
    return enrollmentsAsync.when(
      data: (enrollments) {
        return Column(
          children: [
            Text('${enrollments.length} Courses'),
            Text('${enrollments.fold(0, (sum, e) => sum + e.units)} / 24 Units'),
            Expanded(
              child: ListView.builder(
                itemCount: enrollments.length,
                itemBuilder: (context, index) {
                  final enrollment = enrollments[index];
                  return ListTile(
                    title: Text(enrollment.subjectName),
                    subtitle: Text('${enrollment.units} Units • ${enrollment.schedule}'),
                    trailing: Text(enrollment.instructor),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  }
}
```

---

#### **The Synchronization Flow**

```
User clicks "Enroll" in Browse Subjects (Screen 1)
         ↓
enrollmentActionsProvider.enrollInSubject()
         ↓
EnrollmentStorageService.enrollSubject() → Saves to SharedPreferences
         ↓
ref.invalidate(studentEnrollmentsProvider) → Triggers refresh
         ↓
ALL screens watching studentEnrollmentsProvider rebuild:
         ↓
    ┌────┴────┬────────────┐
    ↓         ↓            ↓
Screen 1   Screen 2    Screen 3
(Browse)  (Dashboard) (My Courses)
    ↓         ↓            ↓
Updates   Updates     Updates
badge     units       list
```

**The Magic:** 
- **One provider** (`studentEnrollmentsProvider`)
- **Three screens** watching it
- **One update** (`ref.invalidate()`)
- **All screens refresh automatically**

That's reactive programming with Riverpod!"

---

## App Walkthrough

### Introduction (30 seconds)
"Hello! Today I'll be demonstrating the **USJ-R Course Enrollment App**, a Flutter-based mobile application designed for students at the University of San Jose-Recoletos. This app streamlines the course enrollment process with an intuitive interface featuring USJ-R's official colors - Deep Green and Gold - and their motto *Caritas et Scientia*."

---

### 1. Welcome Screen (20 seconds)
**[Show the landing page]**

"When you first open the app, you're greeted with the USJ-R logo and two main options:
- The **Login** button in deep green for returning students
- The **Register** button in gold for new users

Let's start by creating a new account."

---

### 2. Student Registration (1 minute)
**[Click Register button]**

"The registration form is comprehensive yet user-friendly. Let me walk you through each field:

**Personal Information:**
- First, I'll enter my **First Name**: 'Ralf Andre'
- Then my **Last Name**: 'Ebuna'

**Email Address:**
- Notice the email field only accepts USJ-R institutional emails
- I'll type: 'ralfandre.ebuna.23@usjr.edu.ph'
- The system automatically keeps it lowercase - no auto-capitalization

**Account ID / Student ID:**
- This field is restricted to exactly **10 digits only**
- I'll enter: '2023031886'
- Try typing letters - see? It won't accept them. Only numbers 0-9.

**Course Selection:**
- From the dropdown, I'll select 'BSIT - Bachelor of Science in Information Technology'
- Notice the text size is optimized for readability

**Year Level:**
- I'll select 'Year 1'

**Password:**
- Now for the password. Watch the strength indicator as I type
- I'll enter a strong password with uppercase, lowercase, numbers, and special characters
- See the green bar? That indicates a 'Strong' password
- I'll confirm the password in the next field

**Terms of Service:**
- Finally, I'll check the box to accept the Terms of Service

**[Click Create Account]**

Great! The account is created successfully. Notice the green notification at the bottom."

---

### 3. Login Screen (30 seconds)
**[Navigate to Login]**

"Now let's log in with our newly created account.

- I'll enter my **Account ID**: '2023031886' - again, only digits are accepted
- Then my **Password**
- I can toggle the eye icon to show or hide the password

**[Click Login]**

Perfect! We're logged in successfully."

---

### 4. Course Enrollment Dashboard (45 seconds)
**[Show the main dashboard]**

"This is the enrollment dashboard - the heart of the application.

**Enrollment Status Card** (in orange):
- Shows my enrollment is **ACTIVE**
- I'm currently enrolled in **3 Courses**
- I've used **9 out of 24 units** - that's the maximum allowed
- **15 units remaining** for this semester

**Academic Information Section:**
- **View Grades**: Check academic performance
- **Enrollment Schedule**: View important enrollment dates

**Navigation Buttons:**
- **My Courses**: View all enrolled subjects
- **Browse Courses**: Explore and enroll in available subjects

Let's browse some courses."

---

### 5. Browse Subjects (1 minute 30 seconds)
**[Click Browse Courses]**

"The subject browsing interface has three tabs:

#### **1st Year Tab:**
**[Show 1st Year subjects]**

'Here we see first-year subjects:
- **PROG-1: Programming 1** - Already enrolled (green badge)
  - 3 Units, 26/30 slots available
  - Schedule: MWF 8:30-9:30 AM
  - Instructor: Engr. Carmel Tejana
  
- **WEBDEV: Web Development** - Subject Full (red badge)
  - 3 Units, 30/30 slots (no availability)
  - Schedule: TTH 10:30-12:30 PM
  - Instructor: Prof. Bandalan

- **COMPMATH: Computing Math Prep** - Already enrolled
  - 3 Units, 29/30 slots
  - Schedule: MWF 1:30-2:30 PM
  - Instructor: Prof. Leni Robredo'

#### **Major Tab:**
**[Switch to Major tab]**

'Major subjects are displayed with the same clear card layout showing all relevant information.'

#### **Minor Tab:**
**[Switch to Minor tab]**

'Here are the general education courses:
- **GE-MMW: Mathematics in the Modern World** - Already enrolled
  - 3 Units, 29/30 slots
  - Schedule: TTH 1:30-2:30 PM
  - Instructor: Prof. Rodrigo Duterte

- **REED: Readings in Philippine History** - Available!
  - 3 Units, 38/50 slots available
  - Schedule: MWF 10:30-11:30 AM
  - Instructor: Prof. Maria Santos
  - Notice the green **Enroll** button

- **EP 1: English Proficiency Level 1** - Also available
  - 3 Units, 22/30 slots
  - Schedule: MWF 2:00-3:00 PM
  - Instructor: Prof. Jennifer Lopez

Each card clearly shows:
- Course code and status
- Number of units
- Available slots
- Schedule and instructor
- Action button (Enroll or status)'

---

### 6. My Courses (45 seconds)
**[Click back and navigate to My Courses]**

"Let's check my enrolled courses.

**Header shows:**
- **3 Courses** enrolled
- **9/24 Units** used

**My Enrolled Subjects:**
1. **PROG-1: Programming 1**
   - 3 Units, 26/30 slots
   - MWF 8:30-9:30 AM
   - Engr. Carmel Tejana

2. **GE-MMW: Mathematics in the Modern World**
   - 3 Units, 29/30 slots
   - TTH 1:30-2:30 PM
   - Prof. Rodrigo Duterte

3. **COMPMATH: Computing Math Prep**
   - 3 Units, 29/30 slots
   - MWF 1:30-2:30 PM
   - Prof. Leni Robredo

Notice the blue info box: 'To drop this course, please contact the admin' - ensuring proper enrollment management."

---

### 7. User Profile (30 seconds)
**[Navigate to Profile]**

"Finally, let's view the student profile.

**Profile Header** (deep green background):
- User initials: 'RE'
- Full name: **Ralf Andre Ebuna**
- Student ID: **2023031886**

**Personal Information:**
- **Email**: ralfandre.ebuna.23@usjr.edu.ph
- **Degree Program**: BSIT - Bachelor of Science in Information Technology
- **Year Level**: Year 1

The info box reminds students to contact admin for profile updates, maintaining data integrity."

---

### Closing (30 seconds)

"This USJ-R Course Enrollment App demonstrates:

✅ **Secure Authentication** with bcrypt password hashing
✅ **Input Validation** - 10-digit student IDs, USJ-R email validation
✅ **Real-time Unit Tracking** - maximum 24 units enforcement
✅ **Intuitive UI** - USJ-R brand colors and modern design
✅ **SOLID Principles** - clean architecture and maintainable code

The app successfully streamlines the enrollment process for USJ-R students with a user-friendly, secure, and efficient system.

Thank you for watching!"

---

## 📝 Key Features to Highlight During Demo:

1. **Security**: Password hashing, email validation, student ID validation
2. **User Experience**: Clean UI, color-coded status badges, real-time feedback
3. **Validation**: 10-digit student ID (digits only), USJ-R email requirement
4. **Enrollment Management**: Unit tracking, slot availability, duplicate prevention
5. **Design**: USJ-R official colors (Green #1B5E20 and Gold #FFD700)
6. **Architecture**: SOLID principles, Riverpod state management

**Total Demo Time: ~6-7 minutes**

---

# Data Synchronization

## "How Data Syncs Between Screens - Technical Deep Dive" (3-4 minutes)

---

### **Part 1: Provider Logic & State Management** (1 minute)

"Let me show you the **actual code** that makes data synchronization work across screens.

We use **Riverpod** instead of ChangeNotifier for state management. Here's why it's better:
- Compile-time safety
- No need for BuildContext
- Automatic disposal
- Better testability

**The Core Providers:**

```dart
// 1. Current User Provider - Stores logged-in user
final currentUserProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

// 2. Enrollment Provider - Loads student's enrollments
@riverpod
Future<List<Enrollment>> studentEnrollments(StudentEnrollmentsRef ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  
  final enrollmentService = EnrollmentStorageService();
  return await enrollmentService.getEnrollments(user['accountID']);
}

// 3. Enrollment Action - Handles enrolling in subjects
@riverpod
class EnrollmentActions extends _$EnrollmentActions {
  @override
  FutureOr<void> build() {}
  
  Future<String> enrollInSubject(String subjectId) async {
    final enrollmentService = EnrollmentStorageService();
    final result = await enrollmentService.enrollSubject(subjectId);
    
    // Refresh enrollment data across all screens
    ref.invalidate(studentEnrollmentsProvider);
    return result;
  }
}
```

**Key Point:** When `ref.invalidate()` is called, ALL screens watching that provider automatically update!"

---

### **Part 2: Registration → Login → Profile Flow** (1 minute 30 seconds)

#### **SCREEN 1: Registration (Write Data)**

```dart
// register_screen.dart - Lines 132-160
void _register() async {
  // Step 1: Hash password with bcrypt
  final passwordHash = await _authenticator.hashPassword(
    _passwordController.text
  );
  
  // Step 2: Save to SharedPreferences
  final success = await _userStorage.saveUser(
    firstName: _firstNameController.text.trim(),
    lastName: _lastNameController.text.trim(),
    accountID: _accountIDController.text.trim(),
    hashedPassword: passwordHash,  // ← Bcrypt hashed
    email: _emailController.text.trim(),
    course: _selectedCourse,
    year: _selectedYear,
  );
  
  // Step 3: Show success message
  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration Successful!'))
    );
  }
}
```

**Behind the scenes in UserStorageService:**
```dart
// user_storage_service.dart
Future<bool> saveUser({...}) async {
  final prefs = await SharedPreferences.getInstance();
  
  final userData = {
    'firstName': firstName,
    'lastName': lastName,
    'accountID': accountID,
    'hashedPassword': hashedPassword,  // ← Stored securely
    'email': email,
    'course': course,
    'year': year,
  };
  
  // Save as JSON with key: user_[accountID]
  return await prefs.setString(
    'user_$accountID',
    jsonEncode(userData)
  );
}
```

---

#### **SCREEN 2: Login (Read & Verify Data)**

```dart
// login_viewmodel.dart
Future<LoginResult> login(String accountID, String password) async {
  // Step 1: Retrieve user data from SharedPreferences
  final userData = await _userStorage.getUser(accountID);
  
  if (userData == null) {
    return LoginResult.failure('Account not found');
  }
  
  // Step 2: Verify password with bcrypt
  final isValid = await _authenticator.verifyPassword(
    password,
    userData['hashedPassword']
  );
  
  if (!isValid) {
    return LoginResult.failure('Invalid password');
  }
  
  // Step 3: Store user in Riverpod state (THIS IS THE KEY!)
  ref.read(currentUserProvider.notifier).state = userData;
  
  return LoginResult.success();
}
```

**What happens here:**
- Data retrieved from SharedPreferences
- Password verified with bcrypt
- User data stored in `currentUserProvider`
- **Now ALL screens can access this data!**"

---

#### **SCREEN 3: Profile (Read from Provider)**

```dart
// profile_screen.dart (simplified)
class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read user data from provider
    final user = ref.watch(currentUserProvider);
    
    if (user == null) return LoginScreen();
    
    return Scaffold(
      body: Column(
        children: [
          // Display synchronized data
          Text('${user['firstName']} ${user['lastName']}'),  // 'Ralf Andre Ebuna'
          Text(user['accountID']),                           // '2023031886'
          Text(user['email']),                               // 'ralfandre.ebuna.23@usjr.edu.ph'
          Text(user['course']),                              // 'BSIT'
          Text('Year ${user['year']}'),                      // 'Year 1'
        ],
      ),
    );
  }
}
```

**The Magic:** Profile doesn't store data - it **watches** the provider. When login updates the provider, profile automatically displays the new data!"

---

### **Part 3: Enrollment Data Synchronization** (1 minute)

#### **SCREEN 1: Browse Subjects (Write - Enroll Action)**

```dart
// subject_list_screen.dart
class SubjectListScreen extends ConsumerWidget {
  Future<void> _enrollInSubject(WidgetRef ref, String subjectId) async {
    // Call enrollment action
    final result = await ref.read(
      enrollmentActionsProvider.notifier
    ).enrollInSubject(subjectId);
    
    // Provider automatically refreshes - no manual update needed!
  }
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch enrollments to show "Already Enrolled" badge
    final enrollmentsAsync = ref.watch(studentEnrollmentsProvider);
    
    return enrollmentsAsync.when(
      data: (enrollments) => ListView.builder(...),
      loading: () => CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  }
}
```

#### **SCREEN 2: Dashboard (Read - Display Unit Count)**

```dart
// enrollment_home_screen.dart
class EnrollmentHomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch enrollments for real-time updates
    final enrollmentsAsync = ref.watch(studentEnrollmentsProvider);
    
    return enrollmentsAsync.when(
      data: (enrollments) {
        // Calculate total units
        final totalUnits = enrollments.fold<int>(
          0, (sum, e) => sum + e.units
        );
        
        return Column(
          children: [
            Text('${enrollments.length} Courses Enrolled'),  // "3 Courses"
            Text('Units: $totalUnits / 24'),                 // "9 / 24"
            Text('${24 - totalUnits} units remaining'),      // "15 units remaining"
          ],
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  }
}
```

#### **SCREEN 3: My Courses (Read - Display Enrolled List)**

```dart
// my_subjects_screen.dart
class MySubjectsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the SAME provider as Dashboard
    final enrollmentsAsync = ref.watch(studentEnrollmentsProvider);
    
    return enrollmentsAsync.when(
      data: (enrollments) => ListView.builder(
        itemCount: enrollments.length,
        itemBuilder: (context, index) {
          final enrollment = enrollments[index];
          return SubjectCard(
            title: enrollment.subjectName,    // "Programming 1"
            units: enrollment.units,          // 3
            schedule: enrollment.schedule,    // "MWF 8:30-9:30 AM"
            instructor: enrollment.instructor, // "Engr. Carmel Tejana"
          );
        },
      ),
      loading: () => CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  }
}
```

---

### **Part 4: The Synchronization Magic** (30 seconds)

"Here's how it all works together:

**When you enroll in a subject:**

```
1. Browse Subjects → Click "Enroll"
   ↓
2. enrollmentActionsProvider.enrollInSubject()
   ↓
3. EnrollmentStorageService.enrollSubject() → Saves to SharedPreferences
   ↓
4. ref.invalidate(studentEnrollmentsProvider) → Triggers refresh
   ↓
5. ALL screens watching studentEnrollmentsProvider automatically rebuild:
   - Dashboard updates: "9/24 units" → "12/24 units"
   - My Courses adds new subject to list
   - Browse Subjects shows "Already Enrolled" badge
```

**No manual updates needed - Riverpod handles everything reactively!**"

---

### **Part 5: Why This Architecture is Superior** (30 seconds)

"This architecture demonstrates **SOLID principles**:

**Single Responsibility:**
- `UserStorageService` → Only handles user data persistence
- `EnrollmentStorageService` → Only handles enrollment data
- `Authenticator` → Only handles password hashing
- Providers → Only manage state
- Screens → Only display UI

**Dependency Inversion:**
- Screens depend on **Providers** (abstraction)
- NOT on **Storage Services** (concrete implementation)

**Benefits:**
✅ **One source of truth** - SharedPreferences
✅ **Reactive updates** - Riverpod auto-refreshes
✅ **Type-safe** - Compile-time checks
✅ **Secure** - Bcrypt password hashing
✅ **Maintainable** - Clear separation of concerns
✅ **Testable** - Easy to mock providers"

---

## 📊 Final Visual Summary

```
┌──────────────────────────────────────────────────────────────┐
│                    DATA FLOW DIAGRAM                          │
└──────────────────────────────────────────────────────────────┘

REGISTRATION                    LOGIN                    PROFILE
     ↓                           ↓                          ↓
[Hash Password]            [Verify Password]         [Read Provider]
     ↓                           ↓                          ↓
[UserStorageService]       [UserStorageService]      currentUserProvider
     ↓                           ↓                          ↓
[SharedPreferences] ←──────────→ [SharedPreferences]       ↓
     ↓                           ↓                    [Display Data]
[Save JSON]                [Load JSON]
                                ↓
                      [Update Provider State]
                                ↓
                      currentUserProvider.state = userData
                                ↓
                    ┌───────────┴───────────┐
                    ↓                       ↓
              DASHBOARD                 MY COURSES
                    ↓                       ↓
         [Watch Provider]          [Watch Provider]
                    ↓                       ↓
    studentEnrollmentsProvider ←─── SAME PROVIDER
                    ↓                       ↓
              [Display Units]         [Display List]

When enrollment changes:
ref.invalidate(studentEnrollmentsProvider)
         ↓
All screens auto-refresh! ✨
```

---

## 🎬 Closing Statement (20 seconds)

"In summary, our USJ-R Course Enrollment App uses:

1. **SharedPreferences** for persistent storage
2. **Bcrypt** for secure password hashing
3. **Riverpod** for reactive state management
4. **SOLID principles** for clean architecture

Data flows seamlessly from Registration → Login → Profile, and enrollment updates synchronize instantly across Dashboard, Browse Subjects, and My Courses.

This ensures **data consistency, security, and excellent user experience** throughout the application.

Thank you!"

---

## 📋 Quick Reference

### Total Script Times:
- **App Walkthrough**: 6-7 minutes
- **Technical Deep Dive**: 3-4 minutes
- **Complete Demo**: 9-11 minutes

### Key Technologies:
- **Frontend**: Flutter with Material Design 3
- **State Management**: Riverpod (function-based providers)
- **Local Storage**: SharedPreferences
- **Security**: Bcrypt password hashing
- **Architecture**: SOLID principles, Clean Architecture

### Demo Flow:
1. Welcome Screen → Registration
2. Login → Dashboard
3. Browse Subjects (3 tabs)
4. My Courses
5. Profile
6. Technical explanation of data synchronization
