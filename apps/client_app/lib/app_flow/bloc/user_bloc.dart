import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._localStorage) : super(UserInitial()) {
    on<UserStartedEvent>(_onStarted);
    on<UserLoginEvent>((event, emit) async {
      final state = UserLoggedIn(isOnboarded: false, isFilledProfile: false);
      emit(state);
      await _saveState(state);
    });
    on<UserLogoutEvent>((event, emit) async {
      final state = UserLoggedOut();
      emit(state);
      await _saveState(state);
    });
    on<UserOnboardedEvent>((event, emit) async {
      final state = UserLoggedIn(isOnboarded: true, isFilledProfile: false);
      emit(state);
      await _saveState(state);
    });
    on<UserProfileFilledEvent>((event, emit) async {
      final state = UserLoggedIn(isOnboarded: true, isFilledProfile: true);
      emit(state);
      await _saveState(state);
    });

    add(UserStartedEvent());
  }

  static const _storageKey = 'client_app_user_state';

  final LocalStorage _localStorage;

  Future<void> _onStarted(
    UserStartedEvent event,
    Emitter<UserState> emit,
  ) async {
    final restoredState = await _restoreState();
    emit(restoredState ?? UserLoggedOut());
  }

  Future<UserState?> _restoreState() async {
    final value = await _localStorage.read(key: _storageKey);
    if (value == null) {
      return null;
    }

    try {
      final json = jsonDecode(value) as Map<String, dynamic>;
      return switch (json['type']) {
        'loggedOut' => UserLoggedOut(),
        'loggedIn' => UserLoggedIn(
          isOnboarded: json['isOnboarded'] as bool? ?? false,
          isFilledProfile: json['isFilledProfile'] as bool? ?? false,
        ),
        _ => null,
      };
    } on Object {
      await _localStorage.delete(key: _storageKey);
      return null;
    }
  }

  Future<void> _saveState(UserState state) {
    return _localStorage.write(
      key: _storageKey,
      value: jsonEncode(_stateToJson(state)),
    );
  }

  Map<String, Object?> _stateToJson(UserState state) {
    return switch (state) {
      UserInitial() => {'type': 'initial'},
      UserLoggedOut() => {'type': 'loggedOut'},
      UserLoggedIn(:final isOnboarded, :final isFilledProfile) => {
        'type': 'loggedIn',
        'isOnboarded': isOnboarded,
        'isFilledProfile': isFilledProfile,
      },
    };
  }
}
