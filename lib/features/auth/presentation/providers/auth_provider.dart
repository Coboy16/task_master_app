import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/domain/domain.dart';
import 'auth_state.dart';
import 'auth_usecases_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
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

}
