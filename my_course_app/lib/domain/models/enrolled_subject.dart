import 'subject.dart';
import 'enrollment.dart';

/// Combines Subject with Enrollment status
class EnrolledSubject {
  final Subject subject;
  final Enrollment enrollment;

  EnrolledSubject({
    required this.subject,
    required this.enrollment,
  });

  String get status => enrollment.status;
  bool get isPendingDrop => enrollment.status == 'pending_drop';
  bool get isEnrolled => enrollment.status == 'enrolled';
}
