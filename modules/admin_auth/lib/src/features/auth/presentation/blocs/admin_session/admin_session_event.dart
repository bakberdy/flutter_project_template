part of 'admin_session_bloc.dart';

sealed class AdminSessionEvent {
  const AdminSessionEvent();
}

final class AdminSessionStarted extends AdminSessionEvent {
  const AdminSessionStarted();
}

final class AdminSessionLogoutRequested extends AdminSessionEvent {
  const AdminSessionLogoutRequested();
}

final class AdminSessionFailureAcknowledged extends AdminSessionEvent {
  const AdminSessionFailureAcknowledged();
}

final class AdminSessionAccessDeniedAcknowledged extends AdminSessionEvent {
  const AdminSessionAccessDeniedAcknowledged();
}
