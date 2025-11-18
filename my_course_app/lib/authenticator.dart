import 'dart:convert';
import 'package:bcrypt/bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Authenticator {
  static const String _storageKey = 'flutter.registered_users';

  Future<bool> authenticate(String accountID, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_storageKey);
      if (usersJson == null || usersJson.isEmpty) {
      
        return false;
      }
     
      final lines = LineSplitter.split(usersJson);
      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final parts = line.split(',');
        if (parts.length >= 4) {
          final storedAccountID = parts[2].trim();
          final storedHashedPassword = parts[3].trim();
          if (storedAccountID == accountID) {
            
            final isValid = BCrypt.checkpw(password, storedHashedPassword);
            if (isValid) {
       
            } else {
          
            }
            return isValid;
          }
        }
      }

      return false;
    } catch (e) {
     
      return false;
    }
  }
 
  String hashPassword(String password) {
  
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  String hashPasswordWithRounds(String password, int rounds) {
   
    return BCrypt.hashpw(password, BCrypt.gensalt(logRounds: rounds));
  }
}