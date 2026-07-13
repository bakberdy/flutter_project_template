part of 'sessions_bloc.dart';

@freezed
class SessionsEvent with _$SessionsEvent {
  const factory SessionsEvent.started() = _Started;
  const factory SessionsEvent.refreshed() = _Refreshed;
  const factory SessionsEvent.sessionRevokeRequested(String sessionId) =
      _SessionRevokeRequested;
  const factory SessionsEvent.revokeAllRequested() = _RevokeAllRequested;
  const factory SessionsEvent.transientFailureAcknowledged() =
      _TransientFailureAcknowledged;
}
