// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para la instancia de AppDatabase

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

/// Provider para la instancia de AppDatabase

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Provider para la instancia de AppDatabase
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

/// Provider para SharedPreferences (debe ser overrideado en main.dart)

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

/// Provider para SharedPreferences (debe ser overrideado en main.dart)

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// Provider para SharedPreferences (debe ser overrideado en main.dart)
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

/// Provider para Firebase Auth

@ProviderFor(firebaseAuth)
const firebaseAuthProvider = FirebaseAuthProvider._();

/// Provider para Firebase Auth

final class FirebaseAuthProvider
    extends
        $FunctionalProvider<
          firebase_auth.FirebaseAuth,
          firebase_auth.FirebaseAuth,
          firebase_auth.FirebaseAuth
        >
    with $Provider<firebase_auth.FirebaseAuth> {
  /// Provider para Firebase Auth
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

/// Provider para Firestore

@ProviderFor(firestore)
const firestoreProvider = FirestoreProvider._();

/// Provider para Firestore

final class FirestoreProvider
    extends
        $FunctionalProvider<
          FirebaseFirestore,
          FirebaseFirestore,
          FirebaseFirestore
        >
    with $Provider<FirebaseFirestore> {
  /// Provider para Firestore
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

/// Provider para UUID generator

@ProviderFor(uuid)
const uuidProvider = UuidProvider._();

/// Provider para UUID generator

final class UuidProvider extends $FunctionalProvider<Uuid, Uuid, Uuid>
    with $Provider<Uuid> {
  /// Provider para UUID generator
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

/// Provider para AuthLocalDatasource

@ProviderFor(authLocalDatasource)
const authLocalDatasourceProvider = AuthLocalDatasourceProvider._();

/// Provider para AuthLocalDatasource

final class AuthLocalDatasourceProvider
    extends
        $FunctionalProvider<
          AuthLocalDatasource,
          AuthLocalDatasource,
          AuthLocalDatasource
        >
    with $Provider<AuthLocalDatasource> {
  /// Provider para AuthLocalDatasource
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

/// Provider para AuthRemoteDatasource

@ProviderFor(authRemoteDatasource)
const authRemoteDatasourceProvider = AuthRemoteDatasourceProvider._();

/// Provider para AuthRemoteDatasource

final class AuthRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDatasource,
          AuthRemoteDatasource,
          AuthRemoteDatasource
        >
    with $Provider<AuthRemoteDatasource> {
  /// Provider para AuthRemoteDatasource
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

/// Provider para AuthRepository

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

/// Provider para AuthRepository

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Provider para AuthRepository
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

/// Provider para CheckAuthStatusUsecase

@ProviderFor(checkAuthStatusUsecase)
const checkAuthStatusUsecaseProvider = CheckAuthStatusUsecaseProvider._();

/// Provider para CheckAuthStatusUsecase

final class CheckAuthStatusUsecaseProvider
    extends
        $FunctionalProvider<
          CheckAuthStatusUsecase,
          CheckAuthStatusUsecase,
          CheckAuthStatusUsecase
        >
    with $Provider<CheckAuthStatusUsecase> {
  /// Provider para CheckAuthStatusUsecase
  const CheckAuthStatusUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkAuthStatusUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkAuthStatusUsecaseHash();

  @$internal
  @override
  $ProviderElement<CheckAuthStatusUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckAuthStatusUsecase create(Ref ref) {
    return checkAuthStatusUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckAuthStatusUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckAuthStatusUsecase>(value),
    );
  }
}

String _$checkAuthStatusUsecaseHash() =>
    r'b7b10905d0a4630f5881ea6c1abda1ca6cbfcf50';

/// Provider para LoginWithEmailUsecase

@ProviderFor(loginWithEmailUsecase)
const loginWithEmailUsecaseProvider = LoginWithEmailUsecaseProvider._();

/// Provider para LoginWithEmailUsecase

final class LoginWithEmailUsecaseProvider
    extends
        $FunctionalProvider<
          LoginWithEmailUsecase,
          LoginWithEmailUsecase,
          LoginWithEmailUsecase
        >
    with $Provider<LoginWithEmailUsecase> {
  /// Provider para LoginWithEmailUsecase
  const LoginWithEmailUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginWithEmailUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginWithEmailUsecaseHash();

  @$internal
  @override
  $ProviderElement<LoginWithEmailUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LoginWithEmailUsecase create(Ref ref) {
    return loginWithEmailUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginWithEmailUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginWithEmailUsecase>(value),
    );
  }
}

String _$loginWithEmailUsecaseHash() =>
    r'934a22dd08592e37adef4ee6c3be36c74b351acf';

/// Provider para RegisterWithEmailUsecase

@ProviderFor(registerWithEmailUsecase)
const registerWithEmailUsecaseProvider = RegisterWithEmailUsecaseProvider._();

/// Provider para RegisterWithEmailUsecase

final class RegisterWithEmailUsecaseProvider
    extends
        $FunctionalProvider<
          RegisterWithEmailUsecase,
          RegisterWithEmailUsecase,
          RegisterWithEmailUsecase
        >
    with $Provider<RegisterWithEmailUsecase> {
  /// Provider para RegisterWithEmailUsecase
  const RegisterWithEmailUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerWithEmailUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerWithEmailUsecaseHash();

  @$internal
  @override
  $ProviderElement<RegisterWithEmailUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegisterWithEmailUsecase create(Ref ref) {
    return registerWithEmailUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterWithEmailUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterWithEmailUsecase>(value),
    );
  }
}

String _$registerWithEmailUsecaseHash() =>
    r'df61e4d682921fb36acba8ef6f7d5172ba78ba42';

/// Provider para CreateGuestUserUsecase

@ProviderFor(createGuestUserUsecase)
const createGuestUserUsecaseProvider = CreateGuestUserUsecaseProvider._();

/// Provider para CreateGuestUserUsecase

final class CreateGuestUserUsecaseProvider
    extends
        $FunctionalProvider<
          CreateGuestUserUsecase,
          CreateGuestUserUsecase,
          CreateGuestUserUsecase
        >
    with $Provider<CreateGuestUserUsecase> {
  /// Provider para CreateGuestUserUsecase
  const CreateGuestUserUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createGuestUserUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createGuestUserUsecaseHash();

  @$internal
  @override
  $ProviderElement<CreateGuestUserUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateGuestUserUsecase create(Ref ref) {
    return createGuestUserUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateGuestUserUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateGuestUserUsecase>(value),
    );
  }
}

String _$createGuestUserUsecaseHash() =>
    r'9b9e8437caa1692684f2159ac070a303f55fe950';

/// Provider para LogoutUsecase

@ProviderFor(logoutUsecase)
const logoutUsecaseProvider = LogoutUsecaseProvider._();

/// Provider para LogoutUsecase

final class LogoutUsecaseProvider
    extends $FunctionalProvider<LogoutUsecase, LogoutUsecase, LogoutUsecase>
    with $Provider<LogoutUsecase> {
  /// Provider para LogoutUsecase
  const LogoutUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoutUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoutUsecaseHash();

  @$internal
  @override
  $ProviderElement<LogoutUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LogoutUsecase create(Ref ref) {
    return logoutUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogoutUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogoutUsecase>(value),
    );
  }
}

