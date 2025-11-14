import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository_impl.dart';
import '../authenticator.dart';

part 'auth_provider.g.dart';

@riverpod
Authenticator authenticator(Ref ref) {  
  return Authenticator();
}

@riverpod
AuthRepositoryImpl authRepository(Ref ref) { 
  final authenticator = ref.watch(authenticatorProvider);
  return AuthRepositoryImpl(authenticator);
}
