import 'package:client_auth/client_auth.dart';
import 'package:auto_route/auto_route.dart';

part 'client_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [...ClientAuthRouter().routes];
}
