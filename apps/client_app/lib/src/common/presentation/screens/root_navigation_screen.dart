import 'package:auto_route/auto_route.dart';
import 'package:client_app/src/common/client_app_localization_x.dart';
import 'package:client_app/src/common/presentation/navigation/client_root_route_resolver.dart';
import 'package:client_profile/client_profile.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

@RoutePage()
class RootNavigationScreen extends StatelessWidget {
  const RootNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
    builder: (context, state) => Stack(
      children: [
        Positioned.fill(
          child: AutoRouter.declarative(
            routes: (_) => [clientRouteForUserState(state)],
          ),
        ),
        if (state.user == null)
          if (state.status case ErrorStateStatus(:final failure))
            Positioned.fill(
              child: BaseRetryErrorView(
                title: context.l10n.sessionLoadFailureTitle,
                message: failure.messageTextOrDefault(context),
                retryLabel: context.l10n.retry,
                onRetry: () =>
                    context.read<UserBloc>().add(const UserEvent.refreshUser()),
                icon: const Icon(Icons.cloud_off_outlined, size: 48),
              ),
            ),
      ],
    ),
  );
}
