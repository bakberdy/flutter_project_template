import 'dart:async';

import 'package:client_preferences/src/features/user_preferences/domain/analytics/user_preferences_events.dart';
import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

class SetUserLanguageUseCaseParams {
  final UserLanguage language;

  const SetUserLanguageUseCaseParams({required this.language});
}

@LazySingleton()
class SetUserLanguageUseCase
    extends UseCase<void, SetUserLanguageUseCaseParams> {
  final UserPreferencesRepository _repo;

  SetUserLanguageUseCase(this._repo);

  @override
  FutureEither<void> call(SetUserLanguageUseCaseParams params) => _repo
      .setLanguage(params.language)
      .then(
        (result) => result.fold(
          (failure) {
            unawaited(
              Analytics.track(
                SetAppLocaleUseCaseEvent.failure(
                  properties: {
                    AnalyticsPropertyKeys.preferenceName: 'language',
                    AnalyticsPropertyKeys.preferenceValue:
                        params.language.languageCode,
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
                SetAppLocaleUseCaseEvent.success(
                  properties: {
                    AnalyticsPropertyKeys.preferenceName: 'language',
                    AnalyticsPropertyKeys.preferenceValue:
                        params.language.languageCode,
                  },
                ),
              ),
            );
            return result;
          },
        ),
      );
}
