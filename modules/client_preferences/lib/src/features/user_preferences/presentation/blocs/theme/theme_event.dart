part of 'theme_bloc.dart';

@freezed
sealed class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.started(UserTheme systemThemeMode) = ThemeStarted;

  const factory ThemeEvent.modeChanged(UserTheme mode) = ThemeModeChanged;

  const factory ThemeEvent.systemRefreshed(UserTheme systemThemeMode) =
      ThemeSystemRefreshed;
}
