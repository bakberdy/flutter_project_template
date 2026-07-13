import 'package:auto_route/auto_route.dart';
import 'package:client_auth/src/features/auth/presentation/screens/auth_email_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/auth_otp_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/auth_wrapper_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/user_blocked_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/user_deletion_requested_screen.dart';
import 'package:client_auth/src/features/sessions/presentation/screens/sessions_screen.dart';
import 'package:client_auth/src/features/users/presentation/screens/profile_tab_shell_screen.dart';
import 'package:client_auth/src/features/users/presentation/screens/user_data_registration_screen.dart';
import 'package:client_auth/src/features/users/presentation/screens/user_profile_edit_screen.dart';
import 'package:client_auth/src/features/users/presentation/screens/user_profile_screen.dart';
import 'package:client_auth/src/common/config/router/client_auth_navigation_paths.dart';

part 'client_auth_router.gr.dart';

const clientAuthShellRoute = EmptyShellRoute('ClientAuthShellRoute');

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientAuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: clientAuthShellRoute.page,
      path: ClientAuthNavigationPaths.shell,
      children: clientAuthRouter,
    ),
  ];
}

final List<AutoRoute> clientAuthRouter = [
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
  AutoRoute(
    page: UserDataRegistrationRoute.page,
    path: ClientAuthNavigationPaths.register,
  ),
  AutoRoute(
    page: UserBlockedRoute.page,
    path: ClientAuthNavigationPaths.blocked,
  ),
  AutoRoute(
    page: UserDeletionRequestedRoute.page,
    path: ClientAuthNavigationPaths.deletionRequested,
  ),
];
