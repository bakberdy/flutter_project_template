part of 'notifications_bloc.dart';

enum UserPreferencesNotificationType { push, email, marketing }

@freezed
sealed class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    UserPreferences? preferences,
    UserPreferencesNotificationType? updatingType,
    @Default(StateStatus.initial()) StateStatus status,
  }) = _NotificationsState;
}
