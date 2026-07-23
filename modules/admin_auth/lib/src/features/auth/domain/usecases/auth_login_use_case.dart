import 'dart:async';

import 'package:admin_auth/src/features/auth/domain/analytics/authorization_events.dart';
import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@lazySingleton
class AuthLoginUseCase extends UseCase<AuthLoginResponse, String> {
  AuthLoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  FutureEither<AuthLoginResponse> call(String params) async {
    final result = await _repository.login(params);
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            AuthLoginUseCaseEvent.failure(
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
        unawaited(Analytics.track(AuthLoginUseCaseEvent.success()));
        return result;
      },
    );
  }
}
