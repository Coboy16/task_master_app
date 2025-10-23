import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/tasks/domain/domain.dart';
import '/features/tasks/presentation/providers/providers.dart';

part 'update_task_controller.g.dart';

@riverpod
class UpdateTaskController extends _$UpdateTaskController {
  @override
  Future<void> build() async {}

  Future<bool> updateTask(TaskEntitie task) async {
    state = const AsyncValue.loading();
    try {
      final usecase = ref.read(updateTaskUsecaseProvider);
      final result = await usecase(task);

      return result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error al actualizar tarea: ${failure.message}');
          }
          state = AsyncValue.error(failure.message, StackTrace.current);
          return false;
        },
        (updatedTask) {
          if (kDebugMode) print('Tarea actualizada: ${updatedTask.id}');
          ref.read(tasksProvider.notifier).loadTasks();
          state = const AsyncValue.data(null);
          return true;
        },
      );
    } catch (e, s) {
      if (kDebugMode) print('Error inesperado al actualizar tarea: $e');
      state = AsyncValue.error('Error inesperado. Intenta nuevamente.', s);
      return false;
    }
  }
}
