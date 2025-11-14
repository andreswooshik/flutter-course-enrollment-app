import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/enrollment_home_screen.dart';
import 'presentation/screens/subject_list_screen.dart';
import 'presentation/screens/my_subjects_screen.dart';
import 'services/subject_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize subjects on app start
  print('🔄 Initializing subjects...');
  final subjectService = SubjectStorageService();
  await subjectService.initializeSubjects();
  print('✅ Subjects initialized!');
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'USJR Enrollment App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1565C0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          primary: const Color(0xFF1565C0),
          secondary: const Color(0xFF42A5F5),
        ),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1565C0),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const EnrollmentHomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/subject-list': (context) => const SubjectListScreen(),
        '/my-subjects': (context) => const MySubjectsScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}