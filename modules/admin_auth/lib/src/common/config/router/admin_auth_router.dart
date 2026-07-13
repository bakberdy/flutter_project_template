import 'package:auto_route/auto_route.dart';
import 'package:admin_auth/src/common/config/router/admin_auth_navigation_paths.dart';

part 'admin_auth_router.gr.dart';

const adminAuthShellRoute = EmptyShellRoute('AdminAuthShellRoute');

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminAuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: adminAuthShellRoute.page,
      path: AdminAuthNavigationPaths.shell,
    ),
  ];
}
