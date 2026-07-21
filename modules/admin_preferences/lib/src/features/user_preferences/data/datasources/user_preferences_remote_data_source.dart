import 'package:admin_preferences/src/common/config/admin_preferences_api_endpoints.dart';
import 'package:admin_preferences/src/features/user_preferences/data/models/user_preferences_model/user_preferences_model.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

abstract class UserPreferencesRemoteDataSource {
  Future<UserPreferencesModel> getPreferences();

  Future<UserPreferencesModel> createPreferences({
    required UserLanguage language,
    required UserTheme theme,
    required bool pushNotificationsEnabled,
    required bool emailNotificationsEnabled,
    required bool marketingNotificationsEnabled,
  });

  Future<UserPreferencesModel> updatePreferences({
    UserLanguage? language,
    UserTheme? theme,
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? marketingNotificationsEnabled,
  });
}

@Singleton(as: UserPreferencesRemoteDataSource)
class UserPreferencesRemoteDataSourceImpl
    implements UserPreferencesRemoteDataSource {
  UserPreferencesRemoteDataSourceImpl(
    @Named('protectedApiClient') this._apiClient,
  );
  final ApiClient _apiClient;

  @override
  Future<UserPreferencesModel> getPreferences() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      AdminPreferencesApiEndpoints.myPreferences,
    );
    return UserPreferencesModel.fromJson(response.data!);
  }

  @override
  Future<UserPreferencesModel> createPreferences({
    required UserLanguage language,
    required UserTheme theme,
    required bool pushNotificationsEnabled,
    required bool emailNotificationsEnabled,
    required bool marketingNotificationsEnabled,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      AdminPreferencesApiEndpoints.myPreferences,
      data: {
        'language': const UserLanguageJsonConverter().toJson(language),
        'theme': const UserThemeJsonConverter().toJson(theme),
        'push_notifications_enabled': pushNotificationsEnabled,
        'email_notifications_enabled': emailNotificationsEnabled,
        'marketing_notifications_enabled': marketingNotificationsEnabled,
      },
    );
    return UserPreferencesModel.fromJson(response.data!);
  }

  @override
  Future<UserPreferencesModel> updatePreferences({
    UserLanguage? language,
    UserTheme? theme,
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? marketingNotificationsEnabled,
  }) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      AdminPreferencesApiEndpoints.myPreferences,
      data: {
        if (language != null)
          'language': const UserLanguageJsonConverter().toJson(language),
        if (theme != null)
          'theme': const UserThemeJsonConverter().toJson(theme),
        'push_notifications_enabled': ?pushNotificationsEnabled,
        'email_notifications_enabled': ?emailNotificationsEnabled,
        'marketing_notifications_enabled': ?marketingNotificationsEnabled,
      },
    );
    return UserPreferencesModel.fromJson(response.data!);
  }
}
