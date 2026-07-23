// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'admin_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserModel _$AdminUserModelFromJson(Map<String, dynamic> json) =>
    AdminUserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$AdminUserRoleEnumMap, json['role']),
      status: $enumDecode(_$AdminUserStatusEnumMap, json['status']),
      isVerified: json['is_verified'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      isUserDataUploaded: json['is_user_data_uploaded'] as bool,
    );

Map<String, dynamic> _$AdminUserModelToJson(AdminUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': _$AdminUserRoleEnumMap[instance.role]!,
      'status': _$AdminUserStatusEnumMap[instance.status]!,
      'is_verified': instance.isVerified,
      'created_at': instance.createdAt.toIso8601String(),
      'is_user_data_uploaded': instance.isUserDataUploaded,
    };

const _$AdminUserRoleEnumMap = {
  AdminUserRole.superAdmin: 'super_admin',
  AdminUserRole.admin: 'admin',
  AdminUserRole.user: 'user',
};

const _$AdminUserStatusEnumMap = {
  AdminUserStatus.active: 'active',
  AdminUserStatus.blocked: 'blocked',
  AdminUserStatus.deletionRequested: 'deletion_requested',
  AdminUserStatus.deleted: 'deleted',
};
