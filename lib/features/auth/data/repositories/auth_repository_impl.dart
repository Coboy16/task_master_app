import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

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

      // 3. Retornar entidad
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

  @override
  Future<Either<Failure, User>> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // 1. Registrar en Firebase
      final userModel = await _remoteDatasource.registerWithEmail(
        email: email,
        password: password,
        name: name,
      );

      // 2. Guardar en SQLite
      await _localDatasource.saveUser(userModel);

      // 3. Retornar entidad
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
      // Crear usuario invitado solo en SQLite
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
      // 1. Logout de Firebase (si está autenticado)
      final currentFirebaseUser = _remoteDatasource.getCurrentFirebaseUser();
      if (currentFirebaseUser != null) {
        await _remoteDatasource.logout();
      }

      // 2. Limpiar sesión local
      await _localDatasource.clearSession();

      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
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
        print('🔄 Iniciando migración de usuario invitado: ${guestUser.name}');
      }

      // 2. Crear cuenta en Firebase Auth con el nombre del usuario guest
      final firebaseUser = await _remoteDatasource.registerWithEmail(
        email: email,
        password: password,
        name: guestUser.name, // Usar el nombre del guest
      );

      if (kDebugMode) {
        print('✅ Cuenta Firebase creada: ${firebaseUser.firebaseUid}');
      }

      // 3. TODO: Migrar tareas locales a Firestore
      // Esto lo implementaremos cuando tengamos el TaskRepository
      // await _migrateLocalTasksToFirestore(guestUserId, firebaseUser.firebaseUid!);

      // 4. Eliminar el usuario invitado de SQLite
      final db = await _localDatasource.database;
      await db.delete('users', where: 'id = ?', whereArgs: [guestUserId]);

      if (kDebugMode) {
        print('✅ Usuario invitado eliminado de SQLite');
      }

      // 5. Eliminar token de invitado de SharedPreferences
      await _localDatasource.clearSession();

      // 6. Guardar el nuevo usuario autenticado en SQLite
      await _localDatasource.saveUser(firebaseUser);

      if (kDebugMode) {
        print('✅ Migración completada exitosamente');
      }

      // 7. Retornar el usuario autenticado
      return Right(firebaseUser.toEntity());
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('❌ Firebase Auth Error en migración: ${e.code} - ${e.message}');
      }

      final errorMessage = FirebaseError.getAuthErrorMessage(e.code);
      return Left(Failure.auth(message: errorMessage));
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
