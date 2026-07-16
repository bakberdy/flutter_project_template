import 'package:core/core.dart';

final class LogOutUseCaseEvent extends AnalyticsEvent {
  const LogOutUseCaseEvent({required super.name, super.properties});

  factory LogOutUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      LogOutUseCaseEvent(
        name: 'log_out_usecase_success',
        properties: properties,
      );

  factory LogOutUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => LogOutUseCaseEvent(
    name: 'log_out_usecase_failure',
    properties: properties,
  );
}
