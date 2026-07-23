import 'dart:async';

import 'package:admin_preferences/src/features/user_preferences/domain/analytics/user_preferences_events.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

class SetUserLanguageUseCaseParams {
  const SetUserLanguageUseCaseParams({required this.language});

  final UserLanguage language;
}

@LazySingleton()
class SetUserLanguageUseCase
    extends UseCase<void, SetUserLanguageUseCaseParams> {
  SetUserLanguageUseCase(this._repo);

  final UserPreferencesRepository _repo;

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
