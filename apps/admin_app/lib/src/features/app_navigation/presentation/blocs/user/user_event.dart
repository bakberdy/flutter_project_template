part of 'user_bloc.dart';

sealed class UserEvent {
  const UserEvent();
}

final class UserStartedEvent extends UserEvent {
  const UserStartedEvent();
}

final class UserLoginEvent extends UserEvent {
  const UserLoginEvent();
}

final class UserLogoutEvent extends UserEvent {
  const UserLogoutEvent();
}
