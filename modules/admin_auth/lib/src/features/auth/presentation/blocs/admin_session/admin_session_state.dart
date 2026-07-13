part of 'admin_session_bloc.dart';

class AdminSessionState {
  const AdminSessionState({
    this.user,
    this.hasSession = false,
    this.accessDenied = false,
    this.launchFailure,
    this.status = const StateStatus.initial(),
  });

  final User? user;
  final bool hasSession;
  final bool accessDenied;
  final Failure? launchFailure;
  final StateStatus status;

  AdminSessionState copyWith({
    User? user,
    bool clearUser = false,
    bool? hasSession,
    bool? accessDenied,
    Failure? launchFailure,
    bool clearLaunchFailure = false,
    StateStatus? status,
  }) => AdminSessionState(
    user: clearUser ? null : user ?? this.user,
    hasSession: hasSession ?? this.hasSession,
    accessDenied: accessDenied ?? this.accessDenied,
    launchFailure: clearLaunchFailure
        ? null
        : launchFailure ?? this.launchFailure,
    status: status ?? this.status,
  );
}
