import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/domain.dart';

abstract class AuthRepository {
  /// Login con email y contraseña (Firebase Auth)
  Future<Either<Failure, User>> loginWithEmail({
    required String email,
    required String password,
  });

  /// Registro con email y contraseña (Firebase Auth)
  Future<Either<Failure, User>> registerWithEmail({
    required String email,
    required String password,
    required String name,
  });

  /// Crear usuario invitado (solo SQLite)
  Future<Either<Failure, User>> createGuestUser({required String name});

  /// Obtener usuario actual (desde SharedPreferences + SQLite)
  Future<Either<Failure, User?>> getCurrentUser();

  /// Cerrar sesión
  Future<Either<Failure, void>> logout();

  /// Convertir cuenta guest en cuenta autenticada con Firebase
  /// y sincronizar todas las tareas locales a Firestore
  Future<Either<Failure, User>> migrateGuestToAuthUser({
    required String guestUserId,
    required String email,
    required String password,
  });

  /// Verificar si hay una sesión activa
  Future<Either<Failure, bool>> hasActiveSession();
}
