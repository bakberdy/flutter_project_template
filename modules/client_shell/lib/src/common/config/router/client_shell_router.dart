import 'package:auto_route/auto_route.dart';
import 'package:client_shell/src/features/main_navigation/presentation/screens/client_home_screen.dart';
import 'package:client_shell/src/features/main_navigation/presentation/screens/main_navigation_screen.dart';

part 'client_shell_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientShellRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => const [];
}
