import 'package:client_app/localization/localization_consts.dart';
import 'package:client_app/router/client_app_router.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class App extends StatefulWidget {
  App({super.key, ClientAppRouter? appRouter})
    : _appRouter = appRouter ?? ClientAppRouter();

  final ClientAppRouter _appRouter;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ValueNotifier<bool> _showTalkerDock = ValueNotifier<bool>(true);

  ClientAppRouter get _appRouter => widget._appRouter;

  @override
  void dispose() {
    _showTalkerDock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    builder: (context, child) {
      if (AppConfig.instance.environment != 'production' || kDebugMode) {
        return Stack(
          children: [
            ?child,
            ValueListenableBuilder<bool>(
              valueListenable: _showTalkerDock,
              builder: (context, showTalkerDock, _) {
                if (!showTalkerDock) return const SizedBox.shrink();

                return Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton.small(
                    onPressed: () => _onOpenTalker(context),
                    child: const Icon(Icons.bug_report_outlined),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.topRight,
              child: Banner(
                message: AppConfig.instance.environment,
                location: BannerLocation.topEnd,
                color: context.designColors.primary,
              ),
            ),
          ],
        );
      }
      return child ?? const SizedBox.shrink();
    },
    debugShowCheckedModeBanner: false,
    routerConfig: _appRouter.config(
      navigatorObservers: () => [TalkerRouteObserver(context.di<Talker>())],
    ),
    theme: DesignTheme.light(),
    darkTheme: DesignTheme.dark(),
    themeMode: ThemeMode.system,
    localizationsDelegates: LocalizationConsts.appLocalizationsDelegates,
    supportedLocales: LocalizationConsts.supportedLocales,
    localeResolutionCallback: _localeResolutionCallback,
  );

  Future<void> _onOpenTalker(BuildContext context) async {
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
