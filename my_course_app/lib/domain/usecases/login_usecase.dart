import '../repositories/auth_repository.dart';

/// Use case for login operation
/// Following Single Responsibility Principle
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  /// Executes login with validation
  Future<LoginResult> execute(String accountId, String password) async {
    // Validate inputs
    if (accountId.trim().isEmpty) {
      return LoginResult.failure('Account ID cannot be empty');
    }
    
    if (password.isEmpty) {
      return LoginResult.failure('Password cannot be empty');
    }

    try {
      final success = await _authRepository.authenticate(accountId, password);
      
      if (success) {
        return LoginResult.success();
      } else {
        return LoginResult.failure('Invalid credentials');
      }
    } catch (e) {
      return LoginResult.error('An error occurred during login');
    }
  }
}

/// Result of login operation
class LoginResult {
  final bool isSuccess;
  final String? message;
  final LoginResultType type;

  LoginResult._({
    required this.isSuccess,
    this.message,
    required this.type,
  });

  factory LoginResult.success() => LoginResult._(
        isSuccess: true,
        type: LoginResultType.success,
      );

  factory LoginResult.failure(String message) => LoginResult._(
        isSuccess: false,
        message: message,
        type: LoginResultType.failure,
      );

  factory LoginResult.error(String message) => LoginResult._(
        isSuccess: false,
        message: message,
        type: LoginResultType.error,
      );
}

enum LoginResultType { success, failure, error }