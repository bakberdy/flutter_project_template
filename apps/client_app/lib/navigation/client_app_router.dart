import 'package:auto_route/auto_route.dart';
import 'package:client_app/app_flow/screens/app_flow_screens.dart';
import 'package:client_auth/client_auth.dart';
import 'package:flutter/widgets.dart';

part 'client_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ClientAppFlowRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: SplashRoute.page, path: 'splash'),
        ...clientAuthRouter,
        AutoRoute(
          page: UserHomeRoute.page,
          path: 'home',
          children: [
            AutoRoute(
              page: AuthorizedDashboardRoute.page,
              path: '',
              initial: true,
            ),
            AutoRoute(page: AuthorizedDetailsRoute.page, path: 'details/:id'),
            AutoRoute(page: AuthorizedSettingsRoute.page, path: 'settings'),
            AutoRoute(
              page: ProfileTabShellRoute.page,
              path: 'profile',
              children: [
                AutoRoute(page: UserProfileRoute.page, path: '', initial: true),
                AutoRoute(page: UserProfileEditRoute.page, path: 'edit'),
                AutoRoute(
                  page: UserPreferencesNotificationsRoute.page,
                  path: 'notifications',
                ),
                AutoRoute(
                  page: UserPreferencesAppearanceRoute.page,
                  path: 'appearance',
                ),
                AutoRoute(
                  page: UserPreferencesLocaleRoute.page,
                  path: 'locale',
                ),
                AutoRoute(page: SessionsRoute.page, path: 'devices'),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
}
