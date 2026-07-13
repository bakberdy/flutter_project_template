part of 'theme_bloc.dart';

@freezed
sealed class ThemeState with _$ThemeState {
  const factory ThemeState({
    UserTheme? themeMode,
    UserTheme? systemThemeMode,
    UserTheme? appliedThemeMode,
    @Default(StateStatus.initial()) StateStatus status,
  }) = _ThemeState;
}
