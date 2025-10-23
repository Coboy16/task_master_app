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
    r'1a56959b24d61c8334416107ce0d60e3f37428ea';

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
