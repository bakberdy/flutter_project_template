import 'package:auto_route/auto_route.dart';
import 'package:client_profile/src/common/config/router/client_profile_navigation_paths.dart';
import 'package:client_profile/src/features/sessions/presentation/screens/sessions_screen.dart';
import 'package:client_profile/src/features/users/presentation/screens/profile_tab_shell_screen.dart';
import 'package:client_profile/src/features/users/presentation/screens/user_blocked_screen.dart';
import 'package:client_profile/src/features/users/presentation/screens/user_data_registration_screen.dart';
import 'package:client_profile/src/features/users/presentation/screens/user_deletion_requested_screen.dart';
import 'package:client_profile/src/features/users/presentation/screens/user_profile_edit_screen.dart';

part 'client_profile_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientProfileRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    ...clientProfileRootRoutes,
    ...clientProfileFeatureRoutes,
  ];
}

final List<AutoRoute> clientProfileRootRoutes = [
  AutoRoute(
    page: UserDataRegistrationRoute.page,
    path: ClientProfileNavigationPaths.register,
  ),
  AutoRoute(
    page: UserBlockedRoute.page,
    path: ClientProfileNavigationPaths.blocked,
  ),
  AutoRoute(
    page: UserDeletionRequestedRoute.page,
    path: ClientProfileNavigationPaths.deletionRequested,
  ),
];

final List<AutoRoute> clientProfileFeatureRoutes = [
  AutoRoute(
    page: ProfileTabShellRoute.page,
    path: ClientProfileNavigationPaths.profile,
    children: [
      AutoRoute(
        page: UserProfileEditRoute.page,
        path: ClientProfileNavigationPaths.profileEdit,
      ),
      AutoRoute(
        page: SessionsRoute.page,
        path: ClientProfileNavigationPaths.sessions,
      ),
    ],
  ),
];
