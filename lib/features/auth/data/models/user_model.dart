import 'package:freezed_annotation/freezed_annotation.dart';

import '/features/auth/domain/domain.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    String? email,
    required String name,
    required bool isGuest,
    String? guestToken,
    String? firebaseUid,
    required String createdAt,
    required String updatedAt,
    @Default(false) bool synced,
  }) = _UserModel;

  const UserModel._();

  /// From Firestore JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// From SQLite Map
  factory UserModel.fromSQLite(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String?,
      name: map['name'] as String,
      isGuest: map['is_guest'] == 1,
      guestToken: map['guest_token'] as String?,
      firebaseUid: map['firebase_uid'] as String?,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      synced: map['synced'] == 1,
    );
  }

  /// To SQLite Map
  Map<String, dynamic> toSQLite() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'is_guest': isGuest ? 1 : 0,
      'guest_token': guestToken,
      'firebase_uid': firebaseUid,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'synced': synced ? 1 : 0,
    };
  }

  /// Convert to Domain Entity
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      isGuest: isGuest,
      guestToken: guestToken,
      firebaseUid: firebaseUid,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      synced: synced,
    );
  }

  /// From Domain Entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      isGuest: user.isGuest,
      guestToken: user.guestToken,
      firebaseUid: user.firebaseUid,
      createdAt: user.createdAt.toIso8601String(),
      updatedAt: user.updatedAt.toIso8601String(),
      synced: user.synced,
    );
  }
}
