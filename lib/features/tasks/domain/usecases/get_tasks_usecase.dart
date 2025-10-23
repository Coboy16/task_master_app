import 'package:dartz/dartz.dart';

import '/features/tasks/domain/domain.dart';
import '/core/core.dart';

class GetTasksUsecase {
  final TaskRepository _repository;

  GetTasksUsecase(this._repository);

  Future<Either<Failure, List<TaskEntitie>>> call({
    required String userId,
    TaskFilter? filter,
  }) async {
    if (userId.trim().isEmpty) {
      return const Left(Failure.validation(message: 'ID de usuario inválido'));
    }

    return await _repository.getTasks(userId: userId, filter: filter);
  }
}
