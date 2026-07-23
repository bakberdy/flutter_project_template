import 'dart:async';

import 'package:client_auth/src/features/auth/domain/analytics/authorization_events.dart';
import 'package:client_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@lazySingleton
class AuthVerifyUseCase extends UseCase<AuthVerifyResponse, AuthVerifyRequest> {
  AuthVerifyUseCase(this._repository);
  final AuthRepository _repository;

  @override
  FutureEither<AuthVerifyResponse> call(AuthVerifyRequest params) async {
    final result = await _repository.verify(params);
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            AuthVerifyUseCaseEvent.failure(
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
        unawaited(Analytics.track(AuthVerifyUseCaseEvent.success()));
        return result;
      },
    );
  }
}
