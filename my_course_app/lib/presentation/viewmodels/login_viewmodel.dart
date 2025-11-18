import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/usecases/login_usecase.dart';
import '../providers/login_providers.dart';
part 'login_viewmodel.g.dart';
@immutable
class LoginState {
  final bool isLoading;
  final bool showLoginForm;
  final bool obscurePassword;
  final String? errorMessage;
  const LoginState({
    this.isLoading = false,
    this.showLoginForm = false,
    this.obscurePassword = true,
    this.errorMessage,
  });
  LoginState copyWith({
    bool? isLoading,
    bool? showLoginForm,
    bool? obscurePassword,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      showLoginForm: showLoginForm ?? this.showLoginForm,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() {
    return const LoginState();
  }
  void toggleLoginForm() {
    state = state.copyWith(showLoginForm: !state.showLoginForm);
  }
  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }
  Future<LoginResult> login(String accountId, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final loginUseCase = ref.read(loginUseCaseProvider);
      final result = await loginUseCase.execute(accountId, password);
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return LoginResult.error('An error occurred during login');
    }
  }
  void reset() {
    state = const LoginState();
  }
}
