import 'dart:async';

import 'package:core/core.dart';
import 'package:client_profile/src/features/profile/domain/analytics/log_out_events.dart';
import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogOutUseCase extends UseCase<void, NoParams> {
  final UserProfileRepository _repository;

  LogOutUseCase(this._repository);

  @override
  FutureEither<void> call(NoParams params) async {
    final result = await _repository.logOut();
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            LogOutUseCaseEvent.failure(
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
        unawaited(Analytics.track(LogOutUseCaseEvent.success()));
        return result;
      },
    );
  }
}
