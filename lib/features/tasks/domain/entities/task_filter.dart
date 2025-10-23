import 'package:freezed_annotation/freezed_annotation.dart';

import '/features/tasks/data/data.dart';

part 'task_filter.freezed.dart';

@freezed
abstract class TaskFilter with _$TaskFilter {
  const factory TaskFilter({
    TaskFilterType? type,
    TaskPriority? priority,
    TaskSource? source,
    String? searchQuery,
  }) = _TaskFilter;

  const TaskFilter._();

  static const empty = TaskFilter();
  static const pending = TaskFilter(type: TaskFilterType.pending);
  static const completed = TaskFilter(type: TaskFilterType.completed);
}

enum TaskFilterType {
  all,
  pending,
  completed;

  String get label {
    switch (this) {
      case TaskFilterType.all:
        return 'Todas';
      case TaskFilterType.pending:
        return 'Pendientes';
      case TaskFilterType.completed:
        return 'Completadas';
    }
  }
}
