import 'dart:async';

import 'package:client_preferences/src/features/user_preferences/domain/analytics/user_preferences_events.dart';
import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetUserPreferencesUseCase extends UseCase<UserPreferences?, NoParams> {
  GetUserPreferencesUseCase(this._repo);
  final UserPreferencesRepository _repo;

  @override
  FutureEither<UserPreferences?> call(NoParams params) async {
    final result = await _repo.getPreferences();
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            GetUserPreferencesUseCaseEvent.failure(
              properties: {
                if (failure case BackendFailure(:final message))
                  AnalyticsPropertyKeys.failureMessage: message,
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
