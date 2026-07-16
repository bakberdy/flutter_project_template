import 'dart:async';

import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/domain/usecases/get_user_theme_use_case.dart';
import 'package:client_preferences/src/features/user_preferences/domain/usecases/set_user_theme_use_case.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'theme_bloc.freezed.dart';
part 'theme_event.dart';
part 'theme_state.dart';

UserTheme _resolveAppliedThemeMode(
  UserTheme? themeMode,
  UserTheme? systemThemeMode,
) {
  switch (themeMode) {
    case UserTheme.system:
    case null:
      return systemThemeMode ?? UserTheme.light;
    case UserTheme.light:
    case UserTheme.dark:
      return themeMode;
  }
}

@Injectable()
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetUserThemeUseCase _getUserThemeUseCase;
  final SetUserThemeUseCase _setUserThemeUseCase;

  ThemeBloc(this._getUserThemeUseCase, this._setUserThemeUseCase)
    : super(const ThemeState()) {
    on<ThemeStarted>(_onStarted);
    on<ThemeModeChanged>(_onModeChanged);
    on<ThemeSystemRefreshed>(_onSystemRefreshed);
  }

  void setThemeMode(UserTheme mode) {
    add(ThemeEvent.modeChanged(mode));
  }

  void start({required UserTheme systemThemeMode}) {
    add(ThemeEvent.started(systemThemeMode));
  }

  void applySystemThemeMode(UserTheme systemThemeMode) {
    add(ThemeEvent.systemRefreshed(systemThemeMode));
  }

  Future<void> _onStarted(ThemeStarted event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(status: const StateStatus.loading()));

    final result = await _getUserThemeUseCase(const NoParams());

    await result.fold<Future<void>>(
      (Failure failure) async {
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (UserTheme? userTheme) async {
        if (userTheme != null) {
          emit(
            state.copyWith(
              themeMode: userTheme,
              systemThemeMode: event.systemThemeMode,
              appliedThemeMode: _resolveAppliedThemeMode(
                userTheme,
                event.systemThemeMode,
              ),
              status: const StateStatus.success(),
            ),
          );
        } else {
          await _setUserThemeUseCase(
            const SetUserThemeUseCaseParams(theme: UserTheme.system),
          );
          if (emit.isDone) {
            return;
          }
          emit(
            state.copyWith(
              themeMode: UserTheme.system,
              systemThemeMode: event.systemThemeMode,
              appliedThemeMode: _resolveAppliedThemeMode(
                UserTheme.system,
                event.systemThemeMode,
              ),
              status: const StateStatus.success(),
            ),
          );
        }
      },
    );
  }

  Future<void> _onModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(
      state.copyWith(
        themeMode: event.mode,
        systemThemeMode: state.systemThemeMode,
        appliedThemeMode: _resolveAppliedThemeMode(
          event.mode,
          state.systemThemeMode,
        ),
        status: const StateStatus.loading(),
      ),
    );

    final result = await _setUserThemeUseCase(
      SetUserThemeUseCaseParams(theme: event.mode),
    );

    result.fold(
      (Failure failure) {
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (_) {
        emit(state.copyWith(status: const StateStatus.success()));
      },
    );
  }

  void _onSystemRefreshed(
    ThemeSystemRefreshed event,
    Emitter<ThemeState> emit,
  ) {
    final hasSystemModeChanged = event.systemThemeMode != state.systemThemeMode;
    if (!hasSystemModeChanged && state.themeMode != UserTheme.system) {
      return;
    }

    final appliedThemeMode = _resolveAppliedThemeMode(
      state.themeMode,
      event.systemThemeMode,
    );
    if (!hasSystemModeChanged && appliedThemeMode == state.appliedThemeMode) {
      return;
    }

    emit(
      state.copyWith(
        systemThemeMode: event.systemThemeMode,
        appliedThemeMode: appliedThemeMode,
        status: const StateStatus.success(),
      ),
    );
  }
}
