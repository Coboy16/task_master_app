// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_api_tasks_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchApiTasksController)
const fetchApiTasksControllerProvider = FetchApiTasksControllerProvider._();

final class FetchApiTasksControllerProvider
    extends $AsyncNotifierProvider<FetchApiTasksController, void> {
  const FetchApiTasksControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchApiTasksControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchApiTasksControllerHash();

  @$internal
  @override
  FetchApiTasksController create() => FetchApiTasksController();
}

String _$fetchApiTasksControllerHash() =>
    r'85c703065c520a4606cd169cbd843c4cd9f2ddec';

abstract class _$FetchApiTasksController extends $AsyncNotifier<void> {
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
