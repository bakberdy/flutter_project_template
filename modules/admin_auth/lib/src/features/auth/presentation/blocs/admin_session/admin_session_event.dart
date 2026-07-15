part of 'admin_session_bloc.dart';

sealed class AdminSessionEvent {
  const AdminSessionEvent();
}

sealed class AdminSessionTransitionEvent extends AdminSessionEvent {
  const AdminSessionTransitionEvent();
}

final class AdminSessionStarted extends AdminSessionTransitionEvent {
  const AdminSessionStarted();
}

final class AdminSessionLogoutRequested extends AdminSessionTransitionEvent {
  const AdminSessionLogoutRequested();
}

final class AdminSessionInvalidated extends AdminSessionTransitionEvent {
  const AdminSessionInvalidated();
}

final class AdminSessionFailureAcknowledged extends AdminSessionEvent {
  const AdminSessionFailureAcknowledged();
}

final class AdminSessionAccessDeniedAcknowledged extends AdminSessionEvent {
  const AdminSessionAccessDeniedAcknowledged();
}
