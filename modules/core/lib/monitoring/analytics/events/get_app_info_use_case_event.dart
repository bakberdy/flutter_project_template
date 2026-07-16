import 'package:core/monitoring/analytics/analytics_events.dart';

final class GetAppInfoUseCaseEvent extends AnalyticsEvent {
  const GetAppInfoUseCaseEvent({required super.name, super.properties});

  factory GetAppInfoUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      GetAppInfoUseCaseEvent(
        name: 'get_app_info_usecase_success',
        properties: properties,
      );

  factory GetAppInfoUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetAppInfoUseCaseEvent(
    name: 'get_app_info_usecase_failure',
    properties: properties,
  );
}
