import 'dart:async';

import 'package:admin_auth/src/features/auth/domain/analytics/authorization_events.dart';
import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthSetNotificationTokenUseCase
    extends UseCase<void, AuthSetNotificationTokenParams> {
  AuthSetNotificationTokenUseCase(this._repository);

  final AuthRepository _repository;

  @override
  FutureEither<void> call(AuthSetNotificationTokenParams params) async {
    final result = await _repository.setNotificationToken(
      params.token,
      params.provider,
    );
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            AuthSetNotificationTokenUseCaseEvent.failure(
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
        unawaited(
          Analytics.track(AuthSetNotificationTokenUseCaseEvent.success()),
        );
        return result;
      },
    );
  }
}

class AuthSetNotificationTokenParams {
  const AuthSetNotificationTokenParams({
    required this.token,
    required this.provider,
  });

  final String token;
  final String provider;
}
