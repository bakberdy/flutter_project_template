import 'dart:async';

import 'package:core/core.dart';
import 'package:admin_profile/src/features/profile/domain/analytics/user_profile_events.dart';

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
                AnalyticsPropertyKeys.failureMessage: failure.message,
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
