import 'package:bcrypt/bcrypt.dart';

/// Service responsible for password hashing operations
/// Follows Single Responsibility Principle
class PasswordHasher {
  /// Hash a password with BCrypt using default rounds
  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  /// Hash a password with specific rounds
  String hashPasswordWithRounds(String password, int rounds) {
    return BCrypt.hashpw(password, BCrypt.gensalt(logRounds: rounds));
  }

  /// Verify a password against a hash
  bool verifyPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }
}
