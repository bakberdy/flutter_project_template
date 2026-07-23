import 'dart:async';

import 'package:admin_profile/src/features/profile/domain/analytics/get_current_user_events.dart';
import 'package:admin_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

typedef GetCurrentUserParams = ({
  ApiCancelToken? cancelToken,
  Duration? timeout,
});

typedef GetCurrentUserResult = ({User? user, bool accessDenied});

@lazySingleton
class GetCurrentUserUseCase
    extends UseCase<GetCurrentUserResult, GetCurrentUserParams> {
  GetCurrentUserUseCase(this._repository);

  final UserProfileRepository _repository;

  @override
  FutureEither<GetCurrentUserResult> call(GetCurrentUserParams params) {
    final result = _getCurrentUser(cancelToken: params.cancelToken);
    final timeout = params.timeout;
    return timeout == null
        ? result
        : result.timeout(
            timeout,
            onTimeout: () => const Left(
              TimeoutFailure(
                source: 'GetCurrentUserUseCase.timeout',
                details: FailureDetails(statusCode: 0),
              ),
            ),
          );
  }

  FutureEither<GetCurrentUserResult> _getCurrentUser({
    ApiCancelToken? cancelToken,
  }) async {
    if (!await _repository.hasSession()) {
      _trackSuccess('missing');
      return const Right((user: null, accessDenied: false));
    }

    final result = await _repository.getCurrentUser(cancelToken: cancelToken);
    return result.fold(
      (failure) {
        if (failure.details?.type != FailureType.silent) {
          unawaited(
            Analytics.track(
              GetCurrentUserUseCaseEvent.failure(
                properties: {
                  if (failure case BackendFailure(:final message))
                    AnalyticsPropertyKeys.failureMessage: message,
                  AnalyticsPropertyKeys.failureType: failure.details?.type.name,
                  AnalyticsPropertyKeys.failureSource: failure.source,
                },
              ),
            ),
          );
        }
        return Left(failure);
      },
      (user) async {
        if (user.role == UserRole.user) {
          await _repository.clearSession();
          _trackSuccess('access_denied');
          return const Right((user: null, accessDenied: true));
        }
        _trackSuccess('authenticated');
        return Right((user: user, accessDenied: false));
      },
    );
  }

  void _trackSuccess(String sessionState) {
    unawaited(
      Analytics.track(
        GetCurrentUserUseCaseEvent.success(
          properties: {'session_state': sessionState},
        ),
      ),
    );
  }
}
