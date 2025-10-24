import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/tasks/domain/domain.dart';
import '/features/tasks/presentation/providers/providers.dart';

part 'update_task_controller.g.dart';

@riverpod
class UpdateTaskController extends _$UpdateTaskController {
  @override
  Future<void> build() async {}

  Future<bool> updateTask(TaskEntitie task) async {
    final link = ref.keepAlive();

    try {
      if (!ref.mounted) {
        if (kDebugMode) {
          print('UpdateTaskController ya no está montado al inicio.');
        }
        return false;
      }

      state = const AsyncValue.loading();

      final usecase = ref.read(updateTaskUsecaseProvider);
      final result = await usecase(task);

      if (ref.mounted) {
        result.fold(
          (failure) {
            if (kDebugMode) {
              print('Error al actualizar tarea: ${failure.message}');
            }
            state = AsyncValue.error(failure.message, StackTrace.current);
          },
          (_) {
            if (kDebugMode) {
              print('Tarea actualizada exitosamente en controlador');
            }
            state = const AsyncValue.data(null);
          },
        );
        return true;
      } else {
        if (kDebugMode) print('UpdateTaskController desechado durante await.');
        return false;
      }
    } finally {
      link.close();
    }
  }
}
