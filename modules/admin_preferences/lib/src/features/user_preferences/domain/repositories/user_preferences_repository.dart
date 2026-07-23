import 'package:core/core.dart';
import 'package:shared/shared.dart';

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
