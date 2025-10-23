import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '/core/core.dart';
import '/features/tasks/data/data.dart';
import '/features/tasks/domain/domain.dart';

part 'task_dependencies_provider.g.dart';

// ==================== EXTERNAL DEPENDENCIES ====================

@Riverpod(keepAlive: true)
FirebaseFirestore firestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
}

@Riverpod(keepAlive: true)
Uuid uuid(Ref ref) {
  return const Uuid();
}

// ==================== DATASOURCES PROVIDERS ====================

@Riverpod(keepAlive: true)
TaskLocalDatasource taskLocalDatasource(Ref ref) {
  return TaskLocalDatasourceImpl(database: AppDatabase.instance);
}

@Riverpod(keepAlive: true)
TaskRemoteDatasource taskRemoteDatasource(Ref ref) {
  return TaskRemoteDatasourceImpl(
    firestore: ref.watch(firestoreProvider),
    dio: ref.watch(dioProvider),
    uuid: ref.watch(uuidProvider),
  );
}

// ==================== REPOSITORY PROVIDER ====================

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(
    localDatasource: ref.watch(taskLocalDatasourceProvider),
    remoteDatasource: ref.watch(taskRemoteDatasourceProvider),
  );
}
