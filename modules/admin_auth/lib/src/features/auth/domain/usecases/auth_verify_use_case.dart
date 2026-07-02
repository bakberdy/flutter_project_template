import 'dart:async';

import 'package:core/core.dart';
import 'package:admin_auth/src/features/auth/domain/analytics/authorization_events.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_response.dart';
import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthVerifyUseCase extends UseCase<VerifyResponse, VerifyRequest> {
  final AuthRepository _repository;
  AuthVerifyUseCase(this._repository);

  @override
  FutureEither<VerifyResponse> call(VerifyRequest params) async {
    final result = await _repository.verify(params);
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            AuthVerifyUseCaseEvent.failure(
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
        unawaited(Analytics.track(AuthVerifyUseCaseEvent.success()));
        return result;
      },
    );
  }
}
