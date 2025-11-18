import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/enrollment.dart';


class EnrollmentStorageService {
  static const String _enrollmentsKey = 'flutter.enrollments';

  
  Future<List<Enrollment>> getStudentEnrollments(String studentId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final enrollmentsJson = prefs.getString(_enrollmentsKey);

      if (enrollmentsJson == null || enrollmentsJson.isEmpty) {
        return [];
      }

      final List<dynamic> enrollmentsList = jsonDecode(enrollmentsJson);
      final allEnrollments = enrollmentsList
          .map((json) => Enrollment.fromJson(json))
          .toList();

      return allEnrollments
          .where((e) => e.studentId == studentId && e.status != 'dropped')
          .toList();
    } catch (e) {
      print('❌ Error getting student enrollments: $e');
      return [];
    }
  }

 
  Future<bool> isEnrolled(String studentId, String subjectId) async {
    final enrollments = await getStudentEnrollments(studentId);
    return enrollments.any((e) => e.subjectId == subjectId && e.status == 'enrolled');
  }

 
  Future<bool> addEnrollment(String studentId, String subjectId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final enrollmentsJson = prefs.getString(_enrollmentsKey);

      List<Enrollment> enrollments = [];
      if (enrollmentsJson != null && enrollmentsJson.isNotEmpty) {
        final List<dynamic> enrollmentsList = jsonDecode(enrollmentsJson);
        enrollments = enrollmentsList
            .map((json) => Enrollment.fromJson(json))
            .toList();
      }

   
      final enrollment = Enrollment(
        id: '${studentId}_${subjectId}_${DateTime.now().millisecondsSinceEpoch}',
        studentId: studentId,
        subjectId: subjectId,
        enrolledAt: DateTime.now(),
        status: 'enrolled',
      );

      enrollments.add(enrollment);

      
      final json = jsonEncode(enrollments.map((e) => e.toJson()).toList());
      await prefs.setString(_enrollmentsKey, json);

      return true;
    } catch (e) {
      print('❌ Error adding enrollment: $e');
      return false;
    }
  }

 
  Future<bool> removeEnrollment(String studentId, String subjectId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final enrollmentsJson = prefs.getString(_enrollmentsKey);

      if (enrollmentsJson == null || enrollmentsJson.isEmpty) {
        return false;
      }

      final List<dynamic> enrollmentsList = jsonDecode(enrollmentsJson);
      final enrollments = enrollmentsList
          .map((json) => Enrollment.fromJson(json))
          .toList();


      enrollments.removeWhere(
        (e) => e.studentId == studentId && e.subjectId == subjectId,
      );

      
      final json = jsonEncode(enrollments.map((e) => e.toJson()).toList());
      await prefs.setString(_enrollmentsKey, json);

      return true;
    } catch (e) {
      print('❌ Error removing enrollment: $e');
      return false;
    }
  }

  /// Update enrollment status (e.g., from 'enrolled' to 'pending_drop')
  Future<bool> updateEnrollmentStatus(String studentId, String subjectId, String newStatus) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final enrollmentsJson = prefs.getString(_enrollmentsKey);

      if (enrollmentsJson == null || enrollmentsJson.isEmpty) {
        return false;
      }

      final List<dynamic> enrollmentsList = jsonDecode(enrollmentsJson);
      final enrollments = enrollmentsList
          .map((json) => Enrollment.fromJson(json))
          .toList();

      // Find and update the enrollment
      bool found = false;
      final updatedEnrollments = enrollments.map((e) {
        if (e.studentId == studentId && e.subjectId == subjectId) {
          found = true;
          return Enrollment(
            id: e.id,
            studentId: e.studentId,
            subjectId: e.subjectId,
            enrolledAt: e.enrolledAt,
            status: newStatus,
          );
        }
        return e;
      }).toList();

      if (!found) return false;

      // Save updated enrollments
      final json = jsonEncode(updatedEnrollments.map((e) => e.toJson()).toList());
      await prefs.setString(_enrollmentsKey, json);

      return true;
    } catch (e) {
      print('❌ Error updating enrollment status: $e');
      return false;
    }
  }
}