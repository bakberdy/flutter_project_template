import 'dart:async';

import 'package:core/core.dart';
import 'package:client_auth/src/features/auth/domain/analytics/authorization_events.dart';
import 'package:client_auth/src/features/auth/domain/repositories/auth_repository.dart';

class AuthLogOutUseCase extends UseCase<void, NoParams> {
  final AuthRepository _repository;
  AuthLogOutUseCase(this._repository);

  @override
  FutureEither<void> call(NoParams params) async {
    final result = await _repository.logOut();
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            AuthLogOutUseCaseEvent.failure(
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
        unawaited(Analytics.track(AuthLogOutUseCaseEvent.success()));
        return result;
      },
    );
  }
}
