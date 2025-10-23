// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_task_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ToggleTaskController)
const toggleTaskControllerProvider = ToggleTaskControllerProvider._();

final class ToggleTaskControllerProvider
    extends $AsyncNotifierProvider<ToggleTaskController, void> {
  const ToggleTaskControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toggleTaskControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toggleTaskControllerHash();

  @$internal
  @override
  ToggleTaskController create() => ToggleTaskController();
}

String _$toggleTaskControllerHash() =>
    r'8dc7d96b404892c589bc67644586929c7fe213c1';

abstract class _$ToggleTaskController extends $AsyncNotifier<void> {
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
