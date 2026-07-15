import 'package:client_preferences/client_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

typedef AppThemeScopeBuilder =
    Widget Function(BuildContext context, ThemeMode themeMode, Widget? child);

class AppThemeScope extends StatelessWidget {
  final AppThemeScopeBuilder builder;
  final Widget? child;

  const AppThemeScope({required this.builder, this.child, super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ThemeBloc>(
    create: (context) => context.di<ThemeBloc>(),
    child: _AppThemeScopeBody(builder: builder, child: child),
  );
}

class _AppThemeScopeBody extends StatefulWidget {
  const _AppThemeScopeBody({required this.builder, this.child});

  final AppThemeScopeBuilder builder;
  final Widget? child;

  @override
  State<_AppThemeScopeBody> createState() => _AppThemeScopeBodyState();
}

class _AppThemeScopeBodyState extends State<_AppThemeScopeBody> {
  late final ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = context.read<ThemeBloc>();
  }

  UserTheme _toUserTheme(Brightness brightness) =>
      brightness == Brightness.dark ? UserTheme.dark : UserTheme.light;

  @override
  Widget build(BuildContext context) => SystemBrightnessObserver(
    onInitialBrightness: (brightness) =>
        _themeBloc.start(systemThemeMode: _toUserTheme(brightness)),
    onBrightnessChanged: (brightness) =>
        _themeBloc.applySystemThemeMode(_toUserTheme(brightness)),
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) => widget.builder(
        context,
        _toThemeMode(themeState.appliedThemeMode ?? UserTheme.system),
        widget.child,
      ),
    ),
  );

  ThemeMode _toThemeMode(UserTheme mode) {
    switch (mode) {
      case UserTheme.system:
        return ThemeMode.system;
      case UserTheme.light:
        return ThemeMode.light;
      case UserTheme.dark:
        return ThemeMode.dark;
    }
  }
}
