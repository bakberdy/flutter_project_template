part of 'notifications_bloc.dart';

@freezed
sealed class NotificationsEvent with _$NotificationsEvent {
  const factory NotificationsEvent.started() = NotificationsStarted;

  const factory NotificationsEvent.changed({
    required UserPreferencesNotificationType type,
    required bool enabled,
  }) = NotificationsChanged;
}
