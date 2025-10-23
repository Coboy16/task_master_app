// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateTaskController)
const createTaskControllerProvider = CreateTaskControllerProvider._();

final class CreateTaskControllerProvider
    extends $AsyncNotifierProvider<CreateTaskController, void> {
  const CreateTaskControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTaskControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTaskControllerHash();

  @$internal
  @override
  CreateTaskController create() => CreateTaskController();
}

String _$createTaskControllerHash() =>
    r'4edf41fde9505f96a5eef96042bf7d77c1387842';

abstract class _$CreateTaskController extends $AsyncNotifier<void> {
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
