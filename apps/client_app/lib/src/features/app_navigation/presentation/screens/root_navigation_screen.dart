import 'package:auto_route/auto_route.dart';
import 'package:client_app/src/common/config/router/client_app_router.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_profile/client_profile.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RootNavigationScreen extends StatelessWidget {
  const RootNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
    builder: (context, state) =>
        AutoRouter.declarative(routes: (_) => [_routeForState(state)]),
  );

  PageRouteInfo<dynamic> _routeForState(UserState state) {
    if (state.status.isInitial || state.status.isLoading) {
      return const SplashRoute();
    }

    final user = state.user;
    if (!state.status.isSuccess || user == null) {
      return const AuthWrapperRoute();
    }

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
}
