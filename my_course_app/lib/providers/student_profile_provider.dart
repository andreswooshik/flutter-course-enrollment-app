import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/student_profile.dart';
import '../services/user_storage_service.dart';
import '../data/auth_repository_impl.dart';
import 'auth_provider.dart';
part 'student_profile_provider.g.dart';
// Provider for UserStorageService
@riverpod
UserStorageService userStorageService(Ref ref) {
  return UserStorageService();
}
// Provider to get current student profile
@riverpod
Future<StudentProfile?> currentStudentProfile(Ref ref) async {
  // Get current user's account ID
  final authRepo = ref.watch(authRepositoryProvider);
  final accountId = await authRepo.getCurrentUserId();
  if (accountId == null) return null;
  // Get user profile from storage
  final userStorage = ref.watch(userStorageServiceProvider);
  final profileMap = await userStorage.getUserProfile(accountId);
  if (profileMap == null) return null;
  // Convert to StudentProfile model
  return StudentProfile.fromMap(profileMap);
}