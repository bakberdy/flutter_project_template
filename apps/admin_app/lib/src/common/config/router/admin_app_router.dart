import 'package:admin_app/src/features/app_navigation/presentation/screens/admin_dashboard_screen.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/admin_auth_wrapper_screen.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/admin_sign_in_screen.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/admin_otp_screen.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/main_navigation_screen.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/root_navigation_screen.dart';
import 'package:admin_app/src/features/app_navigation/presentation/screens/splash_screen.dart';
import 'package:admin_users/admin_users.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:auto_route/auto_route.dart';

part 'admin_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootNavigationRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: SplashRoute.page, path: 'splash'),
        AutoRoute(
          page: AdminAuthWrapperRoute.page,
          path: 'sign-in',
          children: [
            AutoRoute(page: AdminSignInRoute.page, path: '', initial: true),
            AutoRoute(page: AdminOtpRoute.page, path: 'otp'),
          ],
        ),
        ...adminProfileRootRoutes,
        AutoRoute(
          page: MainNavigationRoute.page,
          path: 'home',
          children: [
            AutoRoute(page: AdminDashboardRoute.page, path: '', initial: true),
            ...AdminUsersRouter().routes,
          ],
        ),
      ],
    ),
  ];
}
