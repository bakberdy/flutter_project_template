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
