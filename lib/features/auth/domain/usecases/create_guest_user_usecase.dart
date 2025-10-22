import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/domain.dart';

class CreateGuestUserUsecase {
  final AuthRepository _repository;

  CreateGuestUserUsecase(this._repository);

  Future<Either<Failure, User>> call({required String name}) async {
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

    return await _repository.createGuestUser(name: name.trim());
  }
}
