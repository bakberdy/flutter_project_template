import 'package:admin_users/src/features/users/presentation/screens/user_screen.dart';
import 'package:admin_users/src/features/users/presentation/screens/users_screen.dart';
import 'package:admin_users/src/common/config/admin_users_navigation_paths.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

part 'admin_users_router.gr.dart';

const adminUsersShellRoute = EmptyShellRoute('AdminUsersShellRoute');

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminUsersRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: adminUsersShellRoute.page,
      path: AdminUsersNavigationPaths.shell,
      children: [
        AutoRoute(
          page: UsersRoute.page,
          path: AdminUsersNavigationPaths.users,
          initial: true,
        ),
        AutoRoute(
          page: UserRoute.page,
          path: AdminUsersNavigationPaths.userDetails,
        ),
      ],
    ),
  ];
}
