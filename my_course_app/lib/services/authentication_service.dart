import '../domain/repositories/user_repository.dart';
import 'password_hasher.dart';
class AuthenticationService {
  final UserRepository _userRepository;
  final PasswordHasher _passwordHasher;
  AuthenticationService(this._userRepository, this._passwordHasher);

  Future<bool> authenticate(String accountID, String password) async {
    try {

      final user = await _userRepository.getUserByAccountId(accountID);
      if (user == null) {
        return false;
      }
 
      final hashedPassword = user['hashedPassword'];
      if (hashedPassword == null || hashedPassword.isEmpty) {
        return false;
      }
     
      return _passwordHasher.verifyPassword(password, hashedPassword);
    } catch (e) {
      return false;
    }
  }
}
