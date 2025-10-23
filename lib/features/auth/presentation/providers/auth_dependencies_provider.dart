import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '/core/core.dart';
import '/features/auth/data/data.dart';
import '/features/auth/domain/domain.dart';

part 'auth_dependencies_provider.g.dart';

// (BD, Firebase, SharedPreferences)

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase.instance;
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider debe ser overrideado en main.dart',
  );
}

@Riverpod(keepAlive: true)
firebase_auth.FirebaseAuth firebaseAuth(Ref ref) {
  return firebase_auth.FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
FirebaseFirestore firestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@Riverpod(keepAlive: true)
Uuid uuid(Ref ref) {
  return const Uuid();
}

// ==================== DATASOURCES PROVIDERS ====================

@Riverpod(keepAlive: true)
AuthLocalDatasource authLocalDatasource(Ref ref) {
  return AuthLocalDatasourceImpl(
    database: ref.watch(appDatabaseProvider),
    prefs: ref.watch(sharedPreferencesProvider),
    uuid: ref.watch(uuidProvider),
  );
}

@Riverpod(keepAlive: true)
AuthRemoteDatasource authRemoteDatasource(Ref ref) {
  return AuthRemoteDatasourceImpl(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
    uuid: ref.watch(uuidProvider),
  );
}

// ==================== REPOSITORY PROVIDER ====================

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    localDatasource: ref.watch(authLocalDatasourceProvider),
    remoteDatasource: ref.watch(authRemoteDatasourceProvider),
  );
}
