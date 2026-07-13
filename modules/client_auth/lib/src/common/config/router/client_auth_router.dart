import 'package:auto_route/auto_route.dart';
import 'package:client_auth/src/features/auth/presentation/screens/auth_email_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/auth_otp_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/auth_wrapper_screen.dart';
import 'package:client_auth/src/common/config/client_auth_navigation_paths.dart';

part 'client_auth_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientAuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => clientAuthRoutes;
}

final List<AutoRoute> clientAuthRoutes = [
  AutoRoute(
    page: AuthWrapperRoute.page,
    path: ClientAuthNavigationPaths.auth,
    children: [
      AutoRoute(
        page: AuthEmailRoute.page,
        path: ClientAuthNavigationPaths.email,
        initial: true,
      ),
      AutoRoute(page: AuthOtpRoute.page, path: ClientAuthNavigationPaths.otp),
    ],
  ),
];
