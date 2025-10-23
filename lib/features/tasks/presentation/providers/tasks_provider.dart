import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/auth/presentation/providers/providers.dart';

import 'task_state.dart';
import 'task_filter_provider.dart';
import 'task_usecases_provider.dart';

part 'tasks_provider.g.dart';

/// Provider principal de tareas
@riverpod
class Tasks extends _$Tasks {
  @override
  Future<TaskState> build() async {
    ref.watch(taskFilterProvider);

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
    final filter = ref.read(taskFilterProvider.notifier).getCurrentFilter();

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

  /// Refrescar tareas (pull to refresh)
  Future<void> refreshTasks() async {
    await _loadTasks();
  }
}
