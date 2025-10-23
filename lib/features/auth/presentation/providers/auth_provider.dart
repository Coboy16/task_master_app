import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '/core/core.dart';
import '/features/auth/data/data.dart';
import '/features/auth/domain/domain.dart';
import 'auth_state.dart';

part 'auth_provider.g.dart';

// ==================== DEPENDENCIES PROVIDERS ====================

/// Provider para la instancia de AppDatabase
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase.instance;
}

/// Provider para SharedPreferences (debe ser overrideado en main.dart)
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider debe ser overrideado en main.dart',
  );
}

/// Provider para Firebase Auth
@Riverpod(keepAlive: true)
firebase_auth.FirebaseAuth firebaseAuth(Ref ref) {
  return firebase_auth.FirebaseAuth.instance;
}

/// Provider para Firestore
@Riverpod(keepAlive: true)
FirebaseFirestore firestore(Ref ref) {
  return FirebaseFirestore.instance;
}

/// Provider para UUID generator
@Riverpod(keepAlive: true)
Uuid uuid(Ref ref) {
  return const Uuid();
}

// ==================== DATASOURCES PROVIDERS ====================

/// Provider para AuthLocalDatasource
@Riverpod(keepAlive: true)
AuthLocalDatasource authLocalDatasource(Ref ref) {
  return AuthLocalDatasourceImpl(
    database: ref.watch(appDatabaseProvider),
    prefs: ref.watch(sharedPreferencesProvider),
    uuid: ref.watch(uuidProvider),
  );
}

/// Provider para AuthRemoteDatasource
@Riverpod(keepAlive: true)
AuthRemoteDatasource authRemoteDatasource(Ref ref) {
  return AuthRemoteDatasourceImpl(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
    uuid: ref.watch(uuidProvider),
  );
}

// ==================== REPOSITORY PROVIDER ====================

/// Provider para AuthRepository
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    localDatasource: ref.watch(authLocalDatasourceProvider),
    remoteDatasource: ref.watch(authRemoteDatasourceProvider),
  );
}

// ==================== USECASES PROVIDERS ====================

/// Provider para CheckAuthStatusUsecase
@Riverpod(keepAlive: true)
CheckAuthStatusUsecase checkAuthStatusUsecase(Ref ref) {
  return CheckAuthStatusUsecase(ref.watch(authRepositoryProvider));
}

/// Provider para LoginWithEmailUsecase
@Riverpod(keepAlive: true)
LoginWithEmailUsecase loginWithEmailUsecase(Ref ref) {
  return LoginWithEmailUsecase(ref.watch(authRepositoryProvider));
}

/// Provider para RegisterWithEmailUsecase
@Riverpod(keepAlive: true)
RegisterWithEmailUsecase registerWithEmailUsecase(Ref ref) {
  return RegisterWithEmailUsecase(ref.watch(authRepositoryProvider));
}

/// Provider para CreateGuestUserUsecase
@Riverpod(keepAlive: true)
CreateGuestUserUsecase createGuestUserUsecase(Ref ref) {
  return CreateGuestUserUsecase(ref.watch(authRepositoryProvider));
}

/// Provider para LogoutUsecase
@Riverpod(keepAlive: true)
LogoutUsecase logoutUsecase(Ref ref) {
  return LogoutUsecase(ref.watch(authRepositoryProvider));
}

/// Provider para GetCurrentUserUsecase
@Riverpod(keepAlive: true)
GetCurrentUserUsecase getCurrentUserUsecase(Ref ref) {
  return GetCurrentUserUsecase(ref.watch(authRepositoryProvider));
}

/// Provider para MigrateGuestToAuthUsecase
@Riverpod(keepAlive: true)
MigrateGuestToAuthUsecase migrateGuestToAuthUsecase(Ref ref) {
  return MigrateGuestToAuthUsecase(ref.watch(authRepositoryProvider));
}

// ==================== AUTH NOTIFIER (State Management) ====================

/// Provider principal de autenticación usando AsyncNotifier con generación de código
@riverpod
class Auth extends _$Auth {
  @override
  Future<AuthState> build() async {
    // Estado inicial, después llamamos checkAuthStatus() desde SplashScreen
    return const AuthState.initial();
  }

  /// Verificar estado de autenticación al iniciar la app
  /// Prioridad: Firebase Auth > Usuario local (SQLite)
  Future<void> checkAuthStatus() async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final usecase = ref.read(checkAuthStatusUsecaseProvider);
      final result = await usecase();

