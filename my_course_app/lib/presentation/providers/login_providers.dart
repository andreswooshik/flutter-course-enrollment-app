import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_providers.dart';

part 'login_providers.g.dart';

@riverpod
LoginUseCase loginUseCase(ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginUseCase(authRepository);
}
