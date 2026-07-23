part of 'sessions_bloc.dart';

@freezed
sealed class SessionsState with _$SessionsState {
  const factory SessionsState({
    @Default(<UserSession>[]) List<UserSession> sessions,
    @Default(StateStatus.initial()) StateStatus listStatus,
    Failure? transientActionFailure,
    String? revokingSessionId,
    @Default(false) bool revokingAll,
    @Default(false) bool navigateToAuthAfterRevokeAll,
  }) = _SessionsState;
}
