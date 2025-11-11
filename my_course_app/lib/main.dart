import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Data & Domain imports
import 'authenticator.dart';
import 'data/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login_usecase.dart';

// Presentation imports
import 'presentation/viewmodels/login_viewmodel.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Layer 1: Data Source (File-based authenticator)
        Provider<Authenticator>(
          create: (_) => Authenticator(),
        ),
        
        // Layer 2: Repository (Data access abstraction)
        ProxyProvider<Authenticator, AuthRepository>(
          update: (_, authenticator, __) => AuthRepositoryImpl(authenticator),
        ),
        
        // Layer 3: Use Case (Business logic)
        ProxyProvider<AuthRepository, LoginUseCase>(
          update: (_, authRepository, __) => LoginUseCase(authRepository),
        ),
        
        // Layer 4: ViewModel (State management)
        ChangeNotifierProxyProvider<LoginUseCase, LoginViewModel>(
          create: (context) {
            final loginUseCase = Provider.of<LoginUseCase>(context, listen: false);
            return LoginViewModel(loginUseCase);
          },
          update: (_, loginUseCase, previous) =>
              previous ?? LoginViewModel(loginUseCase),
        ),
      ],
      child: MaterialApp(
        title: 'USJR Course Enrollment App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
          useMaterial3: true,
        ),
        home: Consumer<LoginViewModel>(
          builder: (context, viewModel, _) {
            return LoginScreen(viewModel: viewModel);
          },
        ),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}