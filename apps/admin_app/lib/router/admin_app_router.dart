import 'package:admin_users/admin_users.dart';
import 'package:auto_route/auto_route.dart';

part 'admin_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [...AdminUsersRouter().routes];
}
