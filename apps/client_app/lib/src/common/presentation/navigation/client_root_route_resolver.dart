import 'package:auto_route/auto_route.dart';
import 'package:client_app/src/common/config/router/client_app_router.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_profile/client_profile.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';

PageRouteInfo<dynamic> clientRouteForUserState(UserState state) {
  final user = state.user;
  if (user != null) {
    return switch (user.status) {
      UserStatus.blocked => const UserBlockedRoute(),
      UserStatus.deletionRequested => UserDeletionRequestedRoute(),
      UserStatus.deleted => UserDeletionRequestedRoute(isDeleted: true),
      UserStatus.active =>
        user.isUserDataUploaded
            ? const MainNavigationRoute()
            : const UserDataRegistrationRoute(),
    };
  }

  if (state.status.isInitial ||
      state.status.isLoading ||
      state.status.isError) {
    return const SplashRoute();
  }

  return const AuthWrapperRoute();
}
