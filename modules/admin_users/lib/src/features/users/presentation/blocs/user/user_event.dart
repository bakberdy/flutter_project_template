part of 'user_bloc.dart';

@freezed
sealed class UserEvent with _$UserEvent {
  const factory UserEvent.started(String userId) = _Started;
  const factory UserEvent.deletionApproved(String userId) = _DeletionApproved;
  const factory UserEvent.blocked(String userId) = _Blocked;
  const factory UserEvent.unblocked(String userId) = _Unblocked;
}
