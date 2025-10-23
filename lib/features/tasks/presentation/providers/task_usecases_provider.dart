import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/tasks/domain/domain.dart';
import 'task_dependencies_provider.dart';

part 'task_usecases_provider.g.dart';

@Riverpod(keepAlive: true)
GetTasksUsecase getTasksUsecase(Ref ref) {
  return GetTasksUsecase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetTaskByIdUsecase getTaskByIdUsecase(Ref ref) {
  return GetTaskByIdUsecase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
CreateTaskUsecase createTaskUsecase(Ref ref) {
  return CreateTaskUsecase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdateTaskUsecase updateTaskUsecase(Ref ref) {
  return UpdateTaskUsecase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
DeleteTaskUsecase deleteTaskUsecase(Ref ref) {
  return DeleteTaskUsecase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
ToggleTaskCompletionUsecase toggleTaskCompletionUsecase(Ref ref) {
  return ToggleTaskCompletionUsecase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
FetchTasksFromApiUsecase fetchTasksFromApiUsecase(Ref ref) {
  return FetchTasksFromApiUsecase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
SyncTasksUsecase syncTasksUsecase(Ref ref) {
  return SyncTasksUsecase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetTaskStatsUsecase getTaskStatsUsecase(Ref ref) {
  return GetTaskStatsUsecase(ref.watch(taskRepositoryProvider));
}
