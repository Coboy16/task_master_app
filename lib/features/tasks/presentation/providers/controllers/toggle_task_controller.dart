import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/tasks/domain/domain.dart';
import '/features/tasks/presentation/providers/providers.dart';

part 'toggle_task_controller.g.dart';

@riverpod
class ToggleTaskController extends _$ToggleTaskController {
  @override
  Future<TaskEntitie?> build() async => null;

  Future<bool> toggleTaskCompletion(String taskId) async {
    final link = ref.keepAlive();

    try {
      if (!ref.mounted) {
        if (kDebugMode) {
          print('ToggleTaskController ya no está montado al inicio.');
        }
        return false;
      }

      state = const AsyncValue.loading();

      final usecase = ref.read(toggleTaskCompletionUsecaseProvider);
      final result = await usecase(taskId);

      if (ref.mounted) {
        result.fold(
          (failure) {
            if (kDebugMode) {
              print('Error al cambiar estado: ${failure.message}');
            }
            state = AsyncValue.error(failure.message, StackTrace.current);
          },
          (updatedTask) {
            if (kDebugMode) print('Estado de tarea actualizado en controlador');
            state = AsyncValue.data(updatedTask);
          },
        );
        return true;
      } else {
        if (kDebugMode) print('ToggleTaskController desechado durante await.');
        return false;
      }
    } finally {
      link.close();
    }
  }
}
