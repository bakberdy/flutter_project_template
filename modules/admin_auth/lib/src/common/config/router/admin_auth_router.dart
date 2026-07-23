import 'package:admin_auth/src/common/config/constants/admin_auth_navigation_paths.dart';
import 'package:admin_auth/src/features/auth/presentation/screens/admin_auth_wrapper_screen.dart';
import 'package:admin_auth/src/features/auth/presentation/screens/admin_otp_screen.dart';
import 'package:admin_auth/src/features/auth/presentation/screens/admin_sign_in_screen.dart';
import 'package:auto_route/auto_route.dart';

part 'admin_auth_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminAuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => adminAuthRoutes;
}

final List<AutoRoute> adminAuthRoutes = [
  AutoRoute(
    page: AdminAuthWrapperRoute.page,
    path: AdminAuthNavigationPaths.signIn,
    children: [
      AutoRoute(
        page: AdminSignInRoute.page,
        path: AdminAuthNavigationPaths.email,
        initial: true,
      ),
      AutoRoute(page: AdminOtpRoute.page, path: AdminAuthNavigationPaths.otp),
    ],
  ),
];
