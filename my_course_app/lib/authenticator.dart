import 'dart:convert';
import 'package:bcrypt/bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Authenticator {
  static const String _storageKey = 'flutter.registered_users';
  /// Authenticate user against browser storage
  Future<bool> authenticate(String accountID, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_storageKey);
      if (usersJson == null || usersJson.isEmpty) {
        // ignore: prefer_const_constructors
        // Logger.debug('No users found in storage');
        return false;
      }
      // Logger.debug('Checking authentication for account: $accountID');
      // Parse the stored users (CSV format: firstName,lastName,accountID,hashedPassword,course,year)
      final lines = LineSplitter.split(usersJson);
      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final parts = line.split(',');
        if (parts.length >= 4) {
          final storedAccountID = parts[2].trim();
          final storedHashedPassword = parts[3].trim();
          if (storedAccountID == accountID) {
            // Logger.debug('Found user: $accountID');
            // Logger.debug('Verifying password...');
            // Verify password with BCrypt
            final isValid = BCrypt.checkpw(password, storedHashedPassword);
            if (isValid) {
              // Logger.success('Password verified for user: $accountID');
            } else {
              // Logger.debug('Password verification failed for user: $accountID');
            }
            return isValid;
          }
        }
      }
      // Logger.debug('Account ID not found: $accountID');
      return false;
    } catch (e) {
      // Logger.error('Authentication error', e, stackTrace);
      return false;
    }
  }
  /// Hash a password with BCrypt
  String hashPassword(String password) {
    // Logger.debug('Hashing password with BCrypt');
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }
  /// Hash a password with specific rounds
  String hashPasswordWithRounds(String password, int rounds) {
    // Logger.debug('Hashing password with BCrypt (rounds: $rounds)');
    return BCrypt.hashpw(password, BCrypt.gensalt(logRounds: rounds));
  }
}