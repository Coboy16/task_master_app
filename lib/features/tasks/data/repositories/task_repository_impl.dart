import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '/features/tasks/data/data.dart';
import '/features/tasks/domain/domain.dart';
import '/features/auth/data/data.dart';
import '/core/core.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDatasource _localDatasource;
  final TaskRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _authLocalDatasource;

  TaskRepositoryImpl({
    required TaskLocalDatasource localDatasource,
    required TaskRemoteDatasource remoteDatasource,
    required AuthLocalDatasource authLocalDatasource,
    Uuid? uuid,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource,
       _authLocalDatasource = authLocalDatasource;

  Future<String?> _getFirebaseUid() async {
    try {
      final user = await _authLocalDatasource.getCurrentUser();
      return user?.firebaseUid;
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener firebaseUid: $e');
      }
      return null;
    }
  }

  @override
  Future<Either<Failure, List<TaskEntitie>>> getTasks({
    required String userId,
    TaskFilter? filter,
  }) async {
    try {
      final localTasks = await _localDatasource.getTasksByFilter(
        userId: userId,
        filter: filter,
      );

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

      if (kDebugMode) {
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('CREAR TAREA');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('• Title: ${task.title}');
        print('• userId (local): ${task.userId}');
        print('• source: ${task.source.name}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      }

      // 1. Guardar primero en SQLite (offline-first)
      await _localDatasource.insertTask(taskModel);

      if (kDebugMode) {
        print('Tarea guardada en SQLite');
      }

      // 2. Intentar subir a Firestore
      try {
        // Obtener firebaseUid del usuario actual
        final firebaseUid = await _getFirebaseUid();

        if (kDebugMode) {
          print('FirebaseUid obtenido: $firebaseUid');
        }

        if (firebaseUid != null) {
          if (kDebugMode) {
            print('Intentando subir a Firestore...');
            print('Ruta: users/$firebaseUid/tasks/');
          }

          final firebaseTask = await _remoteDatasource.createTaskInFirestore(
            taskModel,
            firebaseUid,
          );

          if (kDebugMode) {
            print('Tarea subida exitosamente');
            print('firebaseId: ${firebaseTask.firebaseId}');
          }

          final syncedTask = taskModel.copyWith(
            firebaseId: firebaseTask.firebaseId,
            synced: true,
          );

          await _localDatasource.updateTask(syncedTask);

          if (kDebugMode) {
            print('Tarea marcada como sincronizada en SQLite');
            print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
          }

          return Right(syncedTask.toEntity());
        } else {
          if (kDebugMode) {
            print('Usuario no tiene firebaseUid');
            print('Tarea guardada solo localmente');
            print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
          }
        }
      } on ServerException catch (e) {
        if (kDebugMode) {
          print('Error al sincronizar con Firestore');
          print('Error: ${e.message}');
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
        }
      }

      return Right(taskModel.toEntity());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error inesperado en createTask');
        print('Stack: $stackTrace');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntitie>> updateTask(TaskEntitie task) async {
    try {
      final taskModel = TaskModel.fromEntity(task).copyWith(synced: false);

      await _localDatasource.updateTask(taskModel);

      try {
        final shouldSync = taskModel.firebaseId != null;

        if (shouldSync) {
          final firebaseUid = await _getFirebaseUid();

          if (firebaseUid != null) {
            await _remoteDatasource.updateTaskInFirestore(
              taskModel,
              firebaseUid,
            );

            await _localDatasource.markTaskAsSynced(
              task.id,
              taskModel.firebaseId,
            );
          }
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
      final task = await _localDatasource.getTaskById(id);

      if (task == null) {
        return const Left(Failure.cache(message: 'Tarea no encontrada'));
      }

      await _localDatasource.deleteTask(id);

      try {
        final shouldSync = task.firebaseId != null;

        if (shouldSync) {
          final firebaseUid = await _getFirebaseUid();

          if (firebaseUid != null) {
            await _remoteDatasource.deleteTaskInFirestore(
              task.firebaseId!,
              firebaseUid,
            );
          }
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
      final task = await _localDatasource.getTaskById(id);

      if (task == null) {
        return const Left(Failure.cache(message: 'Tarea no encontrada'));
      }

      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
        synced: false,
      );

      await _localDatasource.updateTask(updatedTask);

      try {
        final shouldSync = updatedTask.firebaseId != null;

        if (shouldSync) {
          final firebaseUid = await _getFirebaseUid();

          if (firebaseUid != null) {
            await _remoteDatasource.updateTaskInFirestore(
              updatedTask,
              firebaseUid,
            );

            await _localDatasource.markTaskAsSynced(id, updatedTask.firebaseId);
          }
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
      final apiTasks = await _remoteDatasource.fetchTasksFromApi();

      final tasksWithUserId = apiTasks.map((task) {
        return task.copyWith(userId: userId);
      }).toList();

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
      final firebaseUid = await _getFirebaseUid();

      if (firebaseUid == null) {
        if (kDebugMode) {
          print('Usuario invitado: sincronización omitida');
        }
        return const Right(null);
      }

      final unsyncedTasks = await _localDatasource.getUnsyncedTasks(userId);

      if (unsyncedTasks.isEmpty) {
        if (kDebugMode) {
          print('No hay tareas para sincronizar');
        }
        return const Right(null);
      }

      for (final task in unsyncedTasks) {
        try {
          if (task.firebaseId == null) {
            final firebaseTask = await _remoteDatasource.createTaskInFirestore(
              task,
              firebaseUid,
            );

            await _localDatasource.markTaskAsSynced(
              task.id,
              firebaseTask.firebaseId,
            );
          } else {
            await _remoteDatasource.updateTaskInFirestore(task, firebaseUid);

            await _localDatasource.markTaskAsSynced(task.id, task.firebaseId);
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error al sincronizar tarea ${task.id}: $e');
          }
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

  Future<void> _syncInBackground(String userId) async {
    try {
      final firebaseUid = await _getFirebaseUid();
      if (firebaseUid == null) {
        return;
      }
      await syncTasks(userId);
    } catch (e) {
      if (kDebugMode) {
        print('Error en sincronización background: $e');
      }
    }
  }
}
