import 'dart:async';

import 'package:client_preferences/src/features/user_preferences/domain/analytics/user_preferences_events.dart';
import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:core/core.dart';
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
  FutureEither<UserPreferences> call(
    SetUserNotificationsUseCaseParams params,
  ) => _repo
      .setNotifications(
        pushNotificationsEnabled: params.pushNotificationsEnabled,
        emailNotificationsEnabled: params.emailNotificationsEnabled,
        marketingNotificationsEnabled: params.marketingNotificationsEnabled,
      )
      .then(
        (result) => result.fold(
          (failure) {
            unawaited(
              Analytics.track(
                SetUserNotificationsUseCaseEvent.failure(
                  properties: {
                    ..._analyticsProperties(params),
                    AnalyticsPropertyKeys.failureMessage: failure.message,
                    AnalyticsPropertyKeys.failureType:
                        failure.details?.type.name,
                    AnalyticsPropertyKeys.failureSource: failure.source,
                  },
                ),
              ),
            );
            return result;
          },
          (_) {
            unawaited(
              Analytics.track(
                SetUserNotificationsUseCaseEvent.success(
                  properties: _analyticsProperties(params),
                ),
              ),
            );
            return result;
          },
        ),
      );
}

Map<String, dynamic> _analyticsProperties(
  SetUserNotificationsUseCaseParams params,
) => {
  AnalyticsPropertyKeys.preferenceName: 'notifications',
  'push_notifications_enabled': ?params.pushNotificationsEnabled,
  'email_notifications_enabled': ?params.emailNotificationsEnabled,
  'marketing_notifications_enabled': ?params.marketingNotificationsEnabled,
};
