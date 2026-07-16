import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:core/core.dart';

abstract class UserPreferencesRepository {
  FutureEither<UserPreferences?> getPreferences();
  FutureEither<void> setTheme(UserTheme theme);
  FutureEither<UserTheme?> getTheme();
  FutureEither<void> setLanguage(UserLanguage language);
  FutureEither<UserLanguage?> getLanguage();
  FutureEither<UserPreferences> setNotifications({
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? marketingNotificationsEnabled,
  });
}
