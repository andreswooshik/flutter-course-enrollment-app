/// Abstract repository for authentication operations
/// Following Repository Pattern and Dependency Inversion Principle
abstract class AuthRepository {
  /// Authenticates user with account ID and password
  /// Returns true if authentication is successful
  Future<bool> authenticate(String accountId, String password);
  /// Logs out the current user
  Future<void> logout();
  /// Checks if user is currently authenticated
  Future<bool> isAuthenticated();
}