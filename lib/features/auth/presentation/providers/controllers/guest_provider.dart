import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '../auth_provider.dart';
import '../auth_usecases_provider.dart';

part 'guest_provider.g.dart';

/// Controlador para la pantalla de "Continuar sin cuenta"
@riverpod
class Guest extends _$Guest {
  @override
  Future<void> build() async {
    // No hace nada al construir
  }

  Future<void> createGuestUser(String name) async {
    state = const AsyncValue.loading();

    try {
      final usecase = ref.read(createGuestUserUsecaseProvider);
      final result = await usecase(name: name);

      result.fold(
        (failure) {
          if (kDebugMode) print('Error al crear invitado: ${failure.message}');
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (user) {
          if (kDebugMode) print('Usuario invitado creado: ${user.name}');
          // Notificar al authProvider global que refresque
          ref.read(authProvider.notifier).checkAuthStatus();
          state = const AsyncValue.data(null);
        },
      );
    } catch (e, s) {
      if (kDebugMode) print('Error inesperado al crear invitado: $e');
      state = AsyncValue.error('Error inesperado. Intenta nuevamente.', s);
    }
  }
}
