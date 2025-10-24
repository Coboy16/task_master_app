// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_task_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateTaskController)
const updateTaskControllerProvider = UpdateTaskControllerProvider._();

final class UpdateTaskControllerProvider
    extends $AsyncNotifierProvider<UpdateTaskController, void> {
  const UpdateTaskControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTaskControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTaskControllerHash();

  @$internal
  @override
  UpdateTaskController create() => UpdateTaskController();
}

String _$updateTaskControllerHash() =>
    r'c51e39f7e3a88e4ebcbaa9ba7efc918471efff9d';

abstract class _$UpdateTaskController extends $AsyncNotifier<void> {
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
