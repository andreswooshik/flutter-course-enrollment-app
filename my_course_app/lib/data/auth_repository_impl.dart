import '../../domain/repositories/auth_repository.dart';
import '../../authenticator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Authenticator _authenticator;
  static const String _loggedInUserKey = 'logged_in_user';

  AuthRepositoryImpl(this._authenticator);

  @override
  Future<bool> authenticate(String accountId, String password) async {
    try {
      final result = await _authenticator.authenticate(accountId, password);
      
      if (result) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_loggedInUserKey, accountId);
      }
      
      return result;
    } catch (e) {
      throw Exception('Authentication failed');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_loggedInUserKey);
    } catch (e) {
      throw Exception('Logout failed');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString(_loggedInUserKey);
      return userId != null && userId.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get current logged-in user account ID
  Future<String?> getCurrentUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_loggedInUserKey);
    } catch (e) {
      return null;
    }
  }
}