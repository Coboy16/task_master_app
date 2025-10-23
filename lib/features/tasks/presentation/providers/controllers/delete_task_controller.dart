import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/tasks/presentation/providers/providers.dart';

part 'delete_task_controller.g.dart';

@riverpod
class DeleteTaskController extends _$DeleteTaskController {
  @override
  Future<void> build() async {} // Vuelve a void, no necesitamos devolver nada

  Future<bool> deleteTask(String taskId) async {
    if (!ref.mounted) {
      if (kDebugMode)
        print('DeleteTaskController ya no está montado al inicio.');
      return false;
    }

    state = const AsyncValue.loading();

    final usecase = ref.read(deleteTaskUsecaseProvider);
    final result = await usecase(taskId); // <-- AWAIT

    if (ref.mounted) {
      result.fold(
        (failure) {
          if (kDebugMode) print('Error al eliminar tarea: ${failure.message}');
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (_) {
          if (kDebugMode) print('Tarea eliminada exitosamente en controlador');
          // Éxito, solo actualiza el estado local
          state = const AsyncValue.data(null);
        },
      );
      return true; // Se completó montado
    } else {
      if (kDebugMode) print('DeleteTaskController desechado durante await.');
      return false; // Se desechó antes de terminar
    }
  }
}
