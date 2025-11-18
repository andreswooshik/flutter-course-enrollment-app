/// Represents a student's enrollment in a subject
class Enrollment {
  final String id;
  final String studentId;
  final String subjectId;  // Changed from courseId
  final DateTime enrolledAt;
  final String status;  // 'enrolled', 'pending_drop', 'dropped'
  Enrollment({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.enrolledAt,
    this.status = 'enrolled',
  });
  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'subjectId': subjectId,
      'enrolledAt': enrolledAt.toIso8601String(),
      'status': status,
    };
  }
  /// Create from JSON
  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      subjectId: json['subjectId'] as String,
      enrolledAt: DateTime.parse(json['enrolledAt'] as String),
      status: json['status'] as String? ?? 'enrolled',
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Enrollment && other.id == id && other.status == status;
  }
  @override
  int get hashCode => id.hashCode;
}