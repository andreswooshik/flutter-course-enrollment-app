import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/subject.dart';
import '../data/sample_subjects.dart';
/// Service for managing subject data in local storage
class SubjectStorageService {
  static const String _subjectsKey = 'flutter.subjects';
  /// Initialize subjects with sample data if empty
  Future<void> initializeSubjects() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final subjectsJson = prefs.getString(_subjectsKey);
      if (subjectsJson == null || subjectsJson.isEmpty) {
        final subjects = SampleSubjects.getFirstYearSubjects();
        await _saveSubjects(subjects);
      }
    } catch (e) {
      // Silently fail
    }
  }
  /// Get all 1st year subjects
  Future<List<Subject>> getFirstYearSubjects() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final subjectsJson = prefs.getString(_subjectsKey);
      if (subjectsJson == null || subjectsJson.isEmpty) {
        return [];
      }
      final List<dynamic> subjectsList = jsonDecode(subjectsJson);
      return subjectsList.map((json) => Subject.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
  /// Get major subjects only
  Future<List<Subject>> getMajorSubjects() async {
    final subjects = await getFirstYearSubjects();
    return subjects.where((s) => s.type == SubjectType.major).toList();
  }
  /// Get minor subjects only
  Future<List<Subject>> getMinorSubjects() async {
    final subjects = await getFirstYearSubjects();
    return subjects.where((s) => s.type == SubjectType.minor).toList();
  }
  /// Get subject by ID
  Future<Subject?> getSubjectById(String subjectId) async {
    final subjects = await getFirstYearSubjects();
    try {
      return subjects.firstWhere((s) => s.id == subjectId);
    } catch (e) {
      return null;
    }
  }
  /// Update subject enrollment count
  Future<bool> updateSubjectEnrollment(String subjectId, int enrolledCount) async {
    try {
      final subjects = await getFirstYearSubjects();
      final index = subjects.indexWhere((s) => s.id == subjectId);
      if (index == -1) return false;
      subjects[index] = subjects[index].copyWith(enrolled: enrolledCount);
      await _saveSubjects(subjects);
      return true;
    } catch (e) {
      print('❌ Error updating subject enrollment: $e');
      return false;
    }
  }
  /// Save subjects to storage
  Future<void> _saveSubjects(List<Subject> subjects) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final subjectsJson = jsonEncode(subjects.map((s) => s.toJson()).toList());
      await prefs.setString(_subjectsKey, subjectsJson);
    } catch (e) {
      print('❌ Error saving subjects: $e');
    }
  }
}