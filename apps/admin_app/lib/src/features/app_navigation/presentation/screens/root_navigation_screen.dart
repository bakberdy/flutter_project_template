import 'dart:async';

import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RootNavigationScreen extends StatelessWidget with UiFailureHandlerMixin {
  const RootNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<UserBloc, UserState>(
    listenWhen: (previous, current) =>
        previous.launchFailure == null && current.launchFailure != null,
    listener: (context, state) {
      unawaited(_handleLaunchFailure(context, state.launchFailure!));
    },
    builder: (context, state) =>
        AutoRouter.declarative(routes: (_) => [_routeForState(state)]),
  );

  Future<void> _handleLaunchFailure(
    BuildContext context,
    Failure failure,
  ) async {
    await handleFailure(failure, context);
    if (context.mounted) {
      context.read<UserBloc>().add(const UserLaunchFailureAcknowledgedEvent());
    }
  }

  PageRouteInfo<dynamic> _routeForState(UserState state) {
    if (state.status.isInitial || state.status.isLoading) {
      return const SplashRoute();
    }

    if (!state.status.isSuccess || !state.hasSession) {
      return const AdminAuthWrapperRoute();
    }

    final user = state.user;
    if (user == null) {
      return const MainNavigationRoute();
    }

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
}
