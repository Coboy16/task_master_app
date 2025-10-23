import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';

import '/features/tasks/data/data.dart';
import '/core/core.dart';

abstract class TaskRemoteDatasource {
  /// Obtener tareas de Firestore
  Future<List<TaskModel>> getTasksFromFirestore(String userId);

  /// Crear tarea en Firestore
  Future<TaskModel> createTaskInFirestore(TaskModel task, String userId);

  /// Actualizar tarea en Firestore
  Future<void> updateTaskInFirestore(TaskModel task, String userId);

  /// Eliminar tarea de Firestore
  Future<void> deleteTaskInFirestore(String firebaseId, String userId);

  /// Obtener tareas desde JSONPlaceholder API
  Future<List<TaskModel>> fetchTasksFromApi();
}

class TaskRemoteDatasourceImpl implements TaskRemoteDatasource {
  final FirebaseFirestore _firestore;
  final Dio _dio;
  final Uuid _uuid;

  TaskRemoteDatasourceImpl({
    required FirebaseFirestore firestore,
    required Dio dio,
    Uuid? uuid,
  }) : _firestore = firestore,
       _dio = dio,
       _uuid = uuid ?? const Uuid();

  @override
  Future<List<TaskModel>> getTasksFromFirestore(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .where('deleted', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .get();

      final tasks = snapshot.docs.map((doc) {
        return TaskModel.fromFirestore(doc, _uuid.v4());
      }).toList();

      if (kDebugMode) {
        print('${tasks.length} tareas obtenidas de Firestore');
      }

      return tasks;
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener tareas de Firestore: $e');
      }
      throw ServerException(
        'Error al obtener tareas de Firestore: ${e.toString()}',
      );
    }
  }

  @override
  Future<TaskModel> createTaskInFirestore(TaskModel task, String userId) async {
    try {
      // Crear documento en Firestore
      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(task.toFirestore());

      // Actualizar el modelo con el firebaseId
      final updatedTask = task.copyWith(firebaseId: docRef.id, synced: true);

      if (kDebugMode) {
        print('Tarea creada en Firestore: ${docRef.id}');
      }

      return updatedTask;
    } catch (e) {
      if (kDebugMode) {
        print('Error al crear tarea en Firestore: $e');
      }
      throw ServerException(
        'Error al crear tarea en Firestore: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> updateTaskInFirestore(TaskModel task, String userId) async {
    try {
      if (task.firebaseId == null) {
        throw ServerException('La tarea no tiene firebaseId');
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(task.firebaseId)
          .update(task.toFirestore());

      if (kDebugMode) {
        print('Tarea actualizada en Firestore: ${task.firebaseId}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al actualizar tarea en Firestore: $e');
      }
      throw ServerException(
        'Error al actualizar tarea en Firestore: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteTaskInFirestore(String firebaseId, String userId) async {
    try {
      // Soft delete en Firestore
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(firebaseId)
          .update({'deleted': true, 'updatedAt': Timestamp.now()});

      if (kDebugMode) {
        print('Tarea eliminada en Firestore: $firebaseId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al eliminar tarea en Firestore: $e');
      }
      throw ServerException(
        'Error al eliminar tarea en Firestore: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<TaskModel>> fetchTasksFromApi() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/todos',
        queryParameters: {'_limit': 20},
      );

      if (response.statusCode != 200) {
        throw ServerException('Error al obtener tareas de la API');
      }

      final List<dynamic> jsonList = response.data;

      // Generar un userId temporal para las tareas de API
      final tempUserId = 'api_user';

      final tasks = jsonList.map((json) {
        return TaskModel.fromApiJson(json as Map<String, dynamic>, tempUserId);
      }).toList();

      if (kDebugMode) {
        print('${tasks.length} tareas obtenidas de JSONPlaceholder');
      }

      return tasks;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: ${e.message}');
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Tiempo de espera agotado');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Sin conexión a internet');
      } else {
        throw ServerException('Error al obtener tareas de la API');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener tareas de la API: $e');
      }
      throw ServerException('Error inesperado: ${e.toString()}');
    }
  }
}
