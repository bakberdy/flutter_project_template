// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  status: $enumDecode(_$UserStatusEnumMap, json['status']),
  isVerified: json['is_verified'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  isUserDataUploaded: json['is_user_data_uploaded'] as bool,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'role': _$UserRoleEnumMap[instance.role]!,
  'status': _$UserStatusEnumMap[instance.status]!,
  'is_verified': instance.isVerified,
  'created_at': instance.createdAt.toIso8601String(),
  'is_user_data_uploaded': instance.isUserDataUploaded,
};

const _$UserRoleEnumMap = {
  UserRole.superAdmin: 'super_admin',
  UserRole.admin: 'admin',
  UserRole.user: 'user',
};

const _$UserStatusEnumMap = {
  UserStatus.active: 'active',
  UserStatus.blocked: 'blocked',
  UserStatus.deletionRequested: 'deletion_requested',
  UserStatus.deleted: 'deleted',
};
