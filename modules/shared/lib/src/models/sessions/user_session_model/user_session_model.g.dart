// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'user_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSessionModel _$UserSessionModelFromJson(Map<String, dynamic> json) =>
    UserSessionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      refreshTokenHash: json['refresh_token_hash'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
      lastActive: DateTime.parse(json['last_active'] as String),
      isRevoked: json['is_revoked'] as bool,
      device: UserDeviceModel.fromJson(json['device'] as Map<String, dynamic>),
      revokedAt: json['revoked_at'] == null
          ? null
          : DateTime.parse(json['revoked_at'] as String),
    );

Map<String, dynamic> _$UserSessionModelToJson(UserSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'refresh_token_hash': instance.refreshTokenHash,
      'created_at': instance.createdAt.toIso8601String(),
      'expires_at': instance.expiresAt.toIso8601String(),
      'last_active': instance.lastActive.toIso8601String(),
      'revoked_at': instance.revokedAt?.toIso8601String(),
      'is_revoked': instance.isRevoked,
      'device': instance.device.toJson(),
    };
