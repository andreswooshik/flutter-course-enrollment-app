/// App-wide constants
class AppConstants {
  // Enrollment limits
  static const int maxUnitsPerSemester = 24;
  
  // Messages
  static const String unitLimitExceeded = 
    'Cannot enroll. This would exceed the unit limit of $maxUnitsPerSemester units.';
  static const String unitLimitReached = 
    'You have reached the maximum unit limit.';
  static const String subjectFull = 
    'This subject is full. Please choose another subject.';
  static const String enrollSuccess = 
    'Successfully enrolled!';
  static const String dropSuccess = 
    'Subject dropped successfully.';
  static const String alreadyEnrolled = 
    'You are already enrolled in this subject.';
}