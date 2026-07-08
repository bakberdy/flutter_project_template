import 'package:admin_app/app_flow/bloc/user_bloc.dart';
import 'package:admin_app/localization/localization_delegates.dart';
import 'package:admin_app/navigation/admin_app_router.dart';
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
  final CoreNavigationBloc _navigationBloc = CoreNavigationBloc();
  final UserBloc _userBloc = UserBloc(sl<LocalStorage>());
  final AdminAppRouter _appRouter = AdminAppRouter();

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
    child: CoreNavigationListener(
      router: _appRouter,
      child: MaterialApp.router(
        builder: (context, child) => DebugOverlay(
          showTalkerDock: _showTalkerDock,
          onOpenTalker: () => _onOpenTalker(context),
          bannerColor: context.designColors.primary,
          child: child ?? const SizedBox.shrink(),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(
          includePrefixMatches: true,
          rebuildStackOnDeepLink: true,
          navigatorObservers: () => [TalkerRouteObserver(sl())],
        ),
        theme: DesignTheme.light(),
        darkTheme: DesignTheme.dark(),
        themeMode: ThemeMode.system,
        localizationsDelegates: LocalizationConsts.appLocalizationsDelegates,
        supportedLocales: LocalizationConsts.supportedLocales,
        localeResolutionCallback: _localeResolutionCallback,
      ),
    ),
  );

  Future<void> _onOpenTalker(BuildContext context) async {
    _showTalkerDock.value = false;
    try {
      await _appRouter.navigatorKey.currentState?.push(
        MaterialPageRoute<void>(
          builder: (_) => TalkerScreen(talker: sl()),
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
