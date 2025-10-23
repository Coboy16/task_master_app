import 'package:dartz/dartz.dart';

import '/features/tasks/domain/domain.dart';
import '/core/core.dart';

class GetTaskStatsUsecase {
  final TaskRepository _repository;

  GetTaskStatsUsecase(this._repository);

  Future<Either<Failure, TaskStats>> call(String userId) async {
    if (userId.trim().isEmpty) {
      return const Left(Failure.validation(message: 'ID de usuario inválido'));
    }

    return await _repository.getTaskStats(userId);
  }
}
