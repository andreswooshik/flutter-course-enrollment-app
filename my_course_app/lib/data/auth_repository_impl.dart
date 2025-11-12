import '../../domain/repositories/auth_repository.dart';
import '../../authenticator.dart';

/// Implementation of AuthRepository using the existing Authenticator
class AuthRepositoryImpl implements AuthRepository {
  final Authenticator _authenticator;

  AuthRepositoryImpl(this._authenticator);

  @override
  Future<bool> authenticate(String accountId, String password) async {
    try {
      final result = await _authenticator.authenticate(accountId, password);
      return result;
    } on Exception catch (e) {
      throw AuthException('Authentication failed: ${e.toString()}');
    } catch (e) {
      throw AuthException('Unexpected error during authentication: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    // Implement logout logic based on your Authenticator class
    // Example: await _authenticator.logout();
  }

  @override
  Future<bool> isAuthenticated() async {
    // Implement authentication check based on your Authenticator class
    // Example: return await _authenticator.isLoggedIn();
    return false;
  }
}

/// Custom exception for authentication errors
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}
