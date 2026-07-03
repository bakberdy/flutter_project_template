import 'package:client_app/sample_navigation/sample_navigation_screens.dart';
import 'package:client_auth/client_auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

part 'client_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SampleHomeRoute.page, path: '/', initial: true),
    AutoRoute(page: SamplePushRoute.page, path: '/push/:id'),
    AutoRoute(page: SampleResultPickerRoute.page, path: '/result-picker'),
    AutoRoute(
      page: SampleShellRoute.page,
      path: '/shell',
      children: [
        AutoRoute(page: SampleShellHomeRoute.page, path: '', initial: true),
        AutoRoute(page: SampleShellDetailsRoute.page, path: 'details/:id'),
      ],
    ),
    AutoRoute(
      page: SampleTabsRoute.page,
      path: '/tabs',
      children: [
        AutoRoute(
          page: SampleTabOneShellRoute.page,
          path: 'one',
          initial: true,
          children: [
            AutoRoute(
              page: SampleTabOneHomeRoute.page,
              path: '',
              initial: true,
            ),
            AutoRoute(page: SampleTabOneDetailsRoute.page, path: 'details/:id'),
          ],
        ),
        AutoRoute(page: SampleTabTwoRoute.page, path: 'two'),
      ],
    ),
    ...ClientAuthRouter().routes,
  ];
}
