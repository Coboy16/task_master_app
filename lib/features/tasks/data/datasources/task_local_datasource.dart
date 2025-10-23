import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

import '/core/core.dart';
import '/features/tasks/data/data.dart';
import '/features/tasks/domain/domain.dart';

abstract class TaskLocalDatasource {
  /// Obtener todas las tareas de un usuario
  Future<List<TaskModel>> getAllTasks(String userId);

  /// Obtener tareas con filtro
  Future<List<TaskModel>> getTasksByFilter({
    required String userId,
    TaskFilter? filter,
  });

  /// Obtener tarea por ID
  Future<TaskModel?> getTaskById(String id);

  /// Insertar una tarea
  Future<void> insertTask(TaskModel task);

  /// Insertar múltiples tareas (bulk insert)
  Future<void> insertTasks(List<TaskModel> tasks);

  /// Actualizar una tarea
  Future<void> updateTask(TaskModel task);

  /// Eliminar tarea (soft delete - marca como deleted)
  Future<void> deleteTask(String id);

  /// Eliminar tarea físicamente
  Future<void> hardDeleteTask(String id);

  /// Obtener tareas no sincronizadas
  Future<List<TaskModel>> getUnsyncedTasks(String userId);

  /// Marcar tarea como sincronizada
  Future<void> markTaskAsSynced(String id, String? firebaseId);

  /// Obtener conteo de tareas
  Future<Map<String, int>> getTaskCounts(String userId);

  /// Limpiar todas las tareas de un usuario
  Future<void> clearAllTasks(String userId);
}

class TaskLocalDatasourceImpl implements TaskLocalDatasource {
  final AppDatabase _database;

  TaskLocalDatasourceImpl({required AppDatabase database})
    : _database = database;

  @override
  Future<List<TaskModel>> getAllTasks(String userId) async {
    try {
      final db = await _database.database;

      final results = await db.query(
        'tasks',
        where: 'user_id = ? AND deleted = ?',
        whereArgs: [userId, 0],
        orderBy: 'created_at DESC',
      );

      return results.map((map) => TaskModel.fromSQLite(map)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener tareas: $e');
      }
      throw CacheException('Error al obtener tareas: ${e.toString()}');
    }
  }

