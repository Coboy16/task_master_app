// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateTask)
const createTaskProvider = CreateTaskProvider._();

final class CreateTaskProvider
    extends $AsyncNotifierProvider<CreateTask, void> {
  const CreateTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTaskHash();

  @$internal
  @override
  CreateTask create() => CreateTask();
}

String _$createTaskHash() => r'bacf71d9abfc0585baa6dde87433c18c121f7330';

abstract class _$CreateTask extends $AsyncNotifier<void> {
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

/// Controlador para actualizar una tarea existente

@ProviderFor(UpdateTask)
const updateTaskProvider = UpdateTaskProvider._();

/// Controlador para actualizar una tarea existente
final class UpdateTaskProvider
    extends $AsyncNotifierProvider<UpdateTask, void> {
  /// Controlador para actualizar una tarea existente
  const UpdateTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTaskHash();

  @$internal
  @override
  UpdateTask create() => UpdateTask();
}

String _$updateTaskHash() => r'347c7740962dcf429cddda93d4b584eeddf2967d';

/// Controlador para actualizar una tarea existente

abstract class _$UpdateTask extends $AsyncNotifier<void> {
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
