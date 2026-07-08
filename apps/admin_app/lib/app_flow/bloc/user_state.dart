part of 'user_bloc.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoggedIn extends UserState {
  final bool isOnboarded;
  final bool isFilledProfile;

  UserLoggedIn({required this.isOnboarded, required this.isFilledProfile});
}

final class UserLoggedOut extends UserState {}
