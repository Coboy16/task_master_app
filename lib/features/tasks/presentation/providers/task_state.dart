import 'package:freezed_annotation/freezed_annotation.dart';
import '/features/tasks/domain/domain.dart';

part 'task_state.freezed.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState.initial() = _Initial;

  const factory TaskState.loading() = _Loading;

  const factory TaskState.loaded({
    required List<TaskEntitie> tasks,
    TaskStats? stats,
  }) = _Loaded;

  const factory TaskState.error({required String message}) = _Error;
}
