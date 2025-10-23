import 'package:dartz/dartz.dart';

import '/features/tasks/domain/domain.dart';
import '/core/core.dart';

class UpdateTaskUsecase {
  final TaskRepository _repository;

  UpdateTaskUsecase(this._repository);

  Future<Either<Failure, TaskEntitie>> call(TaskEntitie task) async {
    // Validaciones
    if (task.id.trim().isEmpty) {
      return const Left(Failure.validation(message: 'ID de tarea inválido'));
    }

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

    if (task.isFromApi) {
      return const Left(
        Failure.validation(message: 'No se pueden editar tareas de la API'),
      );
    }

    return await _repository.updateTask(task);
  }
}
