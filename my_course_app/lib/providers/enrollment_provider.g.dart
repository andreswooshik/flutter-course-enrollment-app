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
          AsyncValue<List<Subject>>,
          List<Subject>,
          FutureOr<List<Subject>>
        >
    with $FutureModifier<List<Subject>>, $FutureProvider<List<Subject>> {
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
  $FutureProviderElement<List<Subject>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Subject>> create(Ref ref) {
    return enrolledSubjects(ref);
  }
}

String _$enrolledSubjectsHash() => r'8805adcae877e2299089d169bfc024e8165e4193';

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
    r'016cf5a12f98bb4e7ace40eae0aba67b0faa4b84';

@ProviderFor(EnrollmentActions)
const enrollmentActionsProvider = EnrollmentActionsProvider._();

final class EnrollmentActionsProvider
    extends $AsyncNotifierProvider<EnrollmentActions, void> {
  const EnrollmentActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enrollmentActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enrollmentActionsHash();

  @$internal
  @override
  EnrollmentActions create() => EnrollmentActions();
}

String _$enrollmentActionsHash() => r'76884a2f55c6108058427ff92ad454acbfab5ef9';

abstract class _$EnrollmentActions extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
