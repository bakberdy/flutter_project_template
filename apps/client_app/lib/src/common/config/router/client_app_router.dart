import 'package:auto_route/auto_route.dart';
import 'package:client_app/src/common/presentation/screens/client_home_screen.dart';
import 'package:client_app/src/common/presentation/screens/main_navigation_screen.dart';
import 'package:client_app/src/common/presentation/screens/root_navigation_screen.dart';
import 'package:client_app/src/common/presentation/screens/splash_screen.dart';
import 'package:client_app/src/common/presentation/screens/user_profile_screen.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_preferences/client_preferences.dart';
import 'package:client_profile/client_profile.dart';

part 'client_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootNavigationRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: SplashRoute.page, path: 'splash'),
        ...clientAuthRoutes,
        ...clientProfileRootRoutes,
        AutoRoute(
          page: MainNavigationRoute.page,
          path: 'home',
          children: [
            AutoRoute(
              page: ClientHomeRoute.page,
              path: '',
              initial: true,
              meta: const {'showBottomNav': true},
            ),
            AutoRoute(
              page: ProfileTabShellRoute.page,
              path: 'profile',
              children: [
                AutoRoute(
                  page: UserProfileRoute.page,
                  path: '',
                  initial: true,
                  meta: const {'showBottomNav': true},
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
