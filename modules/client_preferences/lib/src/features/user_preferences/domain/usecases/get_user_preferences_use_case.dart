import 'dart:async';

import 'package:core/core.dart';
import 'package:client_preferences/src/features/user_preferences/domain/analytics/user_preferences_events.dart';
import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetUserPreferencesUseCase extends UseCase<UserPreferences?, NoParams> {
  final UserPreferencesRepository _repo;

  GetUserPreferencesUseCase(this._repo);

  @override
  FutureEither<UserPreferences?> call(NoParams params) async {
    final result = await _repo.getPreferences();
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            GetUserPreferencesUseCaseEvent.failure(
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
      (preferences) {
        unawaited(
          Analytics.track(
            GetUserPreferencesUseCaseEvent.success(
              properties: {'has_preferences': preferences != null},
            ),
          ),
        );
        return result;
      },
    );
  }
}
