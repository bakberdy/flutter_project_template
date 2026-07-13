import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_preferences_model.g.dart';

class UserLanguageJsonConverter implements JsonConverter<UserLanguage, String> {
  const UserLanguageJsonConverter();

  @override
  UserLanguage fromJson(String json) => switch (json) {
    'en' => UserLanguage.en,
    'ru' => UserLanguage.ru,
    'kk' => UserLanguage.kk,
    _ => throw ArgumentError.value(json, 'json', 'Unsupported user language'),
  };

  @override
  String toJson(UserLanguage object) => switch (object) {
    UserLanguage.en => 'en',
    UserLanguage.ru => 'ru',
    UserLanguage.kk => 'kk',
  };
}

class UserThemeJsonConverter implements JsonConverter<UserTheme, String> {
  const UserThemeJsonConverter();

  @override
  UserTheme fromJson(String json) => switch (json) {
    'system' => UserTheme.system,
    'light' => UserTheme.light,
    'dark' => UserTheme.dark,
    _ => throw ArgumentError.value(json, 'json', 'Unsupported user theme'),
  };

  @override
  String toJson(UserTheme object) => switch (object) {
    UserTheme.system => 'system',
    UserTheme.light => 'light',
    UserTheme.dark => 'dark',
  };
}

@UserLanguageJsonConverter()
@UserThemeJsonConverter()
@JsonSerializable()
class UserPreferencesModel extends UserPreferences {
  const UserPreferencesModel({
    required super.userId,
    required super.language,
    required super.theme,
    required super.pushNotificationsEnabled,
    required super.emailNotificationsEnabled,
    required super.marketingNotificationsEnabled,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesModelFromJson(json);

  factory UserPreferencesModel.fromEntity(UserPreferences preferences) =>
      UserPreferencesModel(
        userId: preferences.userId,
        language: preferences.language,
        theme: preferences.theme,
        pushNotificationsEnabled: preferences.pushNotificationsEnabled,
        emailNotificationsEnabled: preferences.emailNotificationsEnabled,
        marketingNotificationsEnabled:
            preferences.marketingNotificationsEnabled,
        createdAt: preferences.createdAt,
        updatedAt: preferences.updatedAt,
      );

  Map<String, dynamic> toJson() => _$UserPreferencesModelToJson(this);
}
