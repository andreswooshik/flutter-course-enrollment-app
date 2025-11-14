// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(subjectStorageService)
const subjectStorageServiceProvider = SubjectStorageServiceProvider._();

final class SubjectStorageServiceProvider
    extends
        $FunctionalProvider<
          SubjectStorageService,
          SubjectStorageService,
          SubjectStorageService
        >
    with $Provider<SubjectStorageService> {
  const SubjectStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subjectStorageServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subjectStorageServiceHash();

  @$internal
  @override
  $ProviderElement<SubjectStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubjectStorageService create(Ref ref) {
    return subjectStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubjectStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubjectStorageService>(value),
    );
  }
}

String _$subjectStorageServiceHash() =>
    r'978665631982d548a102c1e80068117a765b7b65';

@ProviderFor(firstYearSubjects)
const firstYearSubjectsProvider = FirstYearSubjectsProvider._();

final class FirstYearSubjectsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Subject>>,
          List<Subject>,
          FutureOr<List<Subject>>
        >
    with $FutureModifier<List<Subject>>, $FutureProvider<List<Subject>> {
  const FirstYearSubjectsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firstYearSubjectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firstYearSubjectsHash();

  @$internal
  @override
  $FutureProviderElement<List<Subject>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Subject>> create(Ref ref) {
    return firstYearSubjects(ref);
  }
}

String _$firstYearSubjectsHash() => r'06219221e7e5b366d70ee2a1952f43afefafe5a0';

@ProviderFor(majorSubjects)
const majorSubjectsProvider = MajorSubjectsProvider._();

final class MajorSubjectsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Subject>>,
          List<Subject>,
          FutureOr<List<Subject>>
        >
    with $FutureModifier<List<Subject>>, $FutureProvider<List<Subject>> {
  const MajorSubjectsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'majorSubjectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$majorSubjectsHash();

  @$internal
  @override
  $FutureProviderElement<List<Subject>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Subject>> create(Ref ref) {
    return majorSubjects(ref);
  }
}

String _$majorSubjectsHash() => r'b760d0f949447d4bf73f4fb73bb14409a4534bef';

@ProviderFor(minorSubjects)
const minorSubjectsProvider = MinorSubjectsProvider._();

final class MinorSubjectsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Subject>>,
          List<Subject>,
          FutureOr<List<Subject>>
        >
    with $FutureModifier<List<Subject>>, $FutureProvider<List<Subject>> {
  const MinorSubjectsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'minorSubjectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$minorSubjectsHash();

  @$internal
  @override
  $FutureProviderElement<List<Subject>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Subject>> create(Ref ref) {
    return minorSubjects(ref);
  }
}

String _$minorSubjectsHash() => r'a6e0070c584234f0d34c5b193d267be60b847040';

@ProviderFor(subjectById)
const subjectByIdProvider = SubjectByIdFamily._();

final class SubjectByIdProvider
    extends
        $FunctionalProvider<AsyncValue<Subject?>, Subject?, FutureOr<Subject?>>
    with $FutureModifier<Subject?>, $FutureProvider<Subject?> {
  const SubjectByIdProvider._({
    required SubjectByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'subjectByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$subjectByIdHash();

  @override
  String toString() {
    return r'subjectByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Subject?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Subject?> create(Ref ref) {
    final argument = this.argument as String;
    return subjectById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SubjectByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$subjectByIdHash() => r'd8c4c5201dc4ba144bc43c98ce7a5ae75e6e2690';

final class SubjectByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Subject?>, String> {
  const SubjectByIdFamily._()
    : super(
        retry: null,
        name: r'subjectByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SubjectByIdProvider call(String subjectId) =>
      SubjectByIdProvider._(argument: subjectId, from: this);

  @override
  String toString() => r'subjectByIdProvider';
}
