import 'dart:async';

import 'package:admin_auth/src/features/sessions/domain/analytics/sessions_events.dart';
import 'package:admin_auth/src/features/sessions/domain/entities/session.dart';
import 'package:admin_auth/src/features/sessions/domain/repositories/sessions_repository.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

typedef GetSessionsParams = ({int? pageNumber, int? limit, bool? isActive});

@lazySingleton
class GetSessionsUseCase
    extends UseCase<PaginatedResponse<Session>, GetSessionsParams> {
  GetSessionsUseCase(this._repository);

  final SessionsRepository _repository;

  @override
  FutureEither<PaginatedResponse<Session>> call(
    GetSessionsParams params,
  ) async {
    final result = await _repository.getSessions(
      pageNumber: params.pageNumber ?? 1,
      limit: params.limit ?? 20,
      isActive: params.isActive,
    );
    return result.fold(
      (failure) {
        if (failure.details?.type != FailureType.silent) {
          unawaited(
            Analytics.track(
              GetSessionsUseCaseEvent.failure(
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
        return result;
      },
      (_) {
        unawaited(Analytics.track(GetSessionsUseCaseEvent.success()));
        return result;
      },
    );
  }
}
