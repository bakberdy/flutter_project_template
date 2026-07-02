import 'package:auto_route/auto_route.dart';

part 'admin_auth_routes.gr.dart';

const adminAuthShellRoute = EmptyShellRoute('AdminAuthShellRoute');

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminAuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: adminAuthShellRoute.page, path: 'auth'),
  ];
}
