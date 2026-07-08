part of 'user_bloc.dart';

sealed class UserEvent {}

class UserStartedEvent extends UserEvent {
  UserStartedEvent();
}

class UserLoginEvent extends UserEvent {
  UserLoginEvent();
}

class UserLogoutEvent extends UserEvent {
  UserLogoutEvent();
}

class UserOnboardedEvent extends UserEvent {
  UserOnboardedEvent();
}

class UserProfileFilledEvent extends UserEvent {
  UserProfileFilledEvent();
}
