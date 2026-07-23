// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'user_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferencesModel _$UserPreferencesModelFromJson(
  Map<String, dynamic> json,
) => UserPreferencesModel(
  userId: json['user_id'] as String,
  language: $enumDecode(_$UserLanguageEnumMap, json['language']),
  theme: $enumDecode(_$UserThemeEnumMap, json['theme']),
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
  'language': _$UserLanguageEnumMap[instance.language]!,
  'theme': _$UserThemeEnumMap[instance.theme]!,
  'push_notifications_enabled': instance.pushNotificationsEnabled,
  'email_notifications_enabled': instance.emailNotificationsEnabled,
  'marketing_notifications_enabled': instance.marketingNotificationsEnabled,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$UserLanguageEnumMap = {
  UserLanguage.en: 'en',
  UserLanguage.ru: 'ru',
  UserLanguage.kk: 'kk',
};

const _$UserThemeEnumMap = {
  UserTheme.system: 'system',
  UserTheme.light: 'light',
  UserTheme.dark: 'dark',
};
