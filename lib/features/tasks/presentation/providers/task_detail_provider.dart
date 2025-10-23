import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '/features/tasks/domain/domain.dart';
import 'task_usecases_provider.dart';

part 'task_detail_provider.g.dart';

@riverpod
Future<TaskEntitie?> taskDetail(Ref ref, String taskId) async {
  if (taskId.isEmpty) {
    if (kDebugMode) {
      print('Error: taskId vacío');
    }
    return null;
  }

  final usecase = ref.read(getTaskByIdUsecaseProvider);
  final result = await usecase(taskId);

  return result.fold((failure) {
    if (kDebugMode) {
      print('Error al cargar tarea: ${failure.message}');
    }
    return null;
  }, (task) => task);
}
