import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/screens/user_preferences_appearance_screen.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/screens/user_preferences_locale_screen.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/screens/user_preferences_notifications_screen.dart';

import 'package:admin_preferences/src/common/config/admin_preferences_navigation_paths.dart';

part 'admin_preferences_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminPreferencesRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => adminPreferencesRoutes;
}

final List<AutoRoute> adminPreferencesRoutes = [
  AutoRoute(
    page: UserPreferencesNotificationsRoute.page,
    path: AdminPreferencesNavigationPaths.notifications,
  ),
  AutoRoute(
    page: UserPreferencesAppearanceRoute.page,
    path: AdminPreferencesNavigationPaths.appearance,
  ),
  AutoRoute(
    page: UserPreferencesLocaleRoute.page,
    path: AdminPreferencesNavigationPaths.locale,
  ),
];
