import 'package:freezed_annotation/freezed_annotation.dart';

import '/features/tasks/data/data.dart';

part 'task.freezed.dart';

@freezed
abstract class TaskEntitie with _$TaskEntitie {
  const factory TaskEntitie({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required TaskPriority priority,
    required TaskSource source,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? firebaseId,
    @Default(false) bool synced,
    @Default(false) bool deleted,
  }) = _TaskEntitie;

  const TaskEntitie._();

  /// Necesita sincronización con Firestore
  bool get needsSync => !synced && !deleted && source != TaskSource.api;

  /// Es una tarea de API (solo lectura)
  bool get isFromApi => source == TaskSource.api;

  /// Puede ser editada
  bool get canBeEdited =>
      source == TaskSource.local || source == TaskSource.firebase;

  /// Texto de prioridad para UI
  String get priorityText {
    switch (priority) {
      case TaskPriority.high:
        return 'Alta';
      case TaskPriority.medium:
        return 'Media';
      case TaskPriority.low:
        return 'Baja';
    }
  }

  /// Texto de origen para UI
  String get sourceText {
    switch (source) {
      case TaskSource.api:
        return 'API';
      case TaskSource.firebase:
        return 'Firebase';
      case TaskSource.local:
        return 'Local';
    }
  }

  /// Color de prioridad
  int get priorityColor {
    switch (priority) {
      case TaskPriority.high:
        return 0xFFFF3B30;
      case TaskPriority.medium:
        return 0xFFFF9500;
      case TaskPriority.low:
        return 0xFF34C759;
    }
  }
}
