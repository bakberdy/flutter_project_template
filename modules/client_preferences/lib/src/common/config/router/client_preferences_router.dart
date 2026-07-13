import 'package:auto_route/auto_route.dart';
import 'package:client_preferences/src/features/user_preferences/presentation/screens/user_preferences_appearance_screen.dart';
import 'package:client_preferences/src/features/user_preferences/presentation/screens/user_preferences_locale_screen.dart';
import 'package:client_preferences/src/features/user_preferences/presentation/screens/user_preferences_notifications_screen.dart';

import 'package:client_preferences/src/common/config/client_preferences_navigation_paths.dart';

part 'client_preferences_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientPreferencesRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => clientPreferencesRoutes;
}

final List<AutoRoute> clientPreferencesRoutes = [
  AutoRoute(
    page: UserPreferencesNotificationsRoute.page,
    path: ClientPreferencesNavigationPaths.notifications,
  ),
  AutoRoute(
    page: UserPreferencesAppearanceRoute.page,
    path: ClientPreferencesNavigationPaths.appearance,
  ),
  AutoRoute(
    page: UserPreferencesLocaleRoute.page,
    path: ClientPreferencesNavigationPaths.locale,
  ),
];
