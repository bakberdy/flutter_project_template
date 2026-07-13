import 'package:client_app/localization/localization_consts.dart';
import 'package:client_app/src/common/config/router/client_app_router.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_preferences/client_preferences.dart';
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
  late final ClientAppRouter _appRouter = sl<ClientAppRouter>();
  late final UserBloc _userBloc = sl<UserBloc>()..add(const UserStartedEvent());
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
    _navigationBloc.close();
    _userBloc.close();
    _localeBloc.close();
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _navigationBloc),
      BlocProvider.value(value: _userBloc),
      BlocProvider.value(value: _localeBloc),
    ],
    child: AppThemeScope(
      builder: (context, themeMode, child) =>
          BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, localeState) => CoreNavigationListener(
              onAuthenticated: () {
                _userBloc.add(const UserStartedEvent());
              },
              onUnauthenticated: () {
                _navigationBloc.add(
                  CoreNavigationEvent.replaceAll([AuthWrapperRoute()]),
                );
              },
              onRefreshUser: () {
                _userBloc.add(const UserStartedEvent());
              },
              router: _appRouter,
              child: MaterialApp.router(
                builder: (context, child) => DebugOverlay(
                  showTalkerDock: _showTalkerDock,
                  onOpenTalker: () => _openTalker(context),
                  bannerColor: context.designColors.primary,
                  child: child ?? const SizedBox.shrink(),
                ),
                debugShowCheckedModeBanner: false,
                routerConfig: _appRouter.config(
                  navigatorObservers: () => [
                    TalkerRouteObserver(context.di<Talker>()),
                  ],
                ),
                theme: DesignTheme.light(),
                darkTheme: DesignTheme.dark(),
                themeMode: themeMode,
                localizationsDelegates:
                    LocalizationConsts.appLocalizationsDelegates,
                supportedLocales: LocalizationConsts.supportedLocales,
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
    return LocalizationConsts.defaultLocale;
  }
}
