import 'dart:async';

import 'package:admin_auth/src/features/auth/domain/analytics/authorization_events.dart';
import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

typedef AdminSessionResult = ({User? user, bool accessDenied});

@lazySingleton
class GetAdminSessionUseCase extends UseCase<AdminSessionResult, NoParams> {
  GetAdminSessionUseCase(this._repository);

  final AuthRepository _repository;

  @override
  FutureEither<AdminSessionResult> call(NoParams params) async {
    if (!await _repository.hasSession()) {
      unawaited(
        Analytics.track(
          GetAdminSessionUseCaseEvent.success(
            properties: const {'session_state': 'missing'},
          ),
        ),
      );
      return const Right((user: null, accessDenied: false));
    }

    final result = await _repository.getCurrentUser();
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            GetAdminSessionUseCaseEvent.failure(
              properties: {
                AnalyticsPropertyKeys.failureMessage: failure.message,
                AnalyticsPropertyKeys.failureType: failure.details?.type.name,
                AnalyticsPropertyKeys.failureSource: failure.source,
              },
            ),
          ),
        );
        return Left(failure);
      },
      (user) async {
        if (user.role == UserRole.user) {
          await _repository.clearSession();
          unawaited(
            Analytics.track(
              GetAdminSessionUseCaseEvent.success(
                properties: const {'session_state': 'access_denied'},
              ),
            ),
          );
          return const Right((user: null, accessDenied: true));
        }
        unawaited(
          Analytics.track(
            GetAdminSessionUseCaseEvent.success(
              properties: const {'session_state': 'authenticated'},
            ),
          ),
        );
        return Right((user: user, accessDenied: false));
      },
    );
  }
}
