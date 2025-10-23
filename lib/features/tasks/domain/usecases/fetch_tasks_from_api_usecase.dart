import 'package:dartz/dartz.dart';

import '/features/tasks/domain/domain.dart';
import '/core/core.dart';

class FetchTasksFromApiUsecase {
  final TaskRepository _repository;

  FetchTasksFromApiUsecase(this._repository);

  Future<Either<Failure, List<TaskEntitie>>> call(String userId) async {
    if (userId.trim().isEmpty) {
      return const Left(Failure.validation(message: 'ID de usuario inválido'));
    }

    return await _repository.fetchTasksFromApi(userId);
  }
}
