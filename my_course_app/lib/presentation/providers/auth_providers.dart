import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../authenticator.dart';
import '../../data/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
// This line tells build_runner to generate code for this file
part 'auth_providers.g.dart';
/// Provides the Authenticator instance (file reader)
/// This replaces: Provider<Authenticator>(create: (_) => Authenticator())
@riverpod
Authenticator authenticator(Ref ref) {
  return Authenticator();
}
/// Provides the AuthRepository implementation
/// This replaces: ProxyProvider<Authenticator, AuthRepository>(...)
@riverpod
AuthRepository authRepository(Ref ref) {
  final authenticator = ref.watch(authenticatorProvider);
  return AuthRepositoryImpl(authenticator);
}
