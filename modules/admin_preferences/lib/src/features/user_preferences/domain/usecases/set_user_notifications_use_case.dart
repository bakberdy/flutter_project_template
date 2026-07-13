import 'package:core/core.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:injectable/injectable.dart';

class SetUserNotificationsUseCaseParams {
  final bool? pushNotificationsEnabled;
  final bool? emailNotificationsEnabled;
  final bool? marketingNotificationsEnabled;

  const SetUserNotificationsUseCaseParams({
    this.pushNotificationsEnabled,
    this.emailNotificationsEnabled,
    this.marketingNotificationsEnabled,
  });
}

@LazySingleton()
class SetUserNotificationsUseCase
    extends UseCase<UserPreferences, SetUserNotificationsUseCaseParams> {
  final UserPreferencesRepository _repo;

  SetUserNotificationsUseCase(this._repo);

  @override
  FutureEither<UserPreferences> call(SetUserNotificationsUseCaseParams params) {
    return _repo.setNotifications(
      pushNotificationsEnabled: params.pushNotificationsEnabled,
      emailNotificationsEnabled: params.emailNotificationsEnabled,
      marketingNotificationsEnabled: params.marketingNotificationsEnabled,
    );
  }
}
