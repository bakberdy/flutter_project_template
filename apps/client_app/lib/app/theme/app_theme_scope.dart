import 'package:core/core.dart';
import 'package:client_preferences/client_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef AppThemeScopeBuilder =
    Widget Function(BuildContext context, ThemeMode themeMode, Widget? child);

class AppThemeScope extends StatelessWidget {
  final AppThemeScopeBuilder builder;
  final Widget? child;

  const AppThemeScope({required this.builder, this.child, super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => context.di<ThemeBloc>(),
    child: _AppThemeScopeBody(builder: builder, child: child),
  );
}

class _AppThemeScopeBody extends StatefulWidget {
  final AppThemeScopeBuilder builder;
  final Widget? child;

  const _AppThemeScopeBody({required this.builder, this.child});

  @override
  State<_AppThemeScopeBody> createState() => _AppThemeScopeBodyState();
}

class _AppThemeScopeBodyState extends State<_AppThemeScopeBody>
    with WidgetsBindingObserver {
  late final ThemeBloc _themeBloc;

  UserTheme _readSystemThemeMode() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark ? UserTheme.dark : UserTheme.light;
  }

  void _syncSystemThemeMode() {
    _themeBloc.applySystemThemeMode(_readSystemThemeMode());
  }

  @override
  void initState() {
    super.initState();
    _themeBloc = context.read<ThemeBloc>();
    WidgetsBinding.instance.addObserver(this);
    _themeBloc.start(systemThemeMode: _readSystemThemeMode());
  }

  @override
  void didChangePlatformBrightness() {
    _syncSystemThemeMode();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncSystemThemeMode();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, themeState) => widget.builder(
      context,
      _toThemeMode(themeState.appliedThemeMode ?? UserTheme.system),
      widget.child,
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
