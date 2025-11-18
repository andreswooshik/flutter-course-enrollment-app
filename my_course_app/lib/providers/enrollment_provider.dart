import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/enrollment.dart';
import '../domain/models/subject.dart';
import '../domain/models/enrolled_subject.dart';
import '../services/enrollment_storage_service.dart';
import '../utils/constants.dart';
import 'auth_provider.dart';
import 'subject_provider.dart';
part 'enrollment_provider.g.dart';
@riverpod
EnrollmentStorageService enrollmentStorageService(Ref ref) {  
  return EnrollmentStorageService();
}
@riverpod
Future<List<Enrollment>> studentEnrollments(Ref ref) async {  
  final authRepo = ref.watch(authRepositoryProvider);
  final studentId = await authRepo.getCurrentUserId();
  if (studentId == null) return [];
  final service = ref.watch(enrollmentStorageServiceProvider);
  return await service.getStudentEnrollments(studentId);
}
@riverpod
Future<List<EnrolledSubject>> enrolledSubjects(Ref ref) async {  
  final enrollments = await ref.watch(studentEnrollmentsProvider.future);
  final subjectService = ref.watch(subjectStorageServiceProvider);
  final List<EnrolledSubject> enrolledSubjects = [];
  for (final enrollment in enrollments) {
    final subject = await subjectService.getSubjectById(enrollment.subjectId);
    if (subject != null) {
      enrolledSubjects.add(EnrolledSubject(
        subject: subject,
        enrollment: enrollment,
      ));
    }
  }
  return enrolledSubjects;
}
@riverpod
Future<int> totalEnrolledUnits(Ref ref) async { 
  final enrolledSubjects = await ref.watch(enrolledSubjectsProvider.future);
  // Only count units for subjects that are fully enrolled (not pending drop)
  return enrolledSubjects
      .where((es) => es.status == 'enrolled')
      .fold<int>(0, (sum, es) => sum + es.subject.units);
}
@riverpod
class EnrollmentActions extends _$EnrollmentActions {
  @override
  void build() {
    // No async initialization needed here
    // Subjects are already initialized in main.dart
  }
  Future<String> enrollInSubject(String subjectId) async {
    try {
      final authRepo = ref.read(authRepositoryProvider);
      final studentId = await authRepo.getCurrentUserId();
      if (studentId == null) {
        return 'Not logged in';
      }
      final enrollmentService = ref.read(enrollmentStorageServiceProvider);
      final subjectService = ref.read(subjectStorageServiceProvider);
      final isAlreadyEnrolled = await enrollmentService.isEnrolled(studentId, subjectId);
      if (isAlreadyEnrolled) {
        return AppConstants.alreadyEnrolled;
      }
      final subject = await subjectService.getSubjectById(subjectId);
      if (subject == null) {
        return 'Subject not found';
      }
      if (subject.isFull) {
        return AppConstants.subjectFull;
      }
      final currentUnits = await ref.read(totalEnrolledUnitsProvider.future);
      final afterEnrollment = currentUnits + subject.units;
      if (afterEnrollment > AppConstants.maxUnitsPerSemester) {
        return AppConstants.unitLimitExceeded;
      }
      final success = await enrollmentService.addEnrollment(studentId, subjectId);
      if (!success) {
        return 'Failed to enroll';
      }
      await subjectService.updateSubjectEnrollment(subjectId, subject.enrolled + 1);
      ref.invalidate(studentEnrollmentsProvider);
      ref.invalidate(enrolledSubjectsProvider);
      ref.invalidate(totalEnrolledUnitsProvider);
      ref.invalidate(firstYearSubjectsProvider);
      ref.invalidate(majorSubjectsProvider);
      ref.invalidate(minorSubjectsProvider);
      return AppConstants.enrollSuccess;
    } catch (e) {
      print('❌ Enrollment error: $e');
      return 'An error occurred: $e';
    }
  }
  Future<String> dropSubject(String subjectId) async {
    try {
      final authRepo = ref.read(authRepositoryProvider);
      final studentId = await authRepo.getCurrentUserId();
      if (studentId == null) {
        return 'Not logged in';
      }
      final enrollmentService = ref.read(enrollmentStorageServiceProvider);
      final subjectService = ref.read(subjectStorageServiceProvider);
      final subject = await subjectService.getSubjectById(subjectId);
      if (subject == null) {
        return 'Subject not found';
      }
      // Update status to 'pending_drop' instead of removing
      final success = await enrollmentService.updateEnrollmentStatus(studentId, subjectId, 'pending_drop');
      if (!success) {
        return 'Failed to drop subject';
      }
      // Don't decrease enrolled count yet - wait for admin approval
      // await subjectService.updateSubjectEnrollment(subjectId, subject.enrolled - 1);
      ref.invalidate(studentEnrollmentsProvider);
      ref.invalidate(enrolledSubjectsProvider);
      ref.invalidate(totalEnrolledUnitsProvider);
      ref.invalidate(firstYearSubjectsProvider);
      ref.invalidate(majorSubjectsProvider);
      ref.invalidate(minorSubjectsProvider);
      return 'Drop request submitted - pending admin approval';
    } catch (e) {
      return 'An error occurred';
    }
  }
}
