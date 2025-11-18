import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/subject.dart';
import '../services/subject_storage_service.dart';
part 'subject_provider.g.dart';
@riverpod
SubjectStorageService subjectStorageService(Ref ref) {  
  return SubjectStorageService();
}
@riverpod
Future<List<Subject>> firstYearSubjects(Ref ref) async { 
  final service = ref.watch(subjectStorageServiceProvider);
  return await service.getFirstYearSubjects();
}
@riverpod
Future<List<Subject>> majorSubjects(Ref ref) async { 
  final service = ref.watch(subjectStorageServiceProvider);
  return await service.getMajorSubjects();
}
@riverpod
Future<List<Subject>> minorSubjects(Ref ref) async {  
  final service = ref.watch(subjectStorageServiceProvider);
  return await service.getMinorSubjects();
}
@riverpod
Future<Subject?> subjectById(Ref ref, String subjectId) async { 
  final service = ref.watch(subjectStorageServiceProvider);
  return await service.getSubjectById(subjectId);
}
