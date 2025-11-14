/// Represents a subject in the enrollment system
class Subject {
  final String id;
  final String code;
  final String name;
  final String description;
  final String schedule;
  final String instructor;
  final int units;
  final int capacity;
  final int enrolled;
  final SubjectType type; // Major or Minor

  Subject({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.schedule,
    required this.instructor,
    required this.units,
    required this.capacity,
    this.enrolled = 0,
    required this.type,
  });

  /// Check if subject is full
  bool get isFull => enrolled >= capacity;

  /// Get available slots
  int get availableSlots => capacity - enrolled;

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'schedule': schedule,
      'instructor': instructor,
      'units': units,
      'capacity': capacity,
      'enrolled': enrolled,
      'type': type.name,
    };
  }

  /// Create from JSON
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      schedule: json['schedule'] as String,
      instructor: json['instructor'] as String,
      units: json['units'] as int,
      capacity: json['capacity'] as int,
      enrolled: json['enrolled'] as int? ?? 0,
      type: SubjectType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => SubjectType.major,
      ),
    );
  }

  /// Create a copy with updated fields
  Subject copyWith({
    String? id,
    String? code,
    String? name,
    String? description,
    String? schedule,
    String? instructor,
    int? units,
    int? capacity,
    int? enrolled,
    SubjectType? type,
  }) {
    return Subject(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      schedule: schedule ?? this.schedule,
      instructor: instructor ?? this.instructor,
      units: units ?? this.units,
      capacity: capacity ?? this.capacity,
      enrolled: enrolled ?? this.enrolled,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Subject && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum SubjectType {
  major,  
  minor,  
}