String _$logoutUsecaseHash() => r'dbd1b119ee9d6d4d27284edde8b59e07c3382e8f';

/// Provider para GetCurrentUserUsecase

@ProviderFor(getCurrentUserUsecase)
const getCurrentUserUsecaseProvider = GetCurrentUserUsecaseProvider._();

/// Provider para GetCurrentUserUsecase

final class GetCurrentUserUsecaseProvider
    extends
        $FunctionalProvider<
          GetCurrentUserUsecase,
          GetCurrentUserUsecase,
          GetCurrentUserUsecase
        >
    with $Provider<GetCurrentUserUsecase> {
  /// Provider para GetCurrentUserUsecase
  const GetCurrentUserUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCurrentUserUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCurrentUserUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetCurrentUserUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCurrentUserUsecase create(Ref ref) {
    return getCurrentUserUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCurrentUserUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCurrentUserUsecase>(value),
    );
  }
}

String _$getCurrentUserUsecaseHash() =>
    r'4d13aa920eae8a48a4e3e70cff35bf1753d3a63b';

/// Provider para MigrateGuestToAuthUsecase

@ProviderFor(migrateGuestToAuthUsecase)
const migrateGuestToAuthUsecaseProvider = MigrateGuestToAuthUsecaseProvider._();

/// Provider para MigrateGuestToAuthUsecase

final class MigrateGuestToAuthUsecaseProvider
    extends
        $FunctionalProvider<
          MigrateGuestToAuthUsecase,
          MigrateGuestToAuthUsecase,
          MigrateGuestToAuthUsecase
        >
    with $Provider<MigrateGuestToAuthUsecase> {
  /// Provider para MigrateGuestToAuthUsecase
  const MigrateGuestToAuthUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'migrateGuestToAuthUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$migrateGuestToAuthUsecaseHash();

  @$internal
  @override
  $ProviderElement<MigrateGuestToAuthUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MigrateGuestToAuthUsecase create(Ref ref) {
    return migrateGuestToAuthUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MigrateGuestToAuthUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MigrateGuestToAuthUsecase>(value),
    );
  }
}

String _$migrateGuestToAuthUsecaseHash() =>
    r'ebad8a5e0ba0cca4c22adae343e6316563a0d15f';

/// Provider principal de autenticación usando AsyncNotifier con generación de código

@ProviderFor(Auth)
const authProvider = AuthProvider._();

/// Provider principal de autenticación usando AsyncNotifier con generación de código
final class AuthProvider extends $AsyncNotifierProvider<Auth, AuthState> {
  /// Provider principal de autenticación usando AsyncNotifier con generación de código
  const AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();
}

String _$authHash() => r'eca8e73a1f7e8a35355bbcf6ae2d3c76574bb66a';

/// Provider principal de autenticación usando AsyncNotifier con generación de código

abstract class _$Auth extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthState>, AuthState>,
              AsyncValue<AuthState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
