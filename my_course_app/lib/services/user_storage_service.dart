import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing persistent user data storage
/// Uses SharedPreferences for cross-platform support (including web)
class UserStorageService {
  static const String _storageKey = 'registered_users';

  /// Save a new user to storage
  /// Format: firstName,lastName,accountID,hashedPassword,course,year
  Future<bool> saveUser({
    required String firstName,
    required String lastName,
    required String accountID,
    required String hashedPassword,
    String? course,
    int? year,
  }) async {
    try {
      // Check if user already exists
      if (await userExists(accountID)) {
        return false;
      }

      // Get existing users
      final prefs = await SharedPreferences.getInstance();
      final existingData = prefs.getString(_storageKey) ?? '';
      
      // Create CSV line for new user (include course and year)
      final userData = '$firstName,$lastName,$accountID,$hashedPassword,${course ?? 'N/A'},${year ?? 0}';
      
      // Append to existing data
      final newData = existingData.isEmpty 
          ? userData 
          : '$existingData\n$userData';
      
      // Save to storage
      await prefs.setString(_storageKey, newData);
      
      return true;
    } catch (e) {
      print('Error saving user: $e');
      return false;
    }
  }

  /// Check if a user with the given accountID already exists
  Future<bool> userExists(String accountID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_storageKey) ?? '';
      
      if (data.isEmpty) return false;

      final lines = LineSplitter.split(data);

      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final parts = line.split(',');
        if (parts.length >= 3) {
          final fileAccountID = parts[2].trim();
          if (fileAccountID == accountID) {
            return true;
          }
        }
      }
      
      return false;
    } catch (e) {
      print('Error checking if user exists: $e');
      return false;
    }
  }

  /// Get all registered users
  Future<List<Map<String, String>>> getAllUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_storageKey) ?? '';
      
      if (data.isEmpty) return [];

      final lines = LineSplitter.split(data);
      final users = <Map<String, String>>[];

      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final parts = line.split(',');
        if (parts.length >= 4) {
          users.add({
            'firstName': parts[0].trim(),
            'lastName': parts[1].trim(),
            'accountID': parts[2].trim(),
            'hashedPassword': parts[3].trim(),
            'course': parts.length > 4 ? parts[4].trim() : 'N/A',
            'year': parts.length > 5 ? parts[5].trim() : '0',
          });
        }
      }

      return users;
    } catch (e) {
      print('Error getting all users: $e');
      return [];
    }
  }

  /// Get the count of registered users
  Future<int> getUserCount() async {
    final users = await getAllUsers();
    return users.length;
  }

  /// Clear all user data (use with caution!)
  Future<bool> clearAllUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
      return true;
    } catch (e) {
      print('Error clearing users: $e');
      return false;
    }
  }

  /// Export users data as CSV string
  Future<String> exportUsersAsCSV() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_storageKey) ?? '';
    } catch (e) {
      print('Error exporting users: $e');
      return '';
    }
  }

  /// Get storage info for debugging
  Future<String> getStorageInfo() async {
    return 'Browser Local Storage (SharedPreferences) - Key: $_storageKey';
  }
}
