// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  refreshTokenHash: json['refresh_token_hash'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  expiresAt: DateTime.parse(json['expires_at'] as String),
  lastActive: DateTime.parse(json['last_active'] as String),
  revokedAt: json['revoked_at'] == null
      ? null
      : DateTime.parse(json['revoked_at'] as String),
  isRevoked: json['is_revoked'] as bool,
  device: DeviceModel.fromJson(json['device'] as Map<String, dynamic>),
);
