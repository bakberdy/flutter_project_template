part of 'user_bloc.dart';

@Freezed(copyWith: false)
sealed class UserEvent with _$UserEvent {
  const factory UserEvent.refreshUser() = UserRefreshEvent;
  const factory UserEvent.logout() = UserLoggedOutEvent;
}
