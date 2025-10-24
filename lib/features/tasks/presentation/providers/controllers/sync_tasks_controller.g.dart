// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_tasks_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SyncTasksController)
const syncTasksControllerProvider = SyncTasksControllerProvider._();

final class SyncTasksControllerProvider
    extends $AsyncNotifierProvider<SyncTasksController, void> {
  const SyncTasksControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncTasksControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncTasksControllerHash();

  @$internal
  @override
  SyncTasksController create() => SyncTasksController();
}

String _$syncTasksControllerHash() =>
    r'80bf531960eaeeff973b0e75036776e871bff1fb';

abstract class _$SyncTasksController extends $AsyncNotifier<void> {
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
