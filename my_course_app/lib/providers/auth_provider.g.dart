// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authenticator)
const authenticatorProvider = AuthenticatorProvider._();

final class AuthenticatorProvider
    extends $FunctionalProvider<Authenticator, Authenticator, Authenticator>
    with $Provider<Authenticator> {
  const AuthenticatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authenticatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authenticatorHash();

  @$internal
  @override
  $ProviderElement<Authenticator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Authenticator create(Ref ref) {
    return authenticator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Authenticator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Authenticator>(value),
    );
  }
}

String _$authenticatorHash() => r'fb8e859cf94b2fd6789847e3b31fde1e9d94bd7f';

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends
        $FunctionalProvider<
          AuthRepositoryImpl,
          AuthRepositoryImpl,
          AuthRepositoryImpl
        >
    with $Provider<AuthRepositoryImpl> {
  const AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRepositoryImpl create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepositoryImpl>(value),
    );
  }
}

String _$authRepositoryHash() => r'3e8ab9296e0f60d195c47f564a2b291f0396bce2';
