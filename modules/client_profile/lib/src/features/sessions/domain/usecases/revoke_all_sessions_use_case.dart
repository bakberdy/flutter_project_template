import 'dart:async';

import 'package:client_profile/src/features/sessions/domain/analytics/sessions_events.dart';
import 'package:client_profile/src/features/sessions/domain/repositories/sessions_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RevokeAllSessionsUseCase extends UseCase<void, NoParams> {
  final SessionsRepository _repository;
  RevokeAllSessionsUseCase(this._repository);

  @override
  FutureEither<void> call(NoParams params) async {
    final result = await _repository.revokeAllSessions();
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            RevokeAllSessionsUseCaseEvent.failure(
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
        unawaited(Analytics.track(RevokeAllSessionsUseCaseEvent.success()));
        return result;
      },
    );
  }
}
