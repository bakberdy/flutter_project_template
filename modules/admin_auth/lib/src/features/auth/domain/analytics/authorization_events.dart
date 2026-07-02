import 'package:core/core.dart';

final class AuthLoginUseCaseEvent extends AnalyticsEvent {
  const AuthLoginUseCaseEvent({required super.name, super.properties});

  factory AuthLoginUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      AuthLoginUseCaseEvent(
        name: 'auth_login_usecase_success',
        properties: properties,
      );

  factory AuthLoginUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => AuthLoginUseCaseEvent(
    name: 'auth_login_usecase_failure',
    properties: properties,
  );
}

final class AuthVerifyUseCaseEvent extends AnalyticsEvent {
  const AuthVerifyUseCaseEvent({required super.name, super.properties});

  factory AuthVerifyUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      AuthVerifyUseCaseEvent(
        name: 'auth_verify_usecase_success',
        properties: properties,
      );

  factory AuthVerifyUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => AuthVerifyUseCaseEvent(
    name: 'auth_verify_usecase_failure',
    properties: properties,
  );
}

final class AuthRefreshTokenUseCaseEvent extends AnalyticsEvent {
  const AuthRefreshTokenUseCaseEvent({required super.name, super.properties});

  factory AuthRefreshTokenUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => AuthRefreshTokenUseCaseEvent(
    name: 'auth_refresh_token_usecase_success',
    properties: properties,
  );

  factory AuthRefreshTokenUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => AuthRefreshTokenUseCaseEvent(
    name: 'auth_refresh_token_usecase_failure',
    properties: properties,
  );
}

final class AuthLogOutUseCaseEvent extends AnalyticsEvent {
  const AuthLogOutUseCaseEvent({required super.name, super.properties});

  factory AuthLogOutUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      AuthLogOutUseCaseEvent(
        name: 'auth_log_out_usecase_success',
        properties: properties,
      );

  factory AuthLogOutUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => AuthLogOutUseCaseEvent(
    name: 'auth_log_out_usecase_failure',
    properties: properties,
  );
}

final class AuthSetNotificationTokenUseCaseEvent extends AnalyticsEvent {
  const AuthSetNotificationTokenUseCaseEvent({
    required super.name,
    super.properties,
  });

  factory AuthSetNotificationTokenUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => AuthSetNotificationTokenUseCaseEvent(
    name: 'auth_set_notification_token_usecase_success',
    properties: properties,
  );

  factory AuthSetNotificationTokenUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => AuthSetNotificationTokenUseCaseEvent(
    name: 'auth_set_notification_token_usecase_failure',
    properties: properties,
  );
}
