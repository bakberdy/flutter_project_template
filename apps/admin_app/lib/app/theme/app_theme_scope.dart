import 'package:admin_preferences/admin_preferences.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef AppThemeScopeBuilder =
    Widget Function(BuildContext context, ThemeMode themeMode, Widget? child);

class AppThemeScope extends StatelessWidget {
  const AppThemeScope({required this.builder, this.child, super.key});

  final AppThemeScopeBuilder builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => BlocProvider(
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

class _AppThemeScopeBodyState extends State<_AppThemeScopeBody>
    with WidgetsBindingObserver {
  late final ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = context.read<ThemeBloc>();
    WidgetsBinding.instance.addObserver(this);
    _themeBloc.start(systemThemeMode: _systemTheme);
  }

  @override
  void didChangePlatformBrightness() =>
      _themeBloc.applySystemThemeMode(_systemTheme);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _themeBloc.applySystemThemeMode(_systemTheme);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  UserTheme get _systemTheme =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark
      ? UserTheme.dark
      : UserTheme.light;

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => widget.builder(
      context,
      switch (state.appliedThemeMode ?? UserTheme.system) {
        UserTheme.system => ThemeMode.system,
        UserTheme.light => ThemeMode.light,
        UserTheme.dark => ThemeMode.dark,
      },
      widget.child,
    ),
  );
}
