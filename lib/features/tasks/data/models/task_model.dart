import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/features/tasks/domain/domain.dart';
import '/features/tasks/data/data.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required String priority,
    required String source,
    required String userId,
    required String createdAt,
    required String updatedAt,
    String? firebaseId,
    @Default(false) bool synced,
    @Default(false) bool deleted,
  }) = _TaskModel;

  const TaskModel._();

  /// From Firestore JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  /// From Firestore Document
  factory TaskModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    String localId,
  ) {
    final data = snapshot.data()!;
    return TaskModel(
      id: localId,
      title: data['title'] as String,
      description: data['description'] as String? ?? '',
      isCompleted: data['isCompleted'] as bool? ?? false,
      priority: data['priority'] as String,
      source: data['source'] as String,
      userId: data['userId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
      firebaseId: snapshot.id,
      synced: true,
      deleted: data['deleted'] as bool? ?? false,
    );
  }

  /// To Firestore JSON
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'priority': priority,
      'source': source,
      'userId': userId,
      'createdAt': Timestamp.fromDate(DateTime.parse(createdAt)),
      'updatedAt': Timestamp.fromDate(DateTime.parse(updatedAt)),
      'deleted': deleted,
    };
  }

  /// From SQLite Map
  factory TaskModel.fromSQLite(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      isCompleted: map['is_completed'] == 1,
      priority: map['priority'] as String,
      source: map['source'] as String,
      userId: map['user_id'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      firebaseId: map['firebase_id'] as String?,
      synced: map['synced'] == 1,
      deleted: map['deleted'] == 1,
    );
  }

  /// To SQLite Map
  Map<String, dynamic> toSQLite() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0,
      'priority': priority,
      'source': source,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'firebase_id': firebaseId,
      'synced': synced ? 1 : 0,
      'deleted': deleted ? 1 : 0,
    };
  }

  /// From JSONPlaceholder API
  factory TaskModel.fromApiJson(Map<String, dynamic> json, String userId) {
    return TaskModel(
      id: 'api_${json['id']}',
      title: json['title'] as String,
      description: 'Tarea importada desde la API',
      isCompleted: json['completed'] as bool,
      priority: TaskPriority.medium.name,
      source: TaskSource.api.name,
      userId: userId,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      synced: true,
    );
  }

  /// Convert to Domain Entity
  TaskEntitie toEntity() {
    return TaskEntitie(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      priority: TaskPriority.fromJson(priority),
      source: TaskSource.fromJson(source),
      userId: userId,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      firebaseId: firebaseId,
      synced: synced,
      deleted: deleted,
    );
  }

  /// From Domain Entity
  factory TaskModel.fromEntity(TaskEntitie task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      priority: task.priority.name,
      source: task.source.name,
      userId: task.userId,
      createdAt: task.createdAt.toIso8601String(),
      updatedAt: task.updatedAt.toIso8601String(),
      firebaseId: task.firebaseId,
      synced: task.synced,
      deleted: task.deleted,
    );
  }
}
