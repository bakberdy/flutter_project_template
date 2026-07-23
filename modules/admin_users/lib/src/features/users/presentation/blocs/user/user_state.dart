part of 'user_bloc.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState({
    User? user,
    UserProfile? profile,
    @Default(StateStatus.initial()) StateStatus status,
    @Default(StateStatus.initial()) StateStatus actionStatus,
  }) = _UserState;
}
