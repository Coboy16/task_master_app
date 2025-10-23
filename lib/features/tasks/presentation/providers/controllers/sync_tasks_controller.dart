import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/auth/presentation/providers/providers.dart';
import '/features/tasks/presentation/providers/providers.dart';

part 'sync_tasks_controller.g.dart';

@riverpod
class SyncTasksController extends _$SyncTasksController {
  @override
  Future<void> build() async {
    // No hace nada
  }

  String? _getCurrentUserId() {
    final authState = ref.read(authProvider).value;
    return authState?.maybeWhen(
      authenticated: (user) => user.id,
      orElse: () => null,
    );
  }

  Future<bool> syncTasks() async {
    state = const AsyncValue.loading();
    final userId = _getCurrentUserId();
    if (userId == null) {
      if (kDebugMode) print('Error: Usuario no autenticado');
      state = AsyncValue.error('Usuario no autenticado', StackTrace.current);
      return false;
    }

    final usecase = ref.read(syncTasksUsecaseProvider);
    final result = await usecase(userId);

    return result.fold(
      (failure) {
        if (kDebugMode) {
          print('Error al sincronizar tareas: ${failure.message}');
        }
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
      (_) {
        if (kDebugMode) print('Tareas sincronizadas exitosamente');
        // Recargar la lista
        ref.read(tasksProvider.notifier).loadTasks();
        state = const AsyncValue.data(null);
        return true;
      },
    );
  }
}
