import 'package:admin_app/app_flow/screens/app_flow_screens.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

part 'admin_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AdminAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AdminAppFlowRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: UserInitialRoute.page, path: 'initial'),
        AutoRoute(page: UserLoggedOutRoute.page, path: 'logged-out'),
        AutoRoute(page: UserOnboardingRoute.page, path: 'onboarding'),
        AutoRoute(page: UserProfileRequiredRoute.page, path: 'profile'),
        AutoRoute(
          page: UserHomeRoute.page,
          path: 'home',
          children: [
            AutoRoute(
              page: AuthorizedDashboardRoute.page,
              path: '',
              initial: true,
            ),
            AutoRoute(page: AuthorizedDetailsRoute.page, path: 'details/:id'),
            AutoRoute(page: AuthorizedSettingsRoute.page, path: 'settings'),
          ],
        ),
      ],
    ),
  ];
}
