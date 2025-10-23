import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '/features/tasks/data/data.dart';
import '/features/tasks/domain/domain.dart';
import '/core/core.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDatasource _localDatasource;
  final TaskRemoteDatasource _remoteDatasource;

  TaskRepositoryImpl({
    required TaskLocalDatasource localDatasource,
    required TaskRemoteDatasource remoteDatasource,
    Uuid? uuid,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, List<TaskEntitie>>> getTasks({
    required String userId,
    TaskFilter? filter,
  }) async {
    try {
      // Estrategia offline-first: siempre obtener de SQLite
      final localTasks = await _localDatasource.getTasksByFilter(
        userId: userId,
        filter: filter,
      );

      // Intentar sincronizar en background (no bloqueante)
      _syncInBackground(userId);

      return Right(localTasks.map((model) => model.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en getTasks: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntitie>> getTaskById(String id) async {
    try {
      final taskModel = await _localDatasource.getTaskById(id);

      if (taskModel == null) {
        return const Left(Failure.cache(message: 'Tarea no encontrada'));
      }

      return Right(taskModel.toEntity());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en getTaskById: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntitie>> createTask(TaskEntitie task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);

      // 1. Guardar primero en SQLite (offline-first)
      await _localDatasource.insertTask(taskModel);

      // 2. Intentar subir a Firestore si es usuario autenticado
      try {
        // Verificar si tiene firebaseUid (usuario autenticado)
        // TODO: Esta verificación debería venir del auth state
        final shouldSync = true; // Por ahora siempre intentar

        if (shouldSync && task.source != TaskSource.api) {
          final firebaseTask = await _remoteDatasource.createTaskInFirestore(
            taskModel,
            task.userId,
          );

          // Actualizar con firebaseId y marcar como sincronizado
          final syncedTask = taskModel.copyWith(
            firebaseId: firebaseTask.firebaseId,
            synced: true,
          );

          await _localDatasource.updateTask(syncedTask);

          return Right(syncedTask.toEntity());
        }
      } on ServerException catch (e) {
        if (kDebugMode) {
          print('No se pudo sincronizar con Firestore: ${e.message}');
        }
        // No es un error crítico, la tarea está guardada localmente
      }

      return Right(taskModel.toEntity());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en createTask: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntitie>> updateTask(TaskEntitie task) async {
    try {
      final taskModel = TaskModel.fromEntity(task).copyWith(
        synced: false, // Marcar como no sincronizado
      );

      // 1. Actualizar en SQLite
      await _localDatasource.updateTask(taskModel);

      // 2. Intentar actualizar en Firestore
      try {
        if (taskModel.firebaseId != null) {
          await _remoteDatasource.updateTaskInFirestore(taskModel, task.userId);

          // Marcar como sincronizado
          await _localDatasource.markTaskAsSynced(
            task.id,
            taskModel.firebaseId,
          );
        }
      } on ServerException catch (e) {
        if (kDebugMode) {
          print('No se pudo sincronizar actualización: ${e.message}');
        }
      }

      return Right(taskModel.toEntity());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en updateTask: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      // 1. Obtener la tarea
      final task = await _localDatasource.getTaskById(id);

      if (task == null) {
        return const Left(Failure.cache(message: 'Tarea no encontrada'));
      }

      // 2. Soft delete en SQLite
      await _localDatasource.deleteTask(id);

      // 3. Intentar eliminar en Firestore
      try {
        if (task.firebaseId != null) {
          await _remoteDatasource.deleteTaskInFirestore(
            task.firebaseId!,
            task.userId,
          );
        }
      } on ServerException catch (e) {
        if (kDebugMode) {
          print('No se pudo sincronizar eliminación: ${e.message}');
        }
      }

      return const Right(null);
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en deleteTask: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntitie>> toggleTaskCompletion(String id) async {
    try {
      // 1. Obtener la tarea
      final task = await _localDatasource.getTaskById(id);

      if (task == null) {
        return const Left(Failure.cache(message: 'Tarea no encontrada'));
      }

      // 2. Cambiar el estado
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
        synced: false,
      );

      // 3. Actualizar en SQLite
      await _localDatasource.updateTask(updatedTask);

      // 4. Intentar sincronizar
      try {
        if (updatedTask.firebaseId != null) {
          await _remoteDatasource.updateTaskInFirestore(
            updatedTask,
            task.userId,
          );

          await _localDatasource.markTaskAsSynced(id, updatedTask.firebaseId);
        }
      } on ServerException catch (e) {
        if (kDebugMode) {
          print('No se pudo sincronizar cambio de estado: ${e.message}');
        }
      }

      return Right(updatedTask.toEntity());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en toggleTaskCompletion: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntitie>>> fetchTasksFromApi(
    String userId,
  ) async {
    try {
      // 1. Obtener tareas de la API
      final apiTasks = await _remoteDatasource.fetchTasksFromApi();

      // 2. Actualizar userId con el del usuario actual
      final tasksWithUserId = apiTasks.map((task) {
        return task.copyWith(userId: userId);
      }).toList();

      // 3. Guardar en SQLite
      await _localDatasource.insertTasks(tasksWithUserId);

      return Right(tasksWithUserId.map((model) => model.toEntity()).toList());
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en fetchTasksFromApi: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncTasks(String userId) async {
    try {
      // 1. Obtener tareas no sincronizadas
      final unsyncedTasks = await _localDatasource.getUnsyncedTasks(userId);

      if (unsyncedTasks.isEmpty) {
        if (kDebugMode) {
          print('No hay tareas para sincronizar');
        }
        return const Right(null);
      }

      // 2. Sincronizar cada tarea
      for (final task in unsyncedTasks) {
        try {
          if (task.firebaseId == null) {
            // Crear en Firestore
            final firebaseTask = await _remoteDatasource.createTaskInFirestore(
              task,
              userId,
            );

            await _localDatasource.markTaskAsSynced(
              task.id,
              firebaseTask.firebaseId,
            );
          } else {
            // Actualizar en Firestore
            await _remoteDatasource.updateTaskInFirestore(task, userId);

            await _localDatasource.markTaskAsSynced(task.id, task.firebaseId);
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error al sincronizar tarea ${task.id}: $e');
          }
          // Continuar con las demás tareas
        }
      }

      if (kDebugMode) {
        print('Sincronización completada');
      }

      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en syncTasks: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskStats>> getTaskStats(String userId) async {
    try {
      final counts = await _localDatasource.getTaskCounts(userId);

      final total = counts['total'] ?? 0;
      final completed = counts['completed'] ?? 0;
      final pending = counts['pending'] ?? 0;

      final completionRate = total > 0 ? (completed / total) * 100 : 0.0;

      final stats = TaskStats(
        total: total,
        completed: completed,
        pending: pending,
        completionRate: completionRate,
      );

      return Right(stats);
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en getTaskStats: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  /// Sincronización en background (no bloqueante)
  Future<void> _syncInBackground(String userId) async {
    try {
      await syncTasks(userId);
    } catch (e) {
      if (kDebugMode) {
        print('Error en sincronización background: $e');
      }
      // No propagamos el error
    }
  }
}
