import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/domain.dart';

class RegisterWithEmailUsecase {
  final AuthRepository _repository;

  RegisterWithEmailUsecase(this._repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    required String name,
  }) async {
    if (name.trim().isEmpty) {
      return const Left(Failure.validation(message: 'El nombre es requerido'));
    }

    if (name.trim().length < 2) {
      return const Left(
        Failure.validation(
          message: 'El nombre debe tener al menos 2 caracteres',
        ),
      );
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

    return await _repository.registerWithEmail(
      email: email.trim(),
      password: password,
      name: name.trim(),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
