import 'package:freezed_annotation/freezed_annotation.dart';
import '/features/auth/domain/domain.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  /// Estado inicial antes de verificar la sesión
  const factory AuthState.initial() = _Initial;

  /// Verificando sesión o procesando auth (login/register)
  const factory AuthState.loading() = _Loading;

  /// Usuario autenticado (Firebase Auth o Guest local)
  const factory AuthState.authenticated(User user) = _Authenticated;

  /// Sin sesión activa
  const factory AuthState.unauthenticated() = _Unauthenticated;

  /// Error en proceso de autenticación
  const factory AuthState.error(String message) = _Error;
}
