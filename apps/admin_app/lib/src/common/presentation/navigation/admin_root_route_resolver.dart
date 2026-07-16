import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';

PageRouteInfo<dynamic> adminRouteForSessionState(AdminSessionState state) {
  final user = state.user;
  if (user != null) {
    return switch (user.status) {
      UserStatus.blocked => const UserBlockedRoute(),
      UserStatus.deletionRequested ||
      UserStatus.deleted => const UserDeletionRequestedRoute(),
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

  return const AdminAuthWrapperRoute();
}
