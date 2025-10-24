import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/auth/presentation/providers/providers.dart';
import '/features/tasks/presentation/providers/providers.dart';

part 'fetch_api_tasks_controller.g.dart';

@riverpod
class FetchApiTasksController extends _$FetchApiTasksController {
  @override
  Future<void> build() async {}

  String? _getCurrentUserId() {
    final authState = ref.read(authProvider).value;
    return authState?.maybeWhen(
      authenticated: (user) => user.id,
      orElse: () => null,
    );
  }

  Future<bool> fetchTasksFromApi() async {
    final link = ref.keepAlive();

    try {
      if (!ref.mounted) {
        if (kDebugMode) {
          print('FetchApiTasksController no está montado al inicio');
        }
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

      final usecase = ref.read(fetchTasksFromApiUsecaseProvider);
      final result = await usecase(userId);

      if (!ref.mounted) {
        if (kDebugMode) {
          print(
            'FetchApiTasksController fue desechado durante la operación async',
          );
        }
        return false;
      }

      return result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error al traer tareas de API: ${failure.message}');
          }
          state = AsyncValue.error(failure.message, StackTrace.current);
          return false;
        },
        (tasks) {
          if (kDebugMode) print('${tasks.length} tareas traídas desde la API');

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
