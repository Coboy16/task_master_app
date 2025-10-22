import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/domain.dart';

class LoginWithEmailUsecase {
  final AuthRepository _repository;

  LoginWithEmailUsecase(this._repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty) {
      return const Left(Failure.validation(message: 'El email es requerido'));
    }

    if (password.trim().isEmpty) {
      return const Left(
        Failure.validation(message: 'La contraseña es requerida'),
      );
    }

    if (!_isValidEmail(email)) {
      return const Left(Failure.validation(message: 'Email inválido'));
    }

    return await _repository.loginWithEmail(
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
