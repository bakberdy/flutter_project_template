// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  status: $enumDecode(_$UserStatusEnumMap, json['status']),
  isVerified: json['isVerified'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isUserDataUploaded: json['isUserDataUploaded'] as bool,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'role': _$UserRoleEnumMap[instance.role]!,
  'status': _$UserStatusEnumMap[instance.status]!,
  'isVerified': instance.isVerified,
  'createdAt': instance.createdAt.toIso8601String(),
  'isUserDataUploaded': instance.isUserDataUploaded,
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
