// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador para la pantalla de "Continuar sin cuenta"

@ProviderFor(Guest)
const guestProvider = GuestProvider._();

/// Controlador para la pantalla de "Continuar sin cuenta"
final class GuestProvider extends $AsyncNotifierProvider<Guest, void> {
  /// Controlador para la pantalla de "Continuar sin cuenta"
  const GuestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guestHash();

  @$internal
  @override
  Guest create() => Guest();
}

String _$guestHash() => r'f1df9d6092087e46be686e8c435573c8727596f6';

/// Controlador para la pantalla de "Continuar sin cuenta"

abstract class _$Guest extends $AsyncNotifier<void> {
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
