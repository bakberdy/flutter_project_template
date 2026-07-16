part of 'user_bloc.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState({
    User? user,
    @Default(false) bool accessDenied,
    @Default(StateStatus.initial()) StateStatus status,
  }) = _UserState;
}
