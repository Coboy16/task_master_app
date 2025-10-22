import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/domain.dart';

class MigrateGuestToAuthUsecase {
  final AuthRepository _repository;

  MigrateGuestToAuthUsecase(this._repository);

  /// Convierte un usuario invitado en usuario autenticado
  /// y sincroniza todas sus tareas locales a Firestore
  Future<Either<Failure, User>> call({
    required String guestUserId,
    required String email,
    required String password,
  }) async {
    if (guestUserId.trim().isEmpty) {
      return const Left(Failure.validation(message: 'ID de usuario inválido'));
    }

    if (email.trim().isEmpty) {
      return const Left(Failure.validation(message: 'El email es requerido'));
    }

    if (!_isValidEmail(email)) {
      return const Left(Failure.validation(message: 'Email inválido'));
    }

    if (password.length < 6) {
      return const Left(
        Failure.validation(
          message: 'La contraseña debe tener al menos 6 caracteres',
        ),
      );
    }

    return await _repository.migrateGuestToAuthUser(
      guestUserId: guestUserId,
      email: email.trim(),
      password: password,
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
