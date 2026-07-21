import 'dart:async';

import 'package:client_auth/src/features/auth/domain/analytics/authorization_events.dart';
import 'package:client_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:client_auth/src/features/auth/domain/entities/verify_response.dart';
import 'package:client_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthVerifyUseCase extends UseCase<VerifyResponse, VerifyRequest> {
  AuthVerifyUseCase(this._repository);
  final AuthRepository _repository;

  @override
  FutureEither<VerifyResponse> call(VerifyRequest params) async {
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
