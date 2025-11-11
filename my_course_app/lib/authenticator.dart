import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bcrypt/bcrypt.dart';

class Authenticator {
  final String usersAssetPath;

  Authenticator({this.usersAssetPath = 'assets/newStudent.txt'});

  /// Authenticate user with BCrypt password verification
  Future<bool> authenticate(String accountID, String password) async {
    final content = await rootBundle.loadString(usersAssetPath);
    final lines = LineSplitter.split(content);
    
    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      final parts = line.split(',');
      if (parts.length >= 4) {
        final fileAccountID = parts[2].trim();
        final fileHashedPassword = parts[3].trim();
        
        if (fileAccountID == accountID) {
          // BCrypt password verification
          return BCrypt.checkpw(password, fileHashedPassword);
        }
      }
    }
    return false;
  }

  /// Hash password with BCrypt (for registration/password updates)
  String hashPassword(String password) {
    // Generate salt with 10 rounds (good balance of security and speed)
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }
  
  /// Hash password with custom salt rounds
  String hashPasswordWithRounds(String password, int rounds) {
    return BCrypt.hashpw(password, BCrypt.gensalt(logRounds: rounds));
  }
}