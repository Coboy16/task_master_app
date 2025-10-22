// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String?,
  name: json['name'] as String,
  isGuest: json['isGuest'] as bool,
  guestToken: json['guestToken'] as String?,
  firebaseUid: json['firebaseUid'] as String?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  synced: json['synced'] as bool? ?? false,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'isGuest': instance.isGuest,
      'guestToken': instance.guestToken,
      'firebaseUid': instance.firebaseUid,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'synced': instance.synced,
    };
