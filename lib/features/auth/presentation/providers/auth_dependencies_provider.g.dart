// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dependencies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  const AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'c9b315997d4620b75f971a029620ab310c5b3296';

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'7ae556467bda8294e1a6a6d76bdcf0e13d148b50';

@ProviderFor(firebaseAuth)
const firebaseAuthProvider = FirebaseAuthProvider._();

final class FirebaseAuthProvider
    extends
        $FunctionalProvider<
          firebase_auth.FirebaseAuth,
          firebase_auth.FirebaseAuth,
          firebase_auth.FirebaseAuth
        >
    with $Provider<firebase_auth.FirebaseAuth> {
  const FirebaseAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAuthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthHash();

  @$internal
  @override
  $ProviderElement<firebase_auth.FirebaseAuth> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  firebase_auth.FirebaseAuth create(Ref ref) {
    return firebaseAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(firebase_auth.FirebaseAuth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<firebase_auth.FirebaseAuth>(value),
    );
  }
}

String _$firebaseAuthHash() => r'dffd78b4e77d56a1066f36e3d8d40a004d636084';

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

@ProviderFor(authLocalDatasource)
const authLocalDatasourceProvider = AuthLocalDatasourceProvider._();

final class AuthLocalDatasourceProvider
    extends
        $FunctionalProvider<
          AuthLocalDatasource,
          AuthLocalDatasource,
          AuthLocalDatasource
        >
    with $Provider<AuthLocalDatasource> {
  const AuthLocalDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLocalDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLocalDatasourceHash();

  @$internal
  @override
  $ProviderElement<AuthLocalDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthLocalDatasource create(Ref ref) {
    return authLocalDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthLocalDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthLocalDatasource>(value),
    );
  }
}

String _$authLocalDatasourceHash() =>
    r'0076345c8c4a4a4da2ff7708ad3344ddad3fa413';

@ProviderFor(authRemoteDatasource)
const authRemoteDatasourceProvider = AuthRemoteDatasourceProvider._();

final class AuthRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDatasource,
          AuthRemoteDatasource,
          AuthRemoteDatasource
        >
    with $Provider<AuthRemoteDatasource> {
  const AuthRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDatasource create(Ref ref) {
    return authRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDatasource>(value),
    );
  }
}

String _$authRemoteDatasourceHash() =>
    r'641d38b693d33c7df5b67be650448321fcccdde9';

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  const AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'a4ac9d7126b1a2cb7672fa0e39431b3f89145c1c';
