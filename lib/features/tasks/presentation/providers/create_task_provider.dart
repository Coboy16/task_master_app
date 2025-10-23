import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/auth/presentation/providers/providers.dart';

import '/features/tasks/domain/domain.dart';
import '/features/tasks/data/data.dart';

import 'providers.dart';

part 'create_task_provider.g.dart';

@riverpod
class CreateTask extends _$CreateTask {
  @override
  Future<void> build() async {
    // No hace nada al construir
  }

  String? _getCurrentUserId() {
    final authState = ref.read(authProvider).value;
    return authState?.maybeWhen(
      authenticated: (user) => user.id,
      orElse: () => null,
    );
  }

  Future<void> createTask({
    required String title,
    required String description,
    required TaskPriority priority,
  }) async {
    state = const AsyncValue.loading();

    try {
      final userId = _getCurrentUserId();
      if (userId == null) {
        state = AsyncValue.error('Usuario no autenticado', StackTrace.current);
        return;
      }

      final usecase = ref.read(createTaskUsecaseProvider);
      final result = await usecase(
        userId: userId,
        title: title,
        description: description,
        priority: priority,
      );

      result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error al crear tarea: ${failure.message}');
          }
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (task) {
          if (kDebugMode) {
            print('Tarea creada exitosamente: ${task.id}');
          }
          // Recargar lista de tareas
          ref.read(tasksProvider.notifier).loadTasks();
          state = const AsyncValue.data(null);
        },
      );
    } catch (e, s) {
      if (kDebugMode) {
        print('Error inesperado al crear tarea: $e');
      }
      state = AsyncValue.error('Error inesperado. Intenta nuevamente.', s);
    }
  }
}

/// Controlador para actualizar una tarea existente
@riverpod
class UpdateTask extends _$UpdateTask {
  @override
  Future<void> build() async {
    // No hace nada al construir
  }

  Future<void> updateTask(TaskEntitie task) async {
    state = const AsyncValue.loading();

    try {
      final usecase = ref.read(updateTaskUsecaseProvider);
      final result = await usecase(task);

      result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error al actualizar tarea: ${failure.message}');
          }
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (updatedTask) {
          if (kDebugMode) {
            print('Tarea actualizada exitosamente: ${updatedTask.id}');
          }
          // Recargar lista de tareas
          ref.read(tasksProvider.notifier).loadTasks();
          state = const AsyncValue.data(null);
        },
      );
    } catch (e, s) {
      if (kDebugMode) {
        print('Error inesperado al actualizar tarea: $e');
      }
      state = AsyncValue.error('Error inesperado. Intenta nuevamente.', s);
    }
  }
}
