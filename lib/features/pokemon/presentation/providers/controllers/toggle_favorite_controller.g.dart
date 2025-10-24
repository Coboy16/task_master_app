// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_favorite_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ToggleFavoriteController)
const toggleFavoriteControllerProvider = ToggleFavoriteControllerProvider._();

final class ToggleFavoriteControllerProvider
    extends $AsyncNotifierProvider<ToggleFavoriteController, void> {
  const ToggleFavoriteControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toggleFavoriteControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toggleFavoriteControllerHash();

  @$internal
  @override
  ToggleFavoriteController create() => ToggleFavoriteController();
}

String _$toggleFavoriteControllerHash() =>
    r'c2fef94465c845bead264d839be097919e26a3f1';

abstract class _$ToggleFavoriteController extends $AsyncNotifier<void> {
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
