import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:crypto/crypto.dart';


class Authenticator {
  final String usersAssetPath;

  Authenticator({this.usersAssetPath = 'assets/newStudent.txt'});

  Future<bool> authenticate(String accountID, String password) async {
    final content = await rootBundle.loadString(usersAssetPath);
    final hashedInput = hashPassword(password);

    final lines = LineSplitter.split(content);
    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      final parts = line.split(',');
      if (parts.length >= 4) {
        final fileAccountID = parts[2].trim();
        final fileHashedPassword = parts[3].trim();
        if (fileAccountID == accountID && fileHashedPassword == hashedInput) {
          return true;
        }
      }
    }
    return false;
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString(); 
  }
}