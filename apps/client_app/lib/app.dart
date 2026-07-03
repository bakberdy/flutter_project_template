import 'package:auto_route/auto_route.dart';
import 'package:client_app/localization/localization_consts.dart';
import 'package:client_app/router/client_app_router.dart';
import 'package:client_app/sample_navigation/sample_navigation_routes.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

class App extends StatefulWidget {
  App({super.key, ClientAppRouter? appRouter, this.navigationBloc})
    : _appRouter = appRouter ?? ClientAppRouter();

  final ClientAppRouter _appRouter;
  final CoreNavigationBloc? navigationBloc;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ValueNotifier<bool> _showTalkerDock = ValueNotifier<bool>(true);
  late final CoreNavigationBloc _navigationBloc =
      widget.navigationBloc ?? CoreNavigationBloc();

  ClientAppRouter get _appRouter => widget._appRouter;

  @override
  void dispose() {
    _showTalkerDock.dispose();
    if (widget.navigationBloc == null) {
      _navigationBloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _navigationBloc,
    child: BlocListener<CoreNavigationBloc, CoreNavigationState>(
      listenWhen: (previous, current) =>
          previous.nextCommand?.id != current.nextCommand?.id,
      listener: _handleNavigation,
      child: MaterialApp.router(
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
      ),
    ),
  );

  Future<void> _handleNavigation(
    BuildContext context,
    CoreNavigationState state,
  ) async {
    final command = state.nextCommand;
    if (command == null) {
      return;
    }

    switch (command) {
      case PushNavigationCommand(:final route):
        await _appRouter.push(_toAutoRoute(route));
      case ReplaceNavigationCommand(:final route):
        await _appRouter.replace(_toAutoRoute(route));
      case ReplaceAllNavigationCommand(:final routes):
        await _appRouter.replaceAll(routes.map(_toAutoRoute).toList());
      case PopNavigationCommand(:final result):
        await _appRouter.maybePop(result);
      case PopUntilNavigationCommand(:final match):
        _appRouter.popUntil((route) {
          final coreRoute = _fromAutoRouteName(route.settings.name);
          return coreRoute != null && match.matches(coreRoute);
        });
      case OpenDeepLinkNavigationCommand(:final uri):
        await _appRouter.pushPath(uri.toString());
    }

    if (!context.mounted) {
      return;
    }
    context.read<CoreNavigationBloc>().add(
      CoreNavigationEvent.commandHandled(command.id),
    );
  }

  PageRouteInfo<void> _toAutoRoute(CoreNavigationRoute route) =>
      switch (route.name) {
        SampleNavigationRoutes.home => const SampleHomeRoute(),
        SampleNavigationRoutes.push => SamplePushRoute(
          id: route.pathParameters['id']!,
        ),
        SampleNavigationRoutes.resultPicker => const SampleResultPickerRoute(),
        SampleNavigationRoutes.shell => const SampleShellRoute(),
        SampleNavigationRoutes.shellDetails => SampleShellRoute(
          children: [SampleShellDetailsRoute(id: route.pathParameters['id']!)],
        ),
        SampleNavigationRoutes.tabs => const SampleTabsRoute(),
        SampleNavigationRoutes.tabOneDetails => SampleTabsRoute(
          children: [
            SampleTabOneShellRoute(
              children: [
                SampleTabOneDetailsRoute(id: route.pathParameters['id']!),
              ],
            ),
          ],
        ),
        _ => throw UnsupportedError('Unknown client route: ${route.name}'),
      };

  CoreNavigationRoute? _fromAutoRouteName(String? name) => switch (name) {
    SampleHomeRoute.name => const CoreNavigationRoute(
      name: SampleNavigationRoutes.home,
    ),
    SamplePushRoute.name => const CoreNavigationRoute(
      name: SampleNavigationRoutes.push,
    ),
    SampleResultPickerRoute.name => const CoreNavigationRoute(
      name: SampleNavigationRoutes.resultPicker,
    ),
    SampleShellRoute.name => const CoreNavigationRoute(
      name: SampleNavigationRoutes.shell,
    ),
    SampleShellDetailsRoute.name => const CoreNavigationRoute(
      name: SampleNavigationRoutes.shellDetails,
    ),
    SampleTabsRoute.name => const CoreNavigationRoute(
      name: SampleNavigationRoutes.tabs,
    ),
    SampleTabOneDetailsRoute.name => const CoreNavigationRoute(
      name: SampleNavigationRoutes.tabOneDetails,
    ),
    _ => null,
  };

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
