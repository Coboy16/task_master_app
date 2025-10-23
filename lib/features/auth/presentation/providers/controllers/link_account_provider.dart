import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '../auth_provider.dart';
import '../auth_usecases_provider.dart'; // Crearemos este archivo

part 'link_account_provider.g.dart';

/// Controlador para la pantalla de "Vincular Cuenta"
@riverpod
class LinkAccount extends _$LinkAccount {
  @override
  Future<void> build() async {
    // No hace nada al construir
  }

  Future<void> migrateGuestToAuth({
    required String guestUserId,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      final usecase = ref.read(migrateGuestToAuthUsecaseProvider);
      final result = await usecase(
        guestUserId: guestUserId,
        email: email,
        password: password,
      );

      result.fold(
        (failure) {
          if (kDebugMode) print('Error en migración: ${failure.message}');
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (user) {
          if (kDebugMode) print('Migración exitosa: ${user.email}');
          // Notificar al authProvider global que refresque
          ref.read(authProvider.notifier).checkAuthStatus();
          state = const AsyncValue.data(null);
        },
      );
    } catch (e, s) {
      if (kDebugMode) print('Error inesperado en migración: $e');
      state = AsyncValue.error('Error inesperado. Intenta nuevamente.', s);
    }
  }
}
