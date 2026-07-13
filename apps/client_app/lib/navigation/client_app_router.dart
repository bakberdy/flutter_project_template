import 'package:auto_route/auto_route.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_preferences/client_preferences.dart';
import 'package:client_shell/client_shell.dart';

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
          page: MainNavigationRoute.page,
          path: 'home',
          children: [
            AutoRoute(
              page: ClientHomeRoute.page,
              path: '',
              initial: true,
              meta: {'showBottomNav': true},
            ),
            AutoRoute(
              page: ProfileTabShellRoute.page,
              path: 'profile',
              children: [
                AutoRoute(
                  page: UserProfileRoute.page,
                  path: '',
                  initial: true,
                  meta: {'showBottomNav': true},
                ),
                AutoRoute(page: UserProfileEditRoute.page, path: 'edit'),
                ...clientPreferencesRoutes,
                AutoRoute(page: SessionsRoute.page, path: 'devices'),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
}
