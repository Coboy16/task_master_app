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
    extends $AsyncNotifierProvider<ToggleTaskController, TaskEntitie?> {
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
    r'f5feaa416ba9981398856e8e563341703be1130e';

abstract class _$ToggleTaskController extends $AsyncNotifier<TaskEntitie?> {
  FutureOr<TaskEntitie?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<TaskEntitie?>, TaskEntitie?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TaskEntitie?>, TaskEntitie?>,
              AsyncValue<TaskEntitie?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
