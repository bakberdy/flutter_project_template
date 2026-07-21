import 'dart:async';

import 'package:client_profile/src/features/sessions/domain/analytics/sessions_events.dart';
import 'package:client_profile/src/features/sessions/domain/repositories/sessions_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RevokeSessionUseCase extends UseCase<void, String> {
  RevokeSessionUseCase(this._repository);
  final SessionsRepository _repository;

  @override
  FutureEither<void> call(String params) async {
    final result = await _repository.revokeSession(params);
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            RevokeSessionUseCaseEvent.failure(
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
      (_) {
        unawaited(Analytics.track(RevokeSessionUseCaseEvent.success()));
        return result;
      },
    );
  }
}
