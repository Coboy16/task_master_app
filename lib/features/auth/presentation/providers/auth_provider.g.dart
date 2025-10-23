// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider principal de autenticación usando AsyncNotifier con generación de código
/// Este provider AHORA SOLO maneja el estado de autenticación GLOBAL.

@ProviderFor(Auth)
const authProvider = AuthProvider._();

/// Provider principal de autenticación usando AsyncNotifier con generación de código
/// Este provider AHORA SOLO maneja el estado de autenticación GLOBAL.
final class AuthProvider extends $AsyncNotifierProvider<Auth, AuthState> {
  /// Provider principal de autenticación usando AsyncNotifier con generación de código
  /// Este provider AHORA SOLO maneja el estado de autenticación GLOBAL.
  const AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();
}

String _$authHash() => r'c1554b81c239fa86c2540c8580f2c48b31487af1';

/// Provider principal de autenticación usando AsyncNotifier con generación de código
/// Este provider AHORA SOLO maneja el estado de autenticación GLOBAL.

abstract class _$Auth extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthState>, AuthState>,
              AsyncValue<AuthState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
