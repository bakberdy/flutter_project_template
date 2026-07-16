import 'package:core/core.dart';

final class GetCurrentUserUseCaseEvent extends AnalyticsEvent {
  const GetCurrentUserUseCaseEvent({required super.name, super.properties});

  factory GetCurrentUserUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => GetCurrentUserUseCaseEvent(
    name: 'get_current_user_usecase_success',
    properties: properties,
  );

  factory GetCurrentUserUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetCurrentUserUseCaseEvent(
    name: 'get_current_user_usecase_failure',
    properties: properties,
  );
}
