part of 'user_bloc.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState({
    User? user,
    @Default(false) bool hasSession,
    Failure? launchFailure,
    @Default(StateStatus.initial()) StateStatus status,
  }) = _UserState;
}
