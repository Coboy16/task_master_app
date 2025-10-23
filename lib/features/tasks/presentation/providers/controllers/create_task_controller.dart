import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/auth/presentation/providers/providers.dart';
import '/features/tasks/domain/domain.dart';
import '/features/tasks/data/data.dart';
import '/features/tasks/presentation/providers/providers.dart'
    hide uuidProvider;

part 'create_task_controller.g.dart';

@riverpod
class CreateTaskController extends _$CreateTaskController {
  @override
  Future<void> build() async {}

  String? _getCurrentUserId() {
    final authState = ref.read(authProvider).value;
    return authState?.maybeWhen(
      authenticated: (user) => user.id,
      orElse: () => null,
    );
  }

  Future<bool> createTask({
    required String title,
    required String description,
    required TaskPriority priority,
  }) async {
    state = const AsyncValue.loading();
    try {
      final userId = _getCurrentUserId();
      if (userId == null) {
        state = AsyncValue.error('Usuario no autenticado', StackTrace.current);
        return false;
      }

      // 1. Obtenemos las dependencias para crear la entidad
      final uuid = ref.read(uuidProvider);
      final now = DateTime.now();

      // 2. Creamos el objeto TaskEntitie completo
      final newTask = TaskEntitie(
        id: uuid.v4(), // Generamos un ID local
        title: title,
        description: description,
        priority: priority,
        userId: userId,
        source: TaskSource.local, // Siempre se crea como 'local'
        isCompleted: false,
        createdAt: now,
        updatedAt: now,
        synced: false,
        deleted: false,
      );

      final usecase = ref.read(createTaskUsecaseProvider);

      // 3. Pasamos el objeto único al caso de uso
      final result = await usecase(newTask);

      return result.fold(
        (failure) {
          if (kDebugMode) print('Error al crear tarea: ${failure.message}');
          state = AsyncValue.error(failure.message, StackTrace.current);
          return false;
        },
        (task) {
          if (kDebugMode) print('Tarea creada exitosamente: ${task.id}');
          // Recargar lista de tareas
          ref.read(tasksProvider.notifier).loadTasks();
          state = const AsyncValue.data(null);
          return true;
        },
      );
    } catch (e, s) {
      if (kDebugMode) print('Error inesperado al crear tarea: $e');
      state = AsyncValue.error('Error inesperado. Intenta nuevamente.', s);
      return false;
    }
  }
}
