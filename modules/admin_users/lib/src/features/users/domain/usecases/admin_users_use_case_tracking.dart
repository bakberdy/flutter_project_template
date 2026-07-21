import 'dart:async';

import 'package:admin_users/src/features/users/domain/analytics/admin_users_events.dart';
import 'package:core/core.dart';

FutureEither<T> trackAdminUsersUseCase<T>(
  FutureEither<T> operation,
  String action, {
  Map<String, dynamic>? properties,
}) async {
  final result = await operation;
  return result.fold(
    (failure) {
      unawaited(
        Analytics.track(
          AdminUsersUseCaseEvent.failure(
            action,
            properties: {
              ...?properties,
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
        Analytics.track(
          AdminUsersUseCaseEvent.success(action, properties: properties),
        ),
      );
      return result;
    },
  );
}
