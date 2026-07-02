import 'package:auto_route/auto_route.dart';

part 'client_auth_routes.gr.dart';

const clientAuthShellRoute = EmptyShellRoute('ClientAuthShellRoute');

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientAuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: clientAuthShellRoute.page, path: '/auth'),
  ];
}
