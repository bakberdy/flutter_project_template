// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserModel _$AdminUserModelFromJson(Map<String, dynamic> json) =>
    AdminUserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      role: const AdminUserRoleJsonConverter().fromJson(json['role'] as String),
      status: const AdminUserStatusJsonConverter().fromJson(
        json['status'] as String,
      ),
      isVerified: json['is_verified'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      isUserDataUploaded: json['is_user_data_uploaded'] as bool,
    );
