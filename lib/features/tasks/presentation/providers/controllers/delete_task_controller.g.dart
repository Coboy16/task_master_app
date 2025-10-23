// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_task_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeleteTaskController)
const deleteTaskControllerProvider = DeleteTaskControllerProvider._();

final class DeleteTaskControllerProvider
    extends $AsyncNotifierProvider<DeleteTaskController, void> {
  const DeleteTaskControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTaskControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTaskControllerHash();

  @$internal
  @override
  DeleteTaskController create() => DeleteTaskController();
}

String _$deleteTaskControllerHash() =>
    r'67659b73c4c39b4b444a1a2814f9e8aaa48806e5';

abstract class _$DeleteTaskController extends $AsyncNotifier<void> {
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
