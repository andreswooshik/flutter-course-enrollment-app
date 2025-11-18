import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/enrollment_home_screen.dart';
import 'presentation/screens/subject_list_screen.dart';
import 'presentation/screens/my_subjects_screen.dart';
import 'services/subject_storage_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF1B5E20),  
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20), 
          primary: const Color(0xFF1B5E20),    
          secondary: const Color(0xFFFFD700),  
        ),
        useMaterial3: true,
        
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.light().textTheme,
        ).copyWith(
    
          displayLarge: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B5E20),
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B5E20),
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1B5E20),
          ),
      
          titleLarge: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
    
          bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
    
          labelLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B5E20), 
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
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