import 'dart:async';

import 'package:admin_app/app/theme/app_theme_scope.dart';
import 'package:admin_app/src/common/config/localization/app_localization_config.dart';
import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_app/src/features/app_navigation/presentation/blocs/user/user_bloc.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ValueNotifier<bool> _showTalkerDock = ValueNotifier<bool>(true);
  late final CoreNavigationBloc _navigationBloc = sl<CoreNavigationBloc>();
  late final AdminAppRouter _appRouter = sl<AdminAppRouter>();
  late final UserBloc _userBloc = sl<UserBloc>()..add(const UserStartedEvent());

  @override
  void dispose() {
    _showTalkerDock.dispose();
    _navigationBloc.close();
    _userBloc.close();
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _navigationBloc),
      BlocProvider.value(value: _userBloc),
    ],
    child: AppThemeScope(
      builder: (context, themeMode, child) => CoreNavigationListener(
        onAuthenticated: () => _userBloc.add(const UserLoginEvent()),
        onUnauthenticated: () => _userBloc.add(const UserLogoutEvent()),
        onRefreshUser: () => _userBloc.add(const UserStartedEvent()),
        router: _appRouter,
        child: MaterialApp.router(
          builder: (context, child) => DebugOverlay(
            showTalkerDock: _showTalkerDock,
            onOpenTalker: () => _openTalker(context),
            bannerColor: context.designColors.primary,
            child: child ?? const SizedBox.shrink(),
          ),
          debugShowCheckedModeBanner: false,
          title: 'Admin Panel',
          routerConfig: _appRouter.config(
            includePrefixMatches: true,
            rebuildStackOnDeepLink: true,
            navigatorObservers: () => [
              TalkerRouteObserver(context.di<Talker>()),
            ],
          ),
          theme: DesignTheme.light(),
          darkTheme: DesignTheme.dark(),
          themeMode: themeMode,
          localizationsDelegates:
              AppLocalizationConfig.appLocalizationsDelegates,
          supportedLocales: AppLocalizationConfig.supportedLocales,
          localeResolutionCallback: _localeResolutionCallback,
        ),
      ),
    ),
  );

  Future<void> _openTalker(BuildContext context) async {
    _showTalkerDock.value = false;
    try {
      await _appRouter.navigatorKey.currentState?.push(
        MaterialPageRoute<void>(
          builder: (_) => TalkerScreen(talker: context.di<Talker>()),
          settings: const RouteSettings(name: 'TalkerScreen'),
        ),
      );
    } finally {
      _showTalkerDock.value = true;
    }
  }

  Locale _localeResolutionCallback(
    Locale? deviceLocale,
    Iterable<Locale> supportedLocales,
  ) {
    for (final locale in supportedLocales) {
      if (locale.languageCode == deviceLocale?.languageCode) {
        return locale;
      }
    }
    return AppLocalizationConfig.defaultLocale;
  }
}
