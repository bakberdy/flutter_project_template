import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._tokenStorage) : super(const UserInitial()) {
    on<UserStartedEvent>(_onStarted);
    on<UserLoginEvent>(_onLogin);
    on<UserLogoutEvent>(_onLogout);
  }

  final TokenStorage _tokenStorage;

  Future<void> _onStarted(
    UserStartedEvent event,
    Emitter<UserState> emit,
  ) async {
    final accessToken = await _tokenStorage.getAccessToken();
    emit(
      accessToken == null || accessToken.isEmpty
          ? const UserLoggedOut()
          : const UserLoggedIn(),
    );
  }

  void _onLogin(UserLoginEvent event, Emitter<UserState> emit) {
    emit(const UserLoggedIn());
  }

  Future<void> _onLogout(UserLogoutEvent event, Emitter<UserState> emit) async {
    await _tokenStorage.clearTokens();
    emit(const UserLoggedOut());
  }
}
