import 'dart:async';

import 'package:client_preferences/src/features/user_preferences/domain/analytics/user_preferences_events.dart';
import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

class SetUserThemeUseCaseParams {
  const SetUserThemeUseCaseParams({required this.theme});
  final UserTheme theme;
}

@LazySingleton()
class SetUserThemeUseCase extends UseCase<void, SetUserThemeUseCaseParams> {
  SetUserThemeUseCase(this._repo);
  final UserPreferencesRepository _repo;

  @override
  FutureEither<void> call(SetUserThemeUseCaseParams params) => _repo
      .setTheme(params.theme)
      .then(
        (result) => result.fold(
          (failure) {
            unawaited(
              Analytics.track(
                SetUserThemeUseCaseEvent.failure(
                  properties: {
                    AnalyticsPropertyKeys.preferenceName: 'theme',
                    AnalyticsPropertyKeys.preferenceValue: params.theme.name,
                    if (failure case BackendFailure(:final message))
                      AnalyticsPropertyKeys.failureMessage: message,
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
                SetUserThemeUseCaseEvent.success(
                  properties: {
                    AnalyticsPropertyKeys.preferenceName: 'theme',
                    AnalyticsPropertyKeys.preferenceValue: params.theme.name,
                  },
                ),
              ),
            );
            return result;
          },
        ),
      );
}
