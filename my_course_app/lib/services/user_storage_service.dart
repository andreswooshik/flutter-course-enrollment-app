import 'package:shared_preferences/shared_preferences.dart';
import '../domain/repositories/user_repository.dart';
/// Implementation of UserRepository using SharedPreferences
/// Follows Dependency Inversion Principle
class UserStorageService implements UserRepository {
  static const String _storageKey = 'flutter.registered_users';
  /// Save user data to SharedPreferences (CSV format)
  @override
  Future<bool> saveUser({
    required String firstName,
    required String lastName,
    required String accountID,
    required String hashedPassword,
    String? email,
    String? course,
    int? year,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Get existing users
      final existingData = prefs.getString(_storageKey) ?? '';
      // Check for duplicate account ID
      if (existingData.isNotEmpty) {
        final lines = existingData.split('\n');
        for (final line in lines) {
          if (line.trim().isEmpty) continue;
          final parts = line.split(',');
          if (parts.length >= 3 && parts[2].trim() == accountID) {
            return false; // Duplicate found
          }
        }
      }
      // Create new user entry (CSV format: firstName,lastName,accountID,hashedPassword,email,course,year)
      final userEntry = '$firstName,$lastName,$accountID,$hashedPassword,${email ?? ''},${course ?? ''},${year ?? ''}\n';
      // Append to existing data
      final newData = existingData + userEntry;
      // Save to SharedPreferences
      await prefs.setString(_storageKey, newData);
      return true;
    } catch (e) {
      return false;
    }
  }
  /// Get storage information
  Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      return {
        'type': 'Browser Local Storage (SharedPreferences)',
        'keys': keys.toList(),
        'userStorageKey': _storageKey,
      };
    } catch (e) {
      return {
        'type': 'Unknown',
        'keys': [],
        'userStorageKey': _storageKey,
      };
    }
  }
  /// Get total number of registered users
  @override
  Future<int> getUserCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_storageKey) ?? '';
      if (data.isEmpty) {
        return 0;
      }
      final lines = data.split('\n').where((line) => line.trim().isNotEmpty);
      final count = lines.length;
      return count;
    } catch (e) {
      return 0;
    }
  }
  /// Clear all user data (for testing purposes)
  @override
  Future<bool> clearAllUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
      return true;
    } catch (e) {
      return false;
    }
  }
  /// Get all users data (for admin purposes - be careful with this!)
  Future<String> getAllUsersData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_storageKey) ?? '';
      return data;
    } catch (e) {
      return '';
    }
  }
  @override
  Future<Map<String, String>?> getUserByAccountId(String accountId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_storageKey) ?? '';
      if (data.isEmpty) return null;
      final lines = data.split('\n');
      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final parts = line.split(',');
        if (parts.length >= 7 && parts[2].trim() == accountId) {
          // Return all user data including hashed password
          return {
            'firstName': parts[0].trim(),
            'lastName': parts[1].trim(),
            'accountId': parts[2].trim(),
            'hashedPassword': parts[3].trim(),
            'email': parts.length > 4 ? parts[4].trim() : '',
            'course': parts.length > 5 ? parts[5].trim() : '',
            'year': parts.length > 6 ? parts[6].trim() : '',
          };
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  /// Get user profile by account ID
  @override
  Future<Map<String, String>?> getUserProfile(String accountId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_storageKey) ?? '';
      if (data.isEmpty) return null;
      final lines = data.split('\n');
      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final parts = line.split(',');
        if (parts.length >= 7 && parts[2].trim() == accountId) {
          // Found the user! Return profile data
          return {
            'firstName': parts[0].trim(),
            'lastName': parts[1].trim(),
            'accountId': parts[2].trim(),
            'email': parts.length > 4 ? parts[4].trim() : '',
            'course': parts.length > 5 ? parts[5].trim() : '',
            'year': parts.length > 6 ? parts[6].trim() : '',
          };
        }
      }
      return null; // User not found
    } catch (e) {
      return null;
    }
  }
}
