import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/auth/presentation/providers/providers.dart';
import '/features/tasks/presentation/providers/providers.dart';

part 'sync_tasks_controller.g.dart';

@riverpod
class SyncTasksController extends _$SyncTasksController {
  @override
  Future<void> build() async {}

  String? _getCurrentUserId() {
    final authState = ref.read(authProvider).value;
    return authState?.maybeWhen(
      authenticated: (user) => user.id,
      orElse: () => null,
    );
  }

  bool _isGuestUser() {
    final authState = ref.read(authProvider).value;
    return authState?.maybeWhen(
          authenticated: (user) => user.isGuest,
          orElse: () => true,
        ) ??
        true;
  }

  Future<bool> syncTasks() async {
    final link = ref.keepAlive();

    try {
      if (!ref.mounted) {
        if (kDebugMode) print('SyncTasksController no está montado al inicio');
        return false;
      }

      // Verificar si es usuario invitado
      if (_isGuestUser()) {
        if (kDebugMode) print('Usuario invitado: sincronización omitida');
        state = const AsyncValue.data(null);
        return false;
      }

      state = const AsyncValue.loading();

      final userId = _getCurrentUserId();
      if (userId == null) {
        if (kDebugMode) print('Error: Usuario no autenticado');
        if (ref.mounted) {
          state = AsyncValue.error(
            'Usuario no autenticado',
            StackTrace.current,
          );
        }
        return false;
      }

      final usecase = ref.read(syncTasksUsecaseProvider);
      final result = await usecase(userId);

      if (!ref.mounted) {
        if (kDebugMode) {
          print('SyncTasksController fue desechado durante la operación async');
        }
        return false;
      }

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

          if (ref.mounted) {
            ref.read(tasksProvider.notifier).loadTasks();
            state = const AsyncValue.data(null);
          }
          return true;
        },
      );
    } finally {
      link.close();
    }
  }
}
