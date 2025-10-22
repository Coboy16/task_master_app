import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/domain.dart';

class CheckAuthStatusUsecase {
  final AuthRepository _repository;

  CheckAuthStatusUsecase(this._repository);

  Future<Either<Failure, bool>> call() async {
    return await _repository.hasActiveSession();
  }
}
