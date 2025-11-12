// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

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

String _$authenticatorHash() => r'784a67ec26f6fd57e54ce49d7fa1584807eded38';

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
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
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'51c75f3e430febdc2f62147b5ffa5d9cf6405088';
