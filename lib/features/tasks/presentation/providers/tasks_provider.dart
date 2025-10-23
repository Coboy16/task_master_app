import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/tasks/domain/domain.dart';
import '/features/auth/presentation/providers/providers.dart';
import '/features/tasks/data/data.dart';

import 'task_state.dart';
import 'task_filter_provider.dart' hide TaskFilter;
import 'task_usecases_provider.dart';

part 'tasks_provider.g.dart';

/// Provider principal de tareas
@riverpod
class Tasks extends _$Tasks {
  @override
  Future<TaskState> build() async {
    // Cargar tareas automáticamente al inicializar
    await _loadTasks();
    return state.value ?? const TaskState.initial();
  }

  /// Obtener el userId del usuario autenticado
  String? _getCurrentUserId() {
    final authState = ref.read(authProvider).value;
    return authState?.maybeWhen(
      authenticated: (user) => user.id,
      orElse: () => null,
    );
  }

  /// Cargar tareas con el filtro actual
  Future<void> _loadTasks() async {
    final userId = _getCurrentUserId();
    if (userId == null) {
      state = const AsyncValue.data(
        TaskState.error(message: 'Usuario no autenticado'),
      );
      return;
    }

    state = const AsyncValue.data(TaskState.loading());

    // Obtener filtro actual
    final filterState = ref.read(taskFilterProvider);
    final filter = TaskFilter(
      type: filterState.filterType,
      priority: filterState.priority,
      searchQuery: filterState.searchQuery.isEmpty
          ? null
          : filterState.searchQuery,
    );

    final usecase = ref.read(getTasksUsecaseProvider);
    final result = await usecase(userId: userId, filter: filter);

    await result.fold(
      (failure) async {
        if (kDebugMode) {
          print('Error al cargar tareas: ${failure.message}');
        }
        state = AsyncValue.data(TaskState.error(message: failure.message));
      },
      (tasks) async {
        // También cargar estadísticas
        final statsUsecase = ref.read(getTaskStatsUsecaseProvider);
        final statsResult = await statsUsecase(userId);
        final stats = statsResult.fold((failure) => null, (stats) => stats);

        state = AsyncValue.data(TaskState.loaded(tasks: tasks, stats: stats));
      },
    );
  }

  /// Recargar tareas (método público)
  Future<void> loadTasks() async {
    await _loadTasks();
  }

  /// Crear una nueva tarea
  Future<bool> createTask({
    required String title,
    required String description,
    required TaskPriority priority,
  }) async {
    final userId = _getCurrentUserId();
    if (userId == null) {
      if (kDebugMode) {
        print('Error: Usuario no autenticado');
      }
      return false;
    }

    final usecase = ref.read(createTaskUsecaseProvider);
    final result = await usecase(
      userId: userId,
      title: title,
      description: description,
      priority: priority,
    );

    return result.fold(
      (failure) {
        if (kDebugMode) {
          print('Error al crear tarea: ${failure.message}');
        }
        return false;
      },
      (task) {
        if (kDebugMode) {
          print('Tarea creada exitosamente: ${task.id}');
        }
        // Recargar la lista
        _loadTasks();
        return true;
      },
    );
  }

  /// Actualizar una tarea existente
  Future<bool> updateTask(TaskEntitie task) async {
    final usecase = ref.read(updateTaskUsecaseProvider);
    final result = await usecase(task);

    return result.fold(
      (failure) {
        if (kDebugMode) {
          print('Error al actualizar tarea: ${failure.message}');
        }
        return false;
      },
      (updatedTask) {
        if (kDebugMode) {
          print('Tarea actualizada exitosamente: ${updatedTask.id}');
        }
        // Recargar la lista
        _loadTasks();
        return true;
      },
    );
  }

  /// Eliminar una tarea
  Future<bool> deleteTask(String taskId) async {
    final usecase = ref.read(deleteTaskUsecaseProvider);
    final result = await usecase(taskId);

    return result.fold(
      (failure) {
        if (kDebugMode) {
          print('Error al eliminar tarea: ${failure.message}');
        }
        return false;
      },
      (_) {
        if (kDebugMode) {
          print('Tarea eliminada exitosamente');
        }
        // Recargar la lista
        _loadTasks();
        return true;
      },
    );
  }

  /// Toggle completado de una tarea
  Future<bool> toggleTaskCompletion(String taskId) async {
    final usecase = ref.read(toggleTaskCompletionUsecaseProvider);
    final result = await usecase(taskId);

    return result.fold(
      (failure) {
        if (kDebugMode) {
          print('Error al cambiar estado de tarea: ${failure.message}');
        }
        return false;
      },
      (updatedTask) {
        if (kDebugMode) {
          print('Estado de tarea actualizado: ${updatedTask.isCompleted}');
        }
        // Recargar la lista
        _loadTasks();
        return true;
      },
    );
  }

  /// Traer tareas desde la API
  Future<bool> fetchTasksFromApi() async {
    final userId = _getCurrentUserId();
    if (userId == null) {
      if (kDebugMode) {
        print('Error: Usuario no autenticado');
      }
      return false;
    }

    final usecase = ref.read(fetchTasksFromApiUsecaseProvider);
    final result = await usecase(userId);

    return result.fold(
      (failure) {
        if (kDebugMode) {
          print('Error al traer tareas de API: ${failure.message}');
        }
        return false;
      },
      (tasks) {
        if (kDebugMode) {
          print('${tasks.length} tareas traídas desde la API');
        }
        // Recargar la lista
        _loadTasks();
        return true;
      },
    );
  }

  /// Sincronizar tareas con Firebase
  Future<bool> syncTasks() async {
    final userId = _getCurrentUserId();
    if (userId == null) {
      if (kDebugMode) {
        print('Error: Usuario no autenticado');
      }
      return false;
    }

    final usecase = ref.read(syncTasksUsecaseProvider);
    final result = await usecase(userId);

    return result.fold(
      (failure) {
        if (kDebugMode) {
          print('Error al sincronizar tareas: ${failure.message}');
        }
        return false;
      },
      (_) {
        if (kDebugMode) {
          print('Tareas sincronizadas exitosamente');
        }
        // Recargar la lista
        _loadTasks();
        return true;
      },
    );
  }

  /// Refrescar tareas (pull to refresh)
  Future<void> refreshTasks() async {
    await _loadTasks();
  }
}
