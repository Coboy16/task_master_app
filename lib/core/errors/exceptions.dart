abstract class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, [this.code]);

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Excepción de servidor
class ServerException extends AppException {
  ServerException([super.message = 'Error del servidor', super.code]);
}

/// Excepción de caché/almacenamiento local
class CacheException extends AppException {
  CacheException([super.message = 'Error de almacenamiento local', super.code]);
}

/// Excepción de red
class NetworkException extends AppException {
  NetworkException([super.message = 'Sin conexión a internet', super.code]);
}

/// Excepción de autenticación
class AuthException extends AppException {
  AuthException([super.message = 'Error de autenticación', super.code]);
}

/// Excepción de validación
class ValidationException extends AppException {
  ValidationException([super.message = 'Error de validación', super.code]);
}
