import 'dart:async';

import 'package:client_auth/src/features/auth/domain/analytics/authorization_events.dart';
import 'package:client_auth/src/features/auth/domain/entities/login_response.dart';
import 'package:client_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthLoginUseCase extends UseCase<LoginResponse, String> {
  final AuthRepository _repository;
  AuthLoginUseCase(this._repository);

  @override
  FutureEither<LoginResponse> call(String params) async {
    final result = await _repository.login(params);
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            AuthLoginUseCaseEvent.failure(
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
        unawaited(Analytics.track(AuthLoginUseCaseEvent.success()));
        return result;
      },
    );
  }
}
