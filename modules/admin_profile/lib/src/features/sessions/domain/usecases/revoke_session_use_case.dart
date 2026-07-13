import 'dart:async';

import 'package:core/core.dart';
import 'package:admin_profile/src/features/sessions/domain/analytics/sessions_events.dart';
import 'package:admin_profile/src/features/sessions/domain/repositories/sessions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RevokeSessionUseCase extends UseCase<void, String> {
  final SessionsRepository _repository;
  RevokeSessionUseCase(this._repository);

  @override
  FutureEither<void> call(String params) async {
    final result = await _repository.revokeSession(params);
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            RevokeSessionUseCaseEvent.failure(
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
        unawaited(Analytics.track(RevokeSessionUseCaseEvent.success()));
        return result;
      },
    );
  }
}
