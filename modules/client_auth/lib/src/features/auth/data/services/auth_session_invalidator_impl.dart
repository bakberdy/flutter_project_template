import 'dart:async';

import 'package:client_auth/src/features/auth/domain/services/auth_session_invalidator.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthSessionInvalidator)
class AuthSessionInvalidatorImpl implements AuthSessionInvalidator {
  final StreamController<AuthSessionState> _stateController =
      StreamController<AuthSessionState>.broadcast(sync: true);

  AuthSessionState _currentState = AuthSessionState.unauthenticated;

  @override
  Stream<AuthSessionState> get state => _stateController.stream;

  @override
  AuthSessionState get currentState => _currentState;

  @override
  Future<void> setState(AuthSessionState state) async {
    _currentState = state;
    _stateController.add(state);
  }
}
