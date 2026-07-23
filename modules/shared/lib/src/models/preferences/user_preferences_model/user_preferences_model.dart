import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/preferences/user_preferences.dart';

part 'user_preferences_model.g.dart';

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
