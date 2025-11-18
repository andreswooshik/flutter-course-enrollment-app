import '../domain/repositories/user_repository.dart';
import 'password_hasher.dart';
class AuthenticationService {
  final UserRepository _userRepository;
  final PasswordHasher _passwordHasher;
  AuthenticationService(this._userRepository, this._passwordHasher);
  /// Authenticate user with account ID and password
  /// Returns true if credentials are valid
  Future<bool> authenticate(String accountID, String password) async {
    try {
      // Get user from repository
      final user = await _userRepository.getUserByAccountId(accountID);
      if (user == null) {
        return false;
      }
      // Extract hashed password from user data
      final hashedPassword = user['hashedPassword'];
      if (hashedPassword == null || hashedPassword.isEmpty) {
        return false;
      }
      // Verify password using password hasher
      return _passwordHasher.verifyPassword(password, hashedPassword);
    } catch (e) {
      return false;
    }
  }
}
