import 'dart:async';

import 'package:admin_preferences/src/features/user_preferences/domain/analytics/user_preferences_events.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetUserLanguageUseCase extends UseCase<UserLanguage?, NoParams> {
  final UserPreferencesRepository _repo;

  GetUserLanguageUseCase(this._repo);

  @override
  FutureEither<UserLanguage?> call(NoParams params) async {
    final result = await _repo.getLanguage();
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            GetAppLocaleUseCaseEvent.failure(
              properties: {
                AnalyticsPropertyKeys.failureMessage: failure.message,
                AnalyticsPropertyKeys.failureType: failure.details?.type.name,
                AnalyticsPropertyKeys.failureSource: failure.source,
              },
            ),
          ),
        );
        return result;
      },
      (_) {
        unawaited(Analytics.track(GetAppLocaleUseCaseEvent.success()));
        return result;
      },
    );
  }
}
