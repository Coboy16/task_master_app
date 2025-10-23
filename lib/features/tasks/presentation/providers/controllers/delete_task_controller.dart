import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/tasks/presentation/providers/providers.dart';

part 'delete_task_controller.g.dart';

@riverpod
class DeleteTaskController extends _$DeleteTaskController {
  @override
  Future<void> build() async {
    // No hace nada
  }

  Future<bool> deleteTask(String taskId) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(deleteTaskUsecaseProvider);
    final result = await usecase(taskId);

    return result.fold(
      (failure) {
        if (kDebugMode) print('Error al eliminar tarea: ${failure.message}');
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
      (_) {
        if (kDebugMode) print('Tarea eliminada exitosamente');
        // Recargar la lista
        ref.read(tasksProvider.notifier).loadTasks();
        state = const AsyncValue.data(null);
        return true;
      },
    );
  }
}
