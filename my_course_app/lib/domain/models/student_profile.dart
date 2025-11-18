class StudentProfile {
  final String accountId;
  final String firstName;
  final String lastName;
  final String email;
  final String course;
  final String year;
  StudentProfile({
    required this.accountId,
    required this.firstName,
    required this.lastName,
    this.email = '',
    required this.course,
    required this.year,
  });
  // Get full name
  String get fullName => '$firstName $lastName';
  // Get year as display text
  String get yearLevel {
    if (year.isEmpty) return 'N/A';
    return 'Year $year';
  }
  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'course': course,
      'year': year,
    };
  }
  // Create from map (from CSV parsing)
  factory StudentProfile.fromMap(Map<String, String>? map) {
    if (map == null) {
      return StudentProfile(
        accountId: '',
        firstName: '',
        lastName: '',
        email: '',
        course: '',
        year: '',
      );
    }
    return StudentProfile(
      accountId: map['accountId'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      course: map['course'] ?? '',
      year: map['year'] ?? '',
    );
  }
}