part of 'user_bloc.dart';

sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class UserLoggedIn extends UserState {
  const UserLoggedIn();
}

final class UserLoggedOut extends UserState {
  const UserLoggedOut();
}
