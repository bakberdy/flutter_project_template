import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_app/src/features/app_navigation/presentation/navigation/admin_root_route_resolver.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/auth_preferences_toggles.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RootNavigationScreen extends StatelessWidget {
  const RootNavigationScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<AdminSessionBloc, AdminSessionState>(
    listenWhen: (previous, current) =>
        !previous.accessDenied && current.accessDenied,
    listener: (context, state) {
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
          child: AutoRouter.declarative(
            routes: (_) => [adminRouteForSessionState(state)],
          ),
        ),
        if (state.user == null)
          if (state.status case ErrorStateStatus(:final failure))
            Positioned.fill(
              child: BaseRetryErrorView(
                title: context.l10n.sessionLoadFailureTitle,
                message:
                    failure.message ?? context.l10n.sessionLoadFailureMessage,
                retryLabel: context.l10n.retry,
                onRetry: () => context.read<AdminSessionBloc>().add(
                  const AdminSessionStarted(),
                ),
                icon: const Icon(Icons.cloud_off_outlined, size: 48),
              ),
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
}
