import 'dart:async';

import 'package:client_auth/src/features/auth/domain/analytics/authorization_events.dart';
import 'package:client_auth/src/features/auth/domain/entities/verify_response.dart';
import 'package:client_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRefreshTokenUseCase extends UseCase<VerifyResponse, NoParams> {
  final AuthRepository _repository;
  AuthRefreshTokenUseCase(this._repository);

  @override
  FutureEither<VerifyResponse> call(NoParams params) async {
    final result = await _repository.refreshToken();
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            AuthRefreshTokenUseCaseEvent.failure(
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
        unawaited(Analytics.track(AuthRefreshTokenUseCaseEvent.success()));
        return result;
      },
    );
  }
}
