// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userStorageService)
const userStorageServiceProvider = UserStorageServiceProvider._();

final class UserStorageServiceProvider
    extends
        $FunctionalProvider<
          UserStorageService,
          UserStorageService,
          UserStorageService
        >
    with $Provider<UserStorageService> {
  const UserStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userStorageServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userStorageServiceHash();

  @$internal
  @override
  $ProviderElement<UserStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserStorageService create(Ref ref) {
    return userStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserStorageService>(value),
    );
  }
}

String _$userStorageServiceHash() =>
    r'5d11f7577ec82e5cf625c85f1dce6784e37aa707';

@ProviderFor(currentStudentProfile)
const currentStudentProfileProvider = CurrentStudentProfileProvider._();

final class CurrentStudentProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<StudentProfile?>,
          StudentProfile?,
          FutureOr<StudentProfile?>
        >
    with $FutureModifier<StudentProfile?>, $FutureProvider<StudentProfile?> {
  const CurrentStudentProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentStudentProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentStudentProfileHash();

  @$internal
  @override
  $FutureProviderElement<StudentProfile?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StudentProfile?> create(Ref ref) {
    return currentStudentProfile(ref);
  }
}

String _$currentStudentProfileHash() =>
    r'ae8e0f43e8da45fc18d071eac4e8c87cc7d61872';
