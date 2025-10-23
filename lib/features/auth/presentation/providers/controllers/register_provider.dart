import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '../auth_provider.dart';
import '../auth_usecases_provider.dart';

part 'register_provider.g.dart';

@riverpod
class Register extends _$Register {
  @override
  Future<void> build() async {}

  Future<void> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      final usecase = ref.read(registerWithEmailUsecaseProvider);
      final result = await usecase(
        name: name,
        email: email,
        password: password,
      );

      result.fold(
        (failure) {
          if (kDebugMode) print('Error en registro: ${failure.message}');
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (user) {
          if (kDebugMode) print('Registro exitoso: ${user.email}');
          // Notificar al authProvider global que refresque
          ref.read(authProvider.notifier).checkAuthStatus();
          state = const AsyncValue.data(null);
        },
      );
    } catch (e, s) {
      if (kDebugMode) print('Error inesperado en registro: $e');
      state = AsyncValue.error('Error inesperado. Intenta nuevamente.', s);
    }
  }
}
