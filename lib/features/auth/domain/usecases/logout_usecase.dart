import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/domain.dart';

class LogoutUsecase {
  final AuthRepository _repository;

  LogoutUsecase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.logout();
  }
}
