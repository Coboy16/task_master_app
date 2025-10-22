import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  // Errores de servidor
  const factory Failure.server({
    @Default('Error del servidor') String message,
  }) = ServerFailure;

  // Errores de caché/local
  const factory Failure.cache({
    @Default('Error de almacenamiento local') String message,
  }) = CacheFailure;

  // Errores de red/conectividad
  const factory Failure.network({
    @Default('Sin conexión a internet') String message,
  }) = NetworkFailure;

  // Errores de autenticación
  const factory Failure.auth({
    @Default('Error de autenticación') String message,
  }) = AuthFailure;

  // Errores de validación
  const factory Failure.validation({
    @Default('Error de validación') String message,
  }) = ValidationFailure;

  // Errores desconocidos
  const factory Failure.unexpected({
    @Default('Error inesperado') String message,
  }) = UnexpectedFailure;
}
