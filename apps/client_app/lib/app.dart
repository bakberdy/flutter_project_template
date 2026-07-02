import 'package:client_app/localization/localization_consts.dart';
import 'package:client_app/router/client_app_router.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class App extends StatelessWidget {
  App({super.key, ClientAppRouter? appRouter})
    : _appRouter = appRouter ?? ClientAppRouter();

  final ClientAppRouter _appRouter;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    builder: (context, child) {
      if (AppConfig.instance.environment != 'production' || kDebugMode) {
        return Stack(
          children: [
            ?child,
            // Positioned(
            //   bottom: 20,
            //   right: 20,
            //   // child: LogViewerButton(navigatorKey: _appRouter.navigatorKey),
            // ),
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
