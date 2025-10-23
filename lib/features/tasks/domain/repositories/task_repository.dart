import 'package:dartz/dartz.dart';

import '/features/tasks/domain/domain.dart';

import '/core/core.dart';

abstract class TaskRepository {
  /// Obtener todas las tareas del usuario
  Future<Either<Failure, List<TaskEntitie>>> getTasks({
    required String userId,
    TaskFilter? filter,
  });

  /// Obtener una tarea por ID
  Future<Either<Failure, TaskEntitie>> getTaskById(String id);

  /// Crear una nueva tarea
  Future<Either<Failure, TaskEntitie>> createTask(TaskEntitie task);

  /// Actualizar una tarea existente
  Future<Either<Failure, TaskEntitie>> updateTask(TaskEntitie task);

  /// Eliminar una tarea
  Future<Either<Failure, void>> deleteTask(String id);

  /// Cambiar estado de completado de una tarea
  Future<Either<Failure, TaskEntitie>> toggleTaskCompletion(String id);

  /// Obtener tareas desde la API
  Future<Either<Failure, List<TaskEntitie>>> fetchTasksFromApi(String userId);

  /// Sincronizar tareas locales no sincronizadas a Firestore
  Future<Either<Failure, void>> syncTasks(String userId);

  /// Obtener estadísticas de tareas
  Future<Either<Failure, TaskStats>> getTaskStats(String userId);
}

class TaskStats {
  final int total;
  final int completed;
  final int pending;
  final double completionRate;

  TaskStats({
    required this.total,
    required this.completed,
    required this.pending,
    required this.completionRate,
  });
}
