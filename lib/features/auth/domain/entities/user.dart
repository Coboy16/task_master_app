import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    String? email,
    required String name,
    required bool isGuest,
    String? guestToken,
    String? firebaseUid,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool synced,
  }) = _User;

  const User._();

  /// Usuario está autenticado con Firebase
  bool get isAuthenticated => !isGuest && firebaseUid != null;

  /// Usuario necesita sincronización
  bool get needsSync => isGuest || !synced;

  /// Display name
  String get displayName => name;

  /// Identificador único (firebaseUid si existe, sino id local)
  String get uniqueId => firebaseUid ?? id;
}
