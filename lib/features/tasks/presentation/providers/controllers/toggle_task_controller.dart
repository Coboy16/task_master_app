import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/tasks/presentation/providers/providers.dart';

part 'toggle_task_controller.g.dart';

@riverpod
class ToggleTaskController extends _$ToggleTaskController {
  @override
  Future<void> build() async {
    // No hace nada
  }

  Future<bool> toggleTaskCompletion(String taskId) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(toggleTaskCompletionUsecaseProvider);
    final result = await usecase(taskId);

    return result.fold(
      (failure) {
        if (kDebugMode) print('Error al cambiar estado: ${failure.message}');
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
      (updatedTask) {
        if (kDebugMode) print('Estado de tarea actualizado');
        // Recargar la lista
        ref.read(tasksProvider.notifier).loadTasks();
        state = const AsyncValue.data(null);
        return true;
      },
    );
  }
}
