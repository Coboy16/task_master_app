// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskDetail)
const taskDetailProvider = TaskDetailFamily._();

final class TaskDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<TaskEntitie?>,
          TaskEntitie?,
          FutureOr<TaskEntitie?>
        >
    with $FutureModifier<TaskEntitie?>, $FutureProvider<TaskEntitie?> {
  const TaskDetailProvider._({
    required TaskDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'taskDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$taskDetailHash();

  @override
  String toString() {
    return r'taskDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TaskEntitie?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TaskEntitie?> create(Ref ref) {
    final argument = this.argument as String;
    return taskDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$taskDetailHash() => r'13906cf5ba20c99ce733923f5dce5e0c144d3963';

final class TaskDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TaskEntitie?>, String> {
  const TaskDetailFamily._()
    : super(
        retry: null,
        name: r'taskDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TaskDetailProvider call(String taskId) =>
      TaskDetailProvider._(argument: taskId, from: this);

  @override
  String toString() => r'taskDetailProvider';
}
