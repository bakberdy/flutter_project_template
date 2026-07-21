import 'dart:async';

import 'package:client_profile/src/features/profile/domain/analytics/user_profile_events.dart';
import 'package:core/core.dart';

FutureEither<T> trackUserProfileUseCase<T>(
  FutureEither<T> result,
  String action,
) async {
  final resolved = await result;
  return resolved.fold(
    (failure) {
      if (failure.details?.type != FailureType.silent) {
        unawaited(
          Analytics.track(
            UserProfileUseCaseEvent.failure(
              action,
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
      return resolved;
    },
    (_) {
      unawaited(Analytics.track(UserProfileUseCaseEvent.success(action)));
      return resolved;
    },
  );
}
