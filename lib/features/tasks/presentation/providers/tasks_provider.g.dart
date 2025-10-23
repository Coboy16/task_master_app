// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider principal de tareas

@ProviderFor(Tasks)
const tasksProvider = TasksProvider._();

/// Provider principal de tareas
final class TasksProvider extends $AsyncNotifierProvider<Tasks, TaskState> {
  /// Provider principal de tareas
  const TasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tasksHash();

  @$internal
  @override
  Tasks create() => Tasks();
}

String _$tasksHash() => r'7c0e67b700516f37e7e1722d3550784dd9605465';

/// Provider principal de tareas

abstract class _$Tasks extends $AsyncNotifier<TaskState> {
  FutureOr<TaskState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<TaskState>, TaskState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TaskState>, TaskState>,
              AsyncValue<TaskState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
