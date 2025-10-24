// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dependencies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firestore)
const firestoreProvider = FirestoreProvider._();

final class FirestoreProvider
    extends
        $FunctionalProvider<
          FirebaseFirestore,
          FirebaseFirestore,
          FirebaseFirestore
        >
    with $Provider<FirebaseFirestore> {
  const FirestoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firestoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firestoreHash();

  @$internal
  @override
  $ProviderElement<FirebaseFirestore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseFirestore create(Ref ref) {
    return firestore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFirestore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFirestore>(value),
    );
  }
}

String _$firestoreHash() => r'a56abe42f3fb3ee8bfee4e56b46a7bf8561bdc93';

@ProviderFor(dio)
const dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'3cf35533f9c5441fdeddeaba7103ed6c40b955b4';

@ProviderFor(uuid)
const uuidProvider = UuidProvider._();

final class UuidProvider extends $FunctionalProvider<Uuid, Uuid, Uuid>
    with $Provider<Uuid> {
  const UuidProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uuidProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uuidHash();

  @$internal
  @override
  $ProviderElement<Uuid> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Uuid create(Ref ref) {
    return uuid(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Uuid value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Uuid>(value),
    );
  }
}

String _$uuidHash() => r'fa05dee780df9697096792b096e8113e5f8cee36';

@ProviderFor(taskLocalDatasource)
const taskLocalDatasourceProvider = TaskLocalDatasourceProvider._();

final class TaskLocalDatasourceProvider
    extends
        $FunctionalProvider<
          TaskLocalDatasource,
          TaskLocalDatasource,
          TaskLocalDatasource
        >
    with $Provider<TaskLocalDatasource> {
  const TaskLocalDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskLocalDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskLocalDatasourceHash();

  @$internal
  @override
  $ProviderElement<TaskLocalDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TaskLocalDatasource create(Ref ref) {
    return taskLocalDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskLocalDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskLocalDatasource>(value),
    );
  }
}

String _$taskLocalDatasourceHash() =>
    r'dfe0233c9988581d0396931bb973a478365890b9';

@ProviderFor(taskRemoteDatasource)
const taskRemoteDatasourceProvider = TaskRemoteDatasourceProvider._();

final class TaskRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          TaskRemoteDatasource,
          TaskRemoteDatasource,
          TaskRemoteDatasource
        >
    with $Provider<TaskRemoteDatasource> {
  const TaskRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskRemoteDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<TaskRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TaskRemoteDatasource create(Ref ref) {
    return taskRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskRemoteDatasource>(value),
    );
  }
}

String _$taskRemoteDatasourceHash() =>
    r'8c619431a80f8d6c8725ddae0e690d0de4d72b96';

@ProviderFor(taskRepository)
const taskRepositoryProvider = TaskRepositoryProvider._();

final class TaskRepositoryProvider
    extends $FunctionalProvider<TaskRepository, TaskRepository, TaskRepository>
    with $Provider<TaskRepository> {
  const TaskRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskRepositoryHash();

  @$internal
  @override
  $ProviderElement<TaskRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskRepository create(Ref ref) {
    return taskRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskRepository>(value),
    );
  }
}

String _$taskRepositoryHash() => r'b4dbbe6facc1523a305f125e707b115068780ac6';
