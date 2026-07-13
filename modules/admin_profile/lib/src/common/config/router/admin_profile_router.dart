import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:admin_profile/src/common/config/admin_profile_navigation_paths.dart';
import 'package:admin_profile/src/features/account_status/presentation/screens/user_blocked_screen.dart';
import 'package:admin_profile/src/features/account_status/presentation/screens/user_deletion_requested_screen.dart';
import 'package:admin_profile/src/features/sessions/presentation/screens/sessions_screen.dart';
import 'package:admin_profile/src/features/profile/presentation/screens/profile_tab_shell_screen.dart';
import 'package:admin_profile/src/features/profile/presentation/screens/user_data_registration_screen.dart';
import 'package:admin_profile/src/features/profile/presentation/screens/user_profile_edit_screen.dart';

part 'admin_profile_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminProfileRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    ...adminProfileRootRoutes,
    ...adminProfileFeatureRoutes,
  ];
}

final List<AutoRoute> adminProfileRootRoutes = [
  AutoRoute(
    page: UserDataRegistrationRoute.page,
    path: AdminProfileNavigationPaths.register,
  ),
  AutoRoute(
    page: UserBlockedRoute.page,
    path: AdminProfileNavigationPaths.blocked,
  ),
  AutoRoute(
    page: UserDeletionRequestedRoute.page,
    path: AdminProfileNavigationPaths.deletionRequested,
  ),
];

final List<AutoRoute> adminProfileFeatureRoutes = [
  AutoRoute(
    page: ProfileTabShellRoute.page,
    path: AdminProfileNavigationPaths.profile,
    children: [
      AutoRoute(
        page: UserProfileEditRoute.page,
        path: AdminProfileNavigationPaths.profileEdit,
      ),
      AutoRoute(
        page: SessionsRoute.page,
        path: AdminProfileNavigationPaths.sessions,
      ),
    ],
  ),
];
