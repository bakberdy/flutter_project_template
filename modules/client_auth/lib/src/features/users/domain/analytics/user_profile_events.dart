import 'package:core/core.dart';

final class UserProfileUseCaseEvent extends AnalyticsEvent {
  const UserProfileUseCaseEvent({required super.name, super.properties});

  factory UserProfileUseCaseEvent.success(
    String action, {
    Map<String, dynamic>? properties,
  }) => UserProfileUseCaseEvent(
    name: 'user_profile_${action}_usecase_success',
    properties: properties,
  );

  factory UserProfileUseCaseEvent.failure(
    String action, {
    required Map<String, dynamic> properties,
  }) => UserProfileUseCaseEvent(
    name: 'user_profile_${action}_usecase_failure',
    properties: properties,
  );
}
