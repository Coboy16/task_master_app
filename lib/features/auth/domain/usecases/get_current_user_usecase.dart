import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/domain.dart';

class GetCurrentUserUsecase {
  final AuthRepository _repository;

  GetCurrentUserUsecase(this._repository);

  Future<Either<Failure, User?>> call() async {
    return await _repository.getCurrentUser();
  }
}
