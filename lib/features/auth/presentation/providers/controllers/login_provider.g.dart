// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador para la pantalla de Login
/// Maneja el estado de la acción (loading, error)

@ProviderFor(Login)
const loginProvider = LoginProvider._();

/// Controlador para la pantalla de Login
/// Maneja el estado de la acción (loading, error)
final class LoginProvider extends $AsyncNotifierProvider<Login, void> {
  /// Controlador para la pantalla de Login
  /// Maneja el estado de la acción (loading, error)
  const LoginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginHash();

  @$internal
  @override
  Login create() => Login();
}

String _$loginHash() => r'405f0192200531476ec477f150cb8ac199ecd99f';

/// Controlador para la pantalla de Login
/// Maneja el estado de la acción (loading, error)

abstract class _$Login extends $AsyncNotifier<void> {
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
