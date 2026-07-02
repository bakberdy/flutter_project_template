import 'package:admin_users/src/features/users/presentation/screens/user_screen.dart';
import 'package:admin_users/src/features/users/presentation/screens/users_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

part 'admin_users_routes.gr.dart';

const adminUsersShellRoute = EmptyShellRoute('AdminUsersShellRoute');

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminUsersRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: adminUsersShellRoute.page,
      path: 'users',
      children: [
        AutoRoute(page: UsersRoute.page, path: '', initial: true),
        AutoRoute(page: UserRoute.page, path: ':userId'),
      ],
    ),
  ];
}
