import 'package:admin_auth/admin_auth.dart';
import 'package:admin_app/app/theme/app_theme_scope.dart';
import 'package:admin_app/src/common/config/localization/app_localization_config.dart';
import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/talker_dock_control.dart';
import 'package:admin_preferences/admin_preferences.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
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
  final ValueNotifier<bool> _dockRight = ValueNotifier<bool>(true);
  late final CoreNavigationBloc _navigationBloc = sl<CoreNavigationBloc>();
  late final AdminAppRouter _appRouter = sl<AdminAppRouter>();
  late final AdminSessionBloc _sessionBloc = sl<AdminSessionBloc>()
    ..add(const AdminSessionStarted());
  late final LocaleBloc _localeBloc = sl<LocaleBloc>()
    ..add(
      LocaleEvent.started(
        deviceLanguageCode:
            WidgetsBinding.instance.platformDispatcher.locale.languageCode,
      ),
    );

  @override
  void dispose() {
    _showTalkerDock.dispose();
    _dockRight.dispose();
    _navigationBloc.close();
    _sessionBloc.close();
    _localeBloc.close();
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _navigationBloc),
      BlocProvider.value(value: _sessionBloc),
      BlocProvider.value(value: _localeBloc),
    ],
    child: AppThemeScope(
      builder: (context, themeMode, child) =>
          BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, localeState) => CoreNavigationListener(
              onAuthenticated: _refreshUser,
              onUnauthenticated: _logout,
              onRefreshUser: _refreshUser,
              router: _appRouter,
              child: MaterialApp.router(
                builder: (context, child) {
                  final appConfig = context.di<CoreAppConfig>();
                  if (appConfig.environment == 'production' && !kDebugMode) {
                    return child ?? const SizedBox.shrink();
                  }
                  return Stack(
                    children: [
                      ?child,
                      ValueListenableBuilder<bool>(
                        valueListenable: _showTalkerDock,
                        builder: (context, showTalkerDock, _) {
                          if (!showTalkerDock) {
                            return const SizedBox.shrink();
                          }
                          return ValueListenableBuilder<bool>(
                            valueListenable: _dockRight,
                            builder: (context, dockRight, child) =>
                                TalkerDockControl(
                                  dockRight: dockRight,
                                  onSwapDockSide: () {
                                    _dockRight.value = !_dockRight.value;
                                  },
                                  openTalker: () => _openTalker(context),
                                ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Banner(
                          message: appConfig.environment,
                          location: BannerLocation.topEnd,
                          color: context.designColors.primary,
                        ),
                      ),
                    ],
                  );
                },
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
                locale: localeState.languageCode == null
                    ? null
                    : Locale(localeState.languageCode!),
                localeResolutionCallback: _localeResolutionCallback,
              ),
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

  void _refreshUser() {
    _sessionBloc.add(const AdminSessionStarted());
  }

  void _logout() {
    _sessionBloc.add(const AdminSessionLogoutRequested());
  }
}
