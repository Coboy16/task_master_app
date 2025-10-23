import 'package:dartz/dartz.dart';

import '/features/tasks/domain/domain.dart';
import '/core/core.dart';

/// Caso de uso para crear una tarea
class CreateTaskUsecase {
  final TaskRepository _repository;

  CreateTaskUsecase(this._repository);

  Future<Either<Failure, TaskEntitie>> call(TaskEntitie task) async {
    // Validaciones
    if (task.title.trim().isEmpty) {
      return const Left(Failure.validation(message: 'El título es requerido'));
    }

    if (task.title.length > 50) {
      return const Left(
        Failure.validation(message: 'El título no puede exceder 50 caracteres'),
      );
    }

    if (task.description.length > 250) {
      return const Left(
        Failure.validation(
          message: 'La descripción no puede exceder 250 caracteres',
        ),
      );
    }

    if (task.userId.trim().isEmpty) {
      return const Left(Failure.validation(message: 'ID de usuario inválido'));
    }

    return await _repository.createTask(task);
  }
}
