import 'package:core/core.dart';

final class GetSessionsUseCaseEvent extends AnalyticsEvent {
  const GetSessionsUseCaseEvent({required super.name, super.properties});

  factory GetSessionsUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      GetSessionsUseCaseEvent(
        name: 'sessions_get_usecase_success',
        properties: properties,
      );

  factory GetSessionsUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetSessionsUseCaseEvent(
    name: 'sessions_get_usecase_failure',
    properties: properties,
  );
}

final class RevokeSessionUseCaseEvent extends AnalyticsEvent {
  const RevokeSessionUseCaseEvent({required super.name, super.properties});

  factory RevokeSessionUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => RevokeSessionUseCaseEvent(
    name: 'sessions_revoke_usecase_success',
    properties: properties,
  );

  factory RevokeSessionUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => RevokeSessionUseCaseEvent(
    name: 'sessions_revoke_usecase_failure',
    properties: properties,
  );
}

final class RevokeAllSessionsUseCaseEvent extends AnalyticsEvent {
  const RevokeAllSessionsUseCaseEvent({required super.name, super.properties});

  factory RevokeAllSessionsUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => RevokeAllSessionsUseCaseEvent(
    name: 'sessions_revoke_all_usecase_success',
    properties: properties,
  );

  factory RevokeAllSessionsUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => RevokeAllSessionsUseCaseEvent(
    name: 'sessions_revoke_all_usecase_failure',
    properties: properties,
  );
}
