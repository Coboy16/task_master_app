import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

// Importa la entidad para poder devolverla
import '/features/tasks/domain/domain.dart';
import '/features/tasks/presentation/providers/providers.dart';

part 'toggle_task_controller.g.dart';

@riverpod
// Cambiamos <void> a <TaskEntitie?> para devolver la tarea actualizada
class ToggleTaskController extends _$ToggleTaskController {
  @override
  // Estado inicial es null
  Future<TaskEntitie?> build() async => null;

  // Devolvemos Future<bool> para saber si la operación se inició
  Future<bool> toggleTaskCompletion(String taskId) async {
    // Comprobación inicial
    if (!ref.mounted) {
      if (kDebugMode)
        print('ToggleTaskController ya no está montado al inicio.');
      return false;
    }

    state = const AsyncValue.loading();

    final usecase = ref.read(toggleTaskCompletionUsecaseProvider);
    final result = await usecase(taskId); // <-- AWAIT

    // Solo actualizamos el estado SI el provider sigue montado
    if (ref.mounted) {
      result.fold(
        (failure) {
          if (kDebugMode) print('Error al cambiar estado: ${failure.message}');
          // Actualiza ESTE provider con el error
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (updatedTask) {
          if (kDebugMode) print('Estado de tarea actualizado en controlador');
          // Actualiza ESTE provider con la tarea actualizada
          state = AsyncValue.data(updatedTask);
        },
      );
      // La operación (exitosa o no) se completó mientras estaba montado
      return true;
    } else {
      // La operación terminó pero el provider ya no existe
      if (kDebugMode) print('ToggleTaskController desechado durante await.');
      // No podemos actualizar state, la operación se perdió en el limbo
      return false;
    }
  }
}
