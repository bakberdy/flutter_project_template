import 'package:admin_app/src/common/config/router/admin_app_navigation_paths.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/admin_dashboard_screen.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/main_navigation_screen.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/root_navigation_screen.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/splash_screen.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:admin_users/admin_users.dart';
import 'package:auto_route/auto_route.dart';

part 'admin_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootNavigationRoute.page,
      path: AdminAppNavigationPaths.root,
      initial: true,
      children: [
        AutoRoute(
          page: SplashRoute.page,
          path: AdminAppNavigationPaths.splashSegment,
        ),
        ...adminAuthRoutes,
        ...adminProfileRootRoutes,
        AutoRoute(
          page: MainNavigationRoute.page,
          path: AdminAppNavigationPaths.homeSegment,
          children: [
            AutoRoute(
              page: AdminDashboardRoute.page,
              path: AdminAppNavigationPaths.dashboardSegment,
              initial: true,
            ),
            ...adminUsersRoutes,
          ],
        ),
      ],
    ),
  ];
}
