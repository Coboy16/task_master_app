import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

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
      // 1. Obtener usuario invitado
      final guestUser = await _localDatasource.getUserById(guestUserId);
      if (guestUser == null) {
        return const Left(
          Failure.cache(message: 'Usuario invitado no encontrado'),
        );
      }

      if (!guestUser.isGuest) {
        return const Left(
          Failure.validation(message: 'El usuario ya está autenticado'),
        );
      }

      // 2. Registrar en Firebase
      final authUserModel = await _remoteDatasource.registerWithEmail(
        email: email,
        password: password,
        name: guestUser.name,
      );

      // 3. Actualizar usuario local con datos de Firebase
      final updatedUser = guestUser.copyWith(
        email: email,
        isGuest: false,
        firebaseUid: authUserModel.firebaseUid,
        updatedAt: DateTime.now().toIso8601String(),
        synced: true,
      );

      await _localDatasource.updateUser(updatedUser);

      // 4. TODO: Sincronizar tareas del guest a Firestore
      // Esto se implementará en el módulo de tasks
      // await _syncGuestTasksToFirestore(guestUserId, authUserModel.firebaseUid!);

      if (kDebugMode) {
        print(
          ' Usuario migrado exitosamente: $guestUserId → ${authUserModel.firebaseUid}',
        );
      }

      return Right(updatedUser.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('Error en migración: $e');
      }
      return Left(Failure.unexpected(message: e.toString()));
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
