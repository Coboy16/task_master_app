import 'package:freezed_annotation/freezed_annotation.dart';

import '/features/tasks/data/data.dart';

part 'task_filter_state.freezed.dart';

@freezed
abstract class TaskFilterState with _$TaskFilterState {
  const factory TaskFilterState({
    @Default(TaskFilterType.all) TaskFilterType filterType,
    TaskPriority? priority,
    @Default('') String searchQuery,
  }) = _TaskFilterState;
}