      result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error al verificar sesión: ${failure.message}');
          }
          state = const AsyncValue.data(AuthState.unauthenticated());
        },
        (user) {
          if (user != null) {
            if (kDebugMode) {
              print(
                'Sesión restaurada: ${user.name} (${user.isGuest ? "Guest" : "Auth"})',
              );
            }
            state = AsyncValue.data(AuthState.authenticated(user));
          } else {
            if (kDebugMode) {
              print('No hay sesión activa');
            }
            state = const AsyncValue.data(AuthState.unauthenticated());
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en checkAuthStatus: $e');
      }
      state = const AsyncValue.data(AuthState.unauthenticated());
    }
  }

  /// Login con email y password (Firebase Auth)
  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final usecase = ref.read(loginWithEmailUsecaseProvider);
      final result = await usecase(email: email, password: password);

      result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error en login: ${failure.message}');
          }
          state = AsyncValue.data(AuthState.error(failure.message));

          // Volver a unauthenticated después de mostrar error
          Future.delayed(const Duration(seconds: 2), () {
            if (state.value is Error) {
              state = const AsyncValue.data(AuthState.unauthenticated());
            }
          });
        },
        (user) {
          if (kDebugMode) {
            print('Login exitoso: ${user.email}');
          }
          state = AsyncValue.data(AuthState.authenticated(user));
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en login: $e');
      }
      state = const AsyncValue.data(
        AuthState.error('Error inesperado. Intenta nuevamente.'),
      );
    }
  }

  /// Registro con email, password y nombre (Firebase Auth + Firestore)
  Future<void> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final usecase = ref.read(registerWithEmailUsecaseProvider);
      final result = await usecase(
        name: name,
        email: email,
        password: password,
      );

      result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error en registro: ${failure.message}');
          }
          state = AsyncValue.data(AuthState.error(failure.message));

          // Volver a unauthenticated después de mostrar error
          Future.delayed(const Duration(seconds: 2), () {
            if (state.value is Error) {
              state = const AsyncValue.data(AuthState.unauthenticated());
            }
          });
        },
        (user) {
          if (kDebugMode) {
            print('Registro exitoso: ${user.email}');
          }
          state = AsyncValue.data(AuthState.authenticated(user));
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en registro: $e');
      }
      state = const AsyncValue.data(
        AuthState.error('Error inesperado. Intenta nuevamente.'),
      );
    }
  }

  /// Crear usuario invitado (solo nombre, guardado localmente en SQLite)
  Future<void> createGuestUser(String name) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final usecase = ref.read(createGuestUserUsecaseProvider);
      final result = await usecase(name: name);

      result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error al crear usuario invitado: ${failure.message}');
          }
          state = AsyncValue.data(AuthState.error(failure.message));

          // Volver a unauthenticated después de mostrar error
          Future.delayed(const Duration(seconds: 2), () {
            if (state.value is Error) {
              state = const AsyncValue.data(AuthState.unauthenticated());
            }
          });
        },
        (user) {
          if (kDebugMode) {
            print('Usuario invitado creado: ${user.name}');
          }
          state = AsyncValue.data(AuthState.authenticated(user));
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado al crear invitado: $e');
      }
      state = const AsyncValue.data(
        AuthState.error('Error inesperado. Intenta nuevamente.'),
      );
    }
  }

  /// Cerrar sesión (Firebase Auth + limpiar datos locales)
  Future<void> logout() async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final usecase = ref.read(logoutUsecaseProvider);
      final result = await usecase();

      result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error al cerrar sesión: ${failure.message}');
          }
          // Aún así, marcamos como no autenticado
          state = const AsyncValue.data(AuthState.unauthenticated());
        },
        (_) {
          if (kDebugMode) {
            print('Sesión cerrada correctamente');
          }
          state = const AsyncValue.data(AuthState.unauthenticated());
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en logout: $e');
      }
      // Aún así, marcamos como no autenticado
      state = const AsyncValue.data(AuthState.unauthenticated());
    }
  }

  /// Obtener usuario actual (útil para refrescar datos)
  Future<User?> getCurrentUser() async {
    try {
      final usecase = ref.read(getCurrentUserUsecaseProvider);
      final result = await usecase();

      return result.fold((failure) {
        if (kDebugMode) {
          print('Error al obtener usuario actual: ${failure.message}');
        }
        return null;
      }, (user) => user);
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado al obtener usuario: $e');
      }
      return null;
    }
  }

  /// Migrar usuario invitado a cuenta autenticada (Firebase)
  /// TODO: Implementar cuando sea necesario
  Future<void> migrateGuestToAuth({
    required String guestUserId,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final usecase = ref.read(migrateGuestToAuthUsecaseProvider);
      final result = await usecase(
        guestUserId: guestUserId,
        email: email,
        password: password,
      );

      result.fold(
        (failure) {
          if (kDebugMode) {
            print('Error en migración: ${failure.message}');
          }
          state = AsyncValue.data(AuthState.error(failure.message));
        },
        (user) {
          if (kDebugMode) {
            print('Migración exitosa: ${user.email}');
          }
          state = AsyncValue.data(AuthState.authenticated(user));
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error inesperado en migración: $e');
      }
      state = const AsyncValue.data(
        AuthState.error('Error inesperado. Intenta nuevamente.'),
      );
    }
  }
}
