/// Abstract repository for user data operations
/// Following Repository Pattern and Dependency Inversion Principle
abstract class UserRepository {
  /// Get user by account ID
  /// Returns user data map or null if not found
  Future<Map<String, String>?> getUserByAccountId(String accountId);
  /// Save a new user
  /// Returns true if successful, false if user already exists
  Future<bool> saveUser({
    required String firstName,
    required String lastName,
    required String accountID,
    required String hashedPassword,
    String? email,
    String? course,
    int? year,
  });
  /// Get total number of registered users
  Future<int> getUserCount();
  /// Get user profile by account ID
  Future<Map<String, String>?> getUserProfile(String accountId);
  /// Clear all users (for testing)
  Future<bool> clearAllUsers();
}
