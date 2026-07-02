import 'dart:async';

enum AuthSessionState { authenticated, unauthenticated }

abstract interface class AuthSessionInvalidator {
  Stream<AuthSessionState> get state;

  AuthSessionState get currentState;

  Future<void> setState(AuthSessionState state);
}
