// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(enrollmentStorageService)
const enrollmentStorageServiceProvider = EnrollmentStorageServiceProvider._();

final class EnrollmentStorageServiceProvider
    extends
        $FunctionalProvider<
          EnrollmentStorageService,
          EnrollmentStorageService,
          EnrollmentStorageService
        >
    with $Provider<EnrollmentStorageService> {
  const EnrollmentStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enrollmentStorageServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enrollmentStorageServiceHash();

  @$internal
  @override
  $ProviderElement<EnrollmentStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnrollmentStorageService create(Ref ref) {
    return enrollmentStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnrollmentStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnrollmentStorageService>(value),
    );
  }
}

String _$enrollmentStorageServiceHash() =>
    r'06582935fb8eb3e688e89ec1d795949f1ff7d512';

@ProviderFor(studentEnrollments)
const studentEnrollmentsProvider = StudentEnrollmentsProvider._();

final class StudentEnrollmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Enrollment>>,
          List<Enrollment>,
          FutureOr<List<Enrollment>>
        >
    with $FutureModifier<List<Enrollment>>, $FutureProvider<List<Enrollment>> {
  const StudentEnrollmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studentEnrollmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studentEnrollmentsHash();

  @$internal
  @override
  $FutureProviderElement<List<Enrollment>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Enrollment>> create(Ref ref) {
    return studentEnrollments(ref);
  }
}

String _$studentEnrollmentsHash() =>
    r'5c4a421fe4407fffd6d60713349e38113de7d293';

@ProviderFor(enrolledSubjects)
const enrolledSubjectsProvider = EnrolledSubjectsProvider._();

final class EnrolledSubjectsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EnrolledSubject>>,
          List<EnrolledSubject>,
          FutureOr<List<EnrolledSubject>>
        >
    with
        $FutureModifier<List<EnrolledSubject>>,
        $FutureProvider<List<EnrolledSubject>> {
  const EnrolledSubjectsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enrolledSubjectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enrolledSubjectsHash();

  @$internal
  @override
  $FutureProviderElement<List<EnrolledSubject>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EnrolledSubject>> create(Ref ref) {
    return enrolledSubjects(ref);
  }
}

String _$enrolledSubjectsHash() => r'97178989d90526701472b69c533a14ac097558ca';

@ProviderFor(totalEnrolledUnits)
const totalEnrolledUnitsProvider = TotalEnrolledUnitsProvider._();

final class TotalEnrolledUnitsProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  const TotalEnrolledUnitsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalEnrolledUnitsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalEnrolledUnitsHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return totalEnrolledUnits(ref);
  }
}

String _$totalEnrolledUnitsHash() =>
    r'1923ae039af498b246fbfec412f85c46f1533811';

@ProviderFor(enrollInSubject)
const enrollInSubjectProvider = EnrollInSubjectFamily._();

final class EnrollInSubjectProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  const EnrollInSubjectProvider._({
    required EnrollInSubjectFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'enrollInSubjectProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$enrollInSubjectHash();

  @override
  String toString() {
    return r'enrollInSubjectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as String;
    return enrollInSubject(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EnrollInSubjectProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$enrollInSubjectHash() => r'aed75a25cfa661ce3399e75bca183b85fa5736ae';

final class EnrollInSubjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, String> {
  const EnrollInSubjectFamily._()
    : super(
        retry: null,
        name: r'enrollInSubjectProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EnrollInSubjectProvider call(String subjectId) =>
      EnrollInSubjectProvider._(argument: subjectId, from: this);

  @override
  String toString() => r'enrollInSubjectProvider';
}

@ProviderFor(dropSubject)
const dropSubjectProvider = DropSubjectFamily._();

final class DropSubjectProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  const DropSubjectProvider._({
    required DropSubjectFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'dropSubjectProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dropSubjectHash();

  @override
  String toString() {
    return r'dropSubjectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as String;
    return dropSubject(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DropSubjectProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dropSubjectHash() => r'97975a19c7dab78f1ef43f1f858a40612c232fdf';

final class DropSubjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, String> {
  const DropSubjectFamily._()
    : super(
        retry: null,
        name: r'dropSubjectProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DropSubjectProvider call(String subjectId) =>
      DropSubjectProvider._(argument: subjectId, from: this);

  @override
  String toString() => r'dropSubjectProvider';
}
