import 'package:auto_route/auto_route.dart';
import 'package:client_auth/src/features/auth/presentation/screens/auth_email_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/auth_otp_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/auth_wrapper_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/user_blocked_screen.dart';
import 'package:client_auth/src/features/auth/presentation/screens/user_deletion_requested_screen.dart';
import 'package:client_auth/src/features/sessions/presentation/screens/sessions_screen.dart';
import 'package:client_auth/src/features/users/presentation/screens/profile_tab_shell_screen.dart';
import 'package:client_auth/src/features/users/presentation/screens/user_data_registration_screen.dart';
import 'package:client_auth/src/features/users/presentation/screens/user_preferences_placeholder_screens.dart';
import 'package:client_auth/src/features/users/presentation/screens/user_profile_edit_screen.dart';
import 'package:client_auth/src/features/users/presentation/screens/user_profile_screen.dart';

part 'client_auth_routes.gr.dart';

const clientAuthShellRoute = EmptyShellRoute('ClientAuthShellRoute');

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientAuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: clientAuthShellRoute.page,
      path: '/client-auth',
      children: clientAuthRoutes,
    ),
  ];
}

final List<AutoRoute> clientAuthRoutes = [
  AutoRoute(
    page: AuthWrapperRoute.page,
    path: 'auth',
    children: [
      AutoRoute(page: AuthEmailRoute.page, path: 'email', initial: true),
      AutoRoute(page: AuthOtpRoute.page, path: 'otp'),
    ],
  ),
  AutoRoute(page: UserDataRegistrationRoute.page, path: 'register'),
  AutoRoute(page: UserBlockedRoute.page, path: 'blocked'),
  AutoRoute(page: UserDeletionRequestedRoute.page, path: 'deletion-requested'),
  AutoRoute(
    page: ProfileTabShellRoute.page,
    path: 'profile',
    children: [
      AutoRoute(page: UserProfileRoute.page, path: '', initial: true),
      AutoRoute(page: UserProfileEditRoute.page, path: 'edit'),
      AutoRoute(
        page: UserPreferencesNotificationsRoute.page,
        path: 'notifications',
      ),
      AutoRoute(page: UserPreferencesAppearanceRoute.page, path: 'appearance'),
      AutoRoute(page: UserPreferencesLocaleRoute.page, path: 'locale'),
      AutoRoute(page: SessionsRoute.page, path: 'devices'),
    ],
  ),
];
