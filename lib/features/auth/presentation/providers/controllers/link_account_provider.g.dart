// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador para la pantalla de "Vincular Cuenta"

@ProviderFor(LinkAccount)
const linkAccountProvider = LinkAccountProvider._();

/// Controlador para la pantalla de "Vincular Cuenta"
final class LinkAccountProvider
    extends $AsyncNotifierProvider<LinkAccount, void> {
  /// Controlador para la pantalla de "Vincular Cuenta"
  const LinkAccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'linkAccountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$linkAccountHash();

  @$internal
  @override
  LinkAccount create() => LinkAccount();
}

String _$linkAccountHash() => r'32341cbfc21da7a43f95f45e62a782fed948aa11';

/// Controlador para la pantalla de "Vincular Cuenta"

abstract class _$LinkAccount extends $AsyncNotifier<void> {
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
