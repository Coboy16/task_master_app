import 'package:dartz/dartz.dart';

import '/features/tasks/domain/domain.dart';
import '/core/core.dart';

class GetTaskByIdUsecase {
  final TaskRepository _repository;

  GetTaskByIdUsecase(this._repository);

  Future<Either<Failure, TaskEntitie>> call(String taskId) async {
    if (taskId.trim().isEmpty) {
      return const Left(Failure.validation(message: 'ID de tarea inválido'));
    }

    return await _repository.getTaskById(taskId);
  }
}
