import 'dart:async';

import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/auth_preferences_toggles.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RootNavigationScreen extends StatelessWidget with UiFailureHandlerMixin {
  const RootNavigationScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<AdminSessionBloc, AdminSessionState>(
    listenWhen: (previous, current) =>
        (previous.launchFailure == null && current.launchFailure != null) ||
        (!previous.accessDenied && current.accessDenied),
    listener: (context, state) {
      final failure = state.launchFailure;
      if (failure != null) {
        unawaited(_handleLaunchFailure(context, failure));
        return;
      }
      if (state.accessDenied) {
        BaseSnackbar.error(context, message: context.l10n.adminAccessRequired);
        context.read<AdminSessionBloc>().add(
          const AdminSessionAccessDeniedAcknowledged(),
        );
      }
    },
    builder: (context, state) => Stack(
      children: [
        Positioned.fill(
          child: AutoRouter.declarative(routes: (_) => [_routeForState(state)]),
        ),
        if (state.status.isSuccess && !state.hasSession)
          const Positioned(
            top: DesignSpacing.lg,
            right: DesignSpacing.lg,
            child: AuthPreferencesToggles(),
          ),
      ],
    ),
  );

  Future<void> _handleLaunchFailure(
    BuildContext context,
    Failure failure,
  ) async {
    await handleFailure(failure, context);
    if (context.mounted) {
      context.read<AdminSessionBloc>().add(
        const AdminSessionFailureAcknowledged(),
      );
    }
  }

  PageRouteInfo<dynamic> _routeForState(AdminSessionState state) {
    if (state.status.isInitial || state.status.isLoading) {
      return const SplashRoute();
    }

    if (!state.status.isSuccess || !state.hasSession || state.user == null) {
      return const AdminAuthWrapperRoute();
    }

    final user = state.user!;

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
