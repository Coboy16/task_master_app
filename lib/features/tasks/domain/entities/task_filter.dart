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