  @override
  Future<List<TaskModel>> getTasksByFilter({
    required String userId,
    TaskFilter? filter,
  }) async {
    try {
      final db = await _database.database;

      // Construir query según filtro
      String whereClause = 'user_id = ? AND deleted = ?';
      List<dynamic> whereArgs = [userId, 0];

      if (filter != null) {
        // Filtro por tipo (all, pending, completed)
        if (filter.type == TaskFilterType.pending) {
          whereClause += ' AND is_completed = ?';
          whereArgs.add(0);
        } else if (filter.type == TaskFilterType.completed) {
          whereClause += ' AND is_completed = ?';
          whereArgs.add(1);
        }

        // Filtro por prioridad
        if (filter.priority != null) {
          whereClause += ' AND priority = ?';
          whereArgs.add(filter.priority!.name);
        }

        // Filtro por fuente
        if (filter.source != null) {
          whereClause += ' AND source = ?';
          whereArgs.add(filter.source!.name);
        }

        // Búsqueda por texto
        if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
          whereClause += ' AND (title LIKE ? OR description LIKE ?)';
          final searchTerm = '%${filter.searchQuery}%';
          whereArgs.add(searchTerm);
          whereArgs.add(searchTerm);
        }
      }

      final results = await db.query(
        'tasks',
        where: whereClause,
        whereArgs: whereArgs,
        orderBy: 'created_at DESC',
      );

      return results.map((map) => TaskModel.fromSQLite(map)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error al filtrar tareas: $e');
      }
      throw CacheException('Error al filtrar tareas: ${e.toString()}');
    }
  }

  @override
  Future<TaskModel?> getTaskById(String id) async {
    try {
      final db = await _database.database;

      final results = await db.query(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (results.isEmpty) {
        return null;
      }

      return TaskModel.fromSQLite(results.first);
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener tarea por ID: $e');
      }
      throw CacheException('Error al obtener tarea: ${e.toString()}');
    }
  }

  @override
  Future<void> insertTask(TaskModel task) async {
    try {
      final db = await _database.database;

      await db.insert(
        'tasks',
        task.toSQLite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (kDebugMode) {
        print('Tarea insertada: ${task.id}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al insertar tarea: $e');
      }
      throw CacheException('Error al guardar tarea: ${e.toString()}');
    }
  }

  @override
  Future<void> insertTasks(List<TaskModel> tasks) async {
    try {
      final db = await _database.database;

      final batch = db.batch();
      for (final task in tasks) {
        batch.insert(
          'tasks',
          task.toSQLite(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);

      if (kDebugMode) {
        print('${tasks.length} tareas insertadas');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al insertar tareas en lote: $e');
      }
      throw CacheException('Error al guardar tareas: ${e.toString()}');
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      final db = await _database.database;

      final updatedTask = task.copyWith(
        updatedAt: DateTime.now().toIso8601String(),
      );

      await db.update(
        'tasks',
        updatedTask.toSQLite(),
        where: 'id = ?',
        whereArgs: [task.id],
      );

      if (kDebugMode) {
        print('Tarea actualizada: ${task.id}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al actualizar tarea: $e');
      }
      throw CacheException('Error al actualizar tarea: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      final db = await _database.database;

      // Soft delete: marcar como deleted
      await db.update(
        'tasks',
        {'deleted': 1, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [id],
      );

      if (kDebugMode) {
        print('Tarea marcada como eliminada: $id');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al eliminar tarea: $e');
      }
      throw CacheException('Error al eliminar tarea: ${e.toString()}');
    }
  }

  @override
  Future<void> hardDeleteTask(String id) async {
    try {
      final db = await _database.database;

      await db.delete('tasks', where: 'id = ?', whereArgs: [id]);

      if (kDebugMode) {
        print('Tarea eliminada físicamente: $id');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al eliminar tarea físicamente: $e');
      }
      throw CacheException('Error al eliminar tarea: ${e.toString()}');
    }
  }

  @override
  Future<List<TaskModel>> getUnsyncedTasks(String userId) async {
    try {
      final db = await _database.database;

      final results = await db.query(
        'tasks',
        where: 'user_id = ? AND synced = ? AND deleted = ? AND source != ?',
        whereArgs: [userId, 0, 0, 'api'],
        orderBy: 'created_at ASC',
      );

      return results.map((map) => TaskModel.fromSQLite(map)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener tareas no sincronizadas: $e');
      }
      throw CacheException(
        'Error al obtener tareas no sincronizadas: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> markTaskAsSynced(String id, String? firebaseId) async {
    try {
      final db = await _database.database;

      await db.update(
        'tasks',
        {
          'synced': 1,
          'firebase_id': firebaseId,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );

      if (kDebugMode) {
        print('Tarea marcada como sincronizada: $id');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al marcar tarea como sincronizada: $e');
      }
      throw CacheException(
        'Error al marcar tarea como sincronizada: ${e.toString()}',
      );
    }
  }

  @override
  Future<Map<String, int>> getTaskCounts(String userId) async {
    try {
      final db = await _database.database;

      // Total de tareas
      final totalResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM tasks WHERE user_id = ? AND deleted = ?',
        [userId, 0],
      );
      final total = totalResult.first['count'] as int;

      // Tareas completadas
      final completedResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM tasks '
        'WHERE user_id = ? AND deleted = ? AND is_completed = ?',
        [userId, 0, 1],
      );
      final completed = completedResult.first['count'] as int;

      // Tareas pendientes
      final pending = total - completed;

      return {'total': total, 'completed': completed, 'pending': pending};
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener conteos: $e');
      }
      throw CacheException('Error al obtener estadísticas: ${e.toString()}');
    }
  }

  @override
  Future<void> clearAllTasks(String userId) async {
    try {
      final db = await _database.database;

      await db.delete('tasks', where: 'user_id = ?', whereArgs: [userId]);

      if (kDebugMode) {
        print('Todas las tareas del usuario eliminadas');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al limpiar tareas: $e');
      }
      throw CacheException('Error al limpiar tareas: ${e.toString()}');
    }
  }
}
