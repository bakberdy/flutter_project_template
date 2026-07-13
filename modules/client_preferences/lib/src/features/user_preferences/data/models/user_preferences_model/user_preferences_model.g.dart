// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferencesModel _$UserPreferencesModelFromJson(
  Map<String, dynamic> json,
) => UserPreferencesModel(
  userId: json['user_id'] as String,
  language: const UserLanguageJsonConverter().fromJson(
    json['language'] as String,
  ),
  theme: const UserThemeJsonConverter().fromJson(json['theme'] as String),
  pushNotificationsEnabled: json['push_notifications_enabled'] as bool,
  emailNotificationsEnabled: json['email_notifications_enabled'] as bool,
  marketingNotificationsEnabled:
      json['marketing_notifications_enabled'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$UserPreferencesModelToJson(
  UserPreferencesModel instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'language': const UserLanguageJsonConverter().toJson(instance.language),
  'theme': const UserThemeJsonConverter().toJson(instance.theme),
  'push_notifications_enabled': instance.pushNotificationsEnabled,
  'email_notifications_enabled': instance.emailNotificationsEnabled,
  'marketing_notifications_enabled': instance.marketingNotificationsEnabled,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
