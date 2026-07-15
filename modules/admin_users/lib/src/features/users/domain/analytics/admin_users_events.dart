import 'package:core/core.dart';

final class AdminUsersUseCaseEvent extends AnalyticsEvent {
  const AdminUsersUseCaseEvent({required super.name, super.properties});

  factory AdminUsersUseCaseEvent.success(
    String action, {
    Map<String, dynamic>? properties,
  }) => AdminUsersUseCaseEvent(
    name: 'admin_users_${action}_usecase_success',
    properties: properties,
  );

  factory AdminUsersUseCaseEvent.failure(
    String action, {
    required Map<String, dynamic> properties,
  }) => AdminUsersUseCaseEvent(
    name: 'admin_users_${action}_usecase_failure',
    properties: properties,
  );
}
