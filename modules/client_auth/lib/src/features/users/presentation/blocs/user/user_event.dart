part of 'user_bloc.dart';

sealed class UserEvent {
  const UserEvent();
}

final class UserStartedEvent extends UserEvent {
  const UserStartedEvent();
}
