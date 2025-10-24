import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '/features/auth/domain/domain.dart';
import '/features/auth/data/data.dart';
import '/core/core.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _localDatasource;
  final AuthRemoteDatasource _remoteDatasource;

  AuthRepositoryImpl({
    required AuthLocalDatasource localDatasource,
    required AuthRemoteDatasource remoteDatasource,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, User>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Login en Firebase
      final userModel = await _remoteDatasource.loginWithEmail(
        email: email,
        password: password,
      );

      // 2. Guardar en SQLite
      await _localDatasource.saveUser(userModel);

      if (kDebugMode) {
        print('✅ Usuario guardado localmente');
        print('🔄 Descargando tareas de Firestore...');
      }

      // 3. ✅ NUEVO: Descargar tareas de Firestore a SQLite
      try {
        await _downloadTasksFromFirestore(userModel);
      } catch (e) {
        if (kDebugMode) {
          print('⚠️ Error al descargar tareas: $e');
        }
        // No es un error crítico, el login fue exitoso
      }

      // 4. Retornar entidad
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en login: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  /// Descarga todas las tareas del usuario desde Firestore a SQLite
  Future<void> _downloadTasksFromFirestore(UserModel user) async {
    try {
      if (user.firebaseUid == null) {
        if (kDebugMode) {
          print('Usuario no tiene firebaseUid');
        }
        return;
      }

      final db = await _localDatasource.database;

      // Obtener tareas de Firestore
      final snapshot = await _remoteDatasource.firestore
          .collection('users')
          .doc(user.firebaseUid)
          .collection('tasks')
          .where('deleted', isEqualTo: false)
          .get();

      if (snapshot.docs.isEmpty) {
        if (kDebugMode) {
          print('No hay tareas en Firestore para descargar');
        }
        return;
      }

      if (kDebugMode) {
        print('Descargando ${snapshot.docs.length} tareas...');
      }

      int successCount = 0;

      // Guardar cada tarea en SQLite
      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();
          final taskId = const Uuid().v4();

          final taskData = {
            'id': taskId,
            'title': data['title'] as String,
            'description': data['description'] as String? ?? '',
            'is_completed': (data['isCompleted'] as bool? ?? false) ? 1 : 0,
            'priority': data['priority'] as String,
            'source': data['source'] as String,
            'user_id': user.id,
            'created_at': (data['createdAt'] as Timestamp)
                .toDate()
                .toIso8601String(),
            'updated_at': (data['updatedAt'] as Timestamp)
                .toDate()
                .toIso8601String(),
            'firebase_id': doc.id,
            'synced': 1,
            'deleted': 0,
          };

          await db.insert(
            'tasks',
            taskData,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          successCount++;
        } catch (e) {
          if (kDebugMode) {
            print('Error al descargar tarea: $e');
          }
        }
      }

      if (kDebugMode) {
        print('Tareas descargadas: $successCount');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al descargar tareas de Firestore: $e');
      }
      throw Exception('Error al descargar tareas: $e');
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userModel = await _remoteDatasource.registerWithEmail(
        email: email,
        password: password,
        name: name,
      );

      await _localDatasource.saveUser(userModel);

      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en registro: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> createGuestUser({required String name}) async {
    try {
      final userModel = await _localDatasource.createGuestUser(name);

      return Right(userModel.toEntity());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error al crear usuario invitado: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await _localDatasource.getCurrentUser();

      if (userModel == null) {
        return const Right(null);
      }

      return Right(userModel.toEntity());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener usuario actual: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final currentFirebaseUser = _remoteDatasource.getCurrentFirebaseUser();
      if (currentFirebaseUser != null) {
        await _remoteDatasource.logout();
      }

      await _localDatasource.clearSession();

      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.toString()));
    } catch (e) {
      if (kDebugMode) {
        print('Error al cerrar sesión: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> migrateGuestToAuthUser({
    required String guestUserId,
    required String email,
    required String password,
  }) async {
    try {
      // 1. Obtener el usuario invitado desde SQLite
      final guestUser = await _localDatasource.getUserById(guestUserId);

      if (guestUser == null) {
        return const Left(
          Failure.validation(message: 'Usuario invitado no encontrado'),
        );
      }

      if (!guestUser.isGuest) {
        return const Left(
          Failure.validation(message: 'Este usuario ya está autenticado'),
        );
      }

      if (kDebugMode) {
        print('Iniciando migración de usuario invitado: ${guestUser.name}');
      }

      // 2. Crear cuenta en Firebase Auth con el nombre del usuario guest
      final firebaseUser = await _remoteDatasource.registerWithEmail(
        email: email,
        password: password,
        name: guestUser.name,
      );

      if (kDebugMode) {
        print(' Cuenta Firebase creada: ${firebaseUser.firebaseUid}');
      }

      // 3. Migrar tareas locales a Firestore
      await _migrateLocalTasksToFirestore(
        guestUserId,
        firebaseUser.firebaseUid!,
      );

      // 4. Actualizar todas las tareas en SQLite con el nuevo userId
      final db = await _localDatasource.database;
      await db.update(
        'tasks',
        {'user_id': firebaseUser.id},
        where: 'user_id = ?',
        whereArgs: [guestUserId],
      );

      if (kDebugMode) {
        print('Tareas actualizadas con nuevo userId');
      }

      // 5. Eliminar el usuario invitado de SQLite
      await db.delete('users', where: 'id = ?', whereArgs: [guestUserId]);

      if (kDebugMode) {
        print('Usuario invitado eliminado de SQLite');
      }

      // 6. Limpiar sesión anterior
      await _localDatasource.clearSession();

      // 7. Guardar el nuevo usuario autenticado en SQLite
      await _localDatasource.saveUser(firebaseUser);

      if (kDebugMode) {
        print('Migración completada exitosamente');
      }

      return Right(firebaseUser.toEntity());
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Error en migración: ${e.code} - ${e.message}');
      }

      final errorMessage = FirebaseError.getAuthErrorMessage(e.code);
      return Left(Failure.auth(message: errorMessage));
    } catch (e, s) {
      if (kDebugMode) {
        print('Error inesperado en migración: $e');
        print(s);
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  /// Migra las tareas locales del usuario invitado a Firestore
  Future<void> _migrateLocalTasksToFirestore(
    String guestUserId,
    String firebaseUid,
  ) async {
    try {
      if (kDebugMode) {
        print('Iniciando migración de tareas a Firestore...');
        print('Usando firebaseUid: $firebaseUid');
      }

      final db = await _localDatasource.database;

      final tasksData = await db.query(
        'tasks',
        where: 'user_id = ? AND deleted = ?',
        whereArgs: [guestUserId, 0],
      );

      if (tasksData.isEmpty) {
        if (kDebugMode) {
          print('No hay tareas para migrar');
        }
        return;
      }

      if (kDebugMode) {
        print('Migrando ${tasksData.length} tareas...');
      }

      int successCount = 0;
      int errorCount = 0;

      for (final taskData in tasksData) {
        try {
          final taskMap = Map<String, dynamic>.from(taskData);

          final createdAt = DateTime.parse(taskMap['created_at'] as String);
          final updatedAt = DateTime.parse(taskMap['updated_at'] as String);

          final firestoreData = {
            'title': taskMap['title'],
            'description': taskMap['description'],
            'isCompleted': taskMap['is_completed'] == 1,
            'priority': taskMap['priority'],
            'source': taskMap['source'],
            'createdAt': createdAt,
            'updatedAt': updatedAt,
            'deleted': false,
          };

          final docRef = await _remoteDatasource.firestore
              .collection('users')
              .doc(firebaseUid)
              .collection('tasks')
              .add(firestoreData);

          await db.update(
            'tasks',
            {'firebase_id': docRef.id, 'synced': 1},
            where: 'id = ?',
            whereArgs: [taskMap['id']],
          );

          successCount++;

          if (kDebugMode) {
            print('Tarea migrada: ${taskMap['title']}');
          }
        } catch (e) {
          errorCount++;
          if (kDebugMode) {
            print(' Error al migrar tarea: $e');
          }
        }
      }

      if (kDebugMode) {
        print('Migración de tareas completada:');
        print('- Exitosas: $successCount');
        print('- Con errores: $errorCount');
      }
    } catch (e) {
      if (kDebugMode) {
        print(' Error crítico en migración de tareas: $e');
      }
      throw Exception('Error al migrar tareas: $e');
    }
  }

  @override
  Future<Either<Failure, bool>> hasActiveSession() async {
    try {
      final hasSession = await _localDatasource.hasActiveSession();
      return Right(hasSession);
    } catch (e) {
      if (kDebugMode) {
        print('Error al verificar sesión: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
    }
  }
}
