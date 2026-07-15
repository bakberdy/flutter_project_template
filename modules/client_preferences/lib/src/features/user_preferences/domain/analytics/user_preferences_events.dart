import 'package:core/core.dart';

final class GetUserThemeUseCaseEvent extends AnalyticsEvent {
  const GetUserThemeUseCaseEvent({required super.name, super.properties});

  factory GetUserThemeUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => GetUserThemeUseCaseEvent(
    name: 'get_user_theme_usecase_success',
    properties: properties,
  );

  factory GetUserThemeUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetUserThemeUseCaseEvent(
    name: 'get_user_theme_usecase_failure',
    properties: properties,
  );
}

final class GetAppLocaleUseCaseEvent extends AnalyticsEvent {
  const GetAppLocaleUseCaseEvent({required super.name, super.properties});

  factory GetAppLocaleUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => GetAppLocaleUseCaseEvent(
    name: 'get_app_locale_usecase_success',
    properties: properties,
  );

  factory GetAppLocaleUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetAppLocaleUseCaseEvent(
    name: 'get_app_locale_usecase_failure',
    properties: properties,
  );
}

final class SetUserThemeUseCaseEvent extends AnalyticsEvent {
  const SetUserThemeUseCaseEvent({required super.name, super.properties});

  factory SetUserThemeUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => SetUserThemeUseCaseEvent(
    name: 'set_user_theme_usecase_success',
    properties: properties,
  );

  factory SetUserThemeUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => SetUserThemeUseCaseEvent(
    name: 'set_user_theme_usecase_failure',
    properties: properties,
  );
}

final class SetAppLocaleUseCaseEvent extends AnalyticsEvent {
  const SetAppLocaleUseCaseEvent({required super.name, super.properties});

  factory SetAppLocaleUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => SetAppLocaleUseCaseEvent(
    name: 'set_app_locale_usecase_success',
    properties: properties,
  );

  factory SetAppLocaleUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => SetAppLocaleUseCaseEvent(
    name: 'set_app_locale_usecase_failure',
    properties: properties,
  );
}

final class SetUserNotificationsUseCaseEvent extends AnalyticsEvent {
  const SetUserNotificationsUseCaseEvent({
    required super.name,
    super.properties,
  });

  factory SetUserNotificationsUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => SetUserNotificationsUseCaseEvent(
    name: 'set_user_notifications_usecase_success',
    properties: properties,
  );

  factory SetUserNotificationsUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => SetUserNotificationsUseCaseEvent(
    name: 'set_user_notifications_usecase_failure',
    properties: properties,
  );
}

final class SetEnvironmentUseCaseEvent extends AnalyticsEvent {
  const SetEnvironmentUseCaseEvent({required super.name, super.properties});

  factory SetEnvironmentUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => SetEnvironmentUseCaseEvent(
    name: 'set_environment_use_case_success',
    properties: properties,
  );

  factory SetEnvironmentUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => SetEnvironmentUseCaseEvent(
    name: 'set_environment_use_case_failure',
    properties: properties,
  );
}

final class GetEnvironmentUseCaseEvent extends AnalyticsEvent {
  const GetEnvironmentUseCaseEvent({required super.name, super.properties});

  factory GetEnvironmentUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => GetEnvironmentUseCaseEvent(
    name: 'get_environment_use_case_success',
    properties: properties,
  );

  factory GetEnvironmentUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetEnvironmentUseCaseEvent(
    name: 'get_environment_use_case_failure',
    properties: properties,
  );
}
