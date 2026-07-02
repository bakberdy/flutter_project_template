// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserProfileModel _$AdminUserProfileModelFromJson(
  Map<String, dynamic> json,
) => AdminUserProfileModel(
  userId: json['user_id'] as String,
  fullName: json['full_name'] as String,
  phoneNumber: const AdminUserPhoneNumberModelConverter().fromJson(
    json['phone_number'] as Map<String, dynamic>?,
  ),
  avatarUrl: json['avatar_url'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
);
