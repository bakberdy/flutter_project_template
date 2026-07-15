import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/presentation/blocs/user/user_bloc.dart';
import 'package:admin_users/src/features/users/presentation/widgets/user_details_view.dart';
import 'package:admin_users/src/common/admin_users_context_x.dart';

@RoutePage()
class UserScreen extends StatefulWidget implements AutoRouteWrapper {
  const UserScreen({@PathParam('userId') required this.userId, super.key});

  final String userId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create: (context) => sl<UserBloc>()..add(UserEvent.started(userId)),
    child: this,
  );

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: _onStateChanged,
        builder: (context, state) {
          final failure = switch (state.status) {
            ErrorStateStatus(:final failure) => failure,
            _ => null,
          };
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    BackButton(
                      onPressed: () => context.read<CoreNavigationBloc>().add(
                        const CoreNavigationEvent.pop(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        state.user?.email ?? l10n.userTitle,
                        style: context.designTextTheme.headlineMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.usersRefresh,
                      onPressed: state.status.isLoading
                          ? null
                          : () => context.read<UserBloc>().add(
                              UserEvent.started(widget.userId),
                            ),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              if (state.status.isLoading) const LinearProgressIndicator(),
              if (!state.status.isLoading)
                const SizedBox(height: AppSpacing.xxs),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: switch ((state.user, failure)) {
                    (_, final Failure error) => Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(error.messageTextOrDefault(context)),
                          const SizedBox(height: AppSpacing.md),
                          BaseButton.secondary(
                            onPressed: () => context.read<UserBloc>().add(
                              UserEvent.started(widget.userId),
                            ),
                            label: l10n.usersRetry,
                          ),
                        ],
                      ),
                    ),
                    (final AdminUser user, _) => UserDetailsView(
                      user: user,
                      profile: state.profile,
                      actionLoading: state.actionStatus.isLoading,
                      onApproveDeletionRequest: () {
                        context.read<UserBloc>().add(
                          UserEvent.deletionApproved(user.id),
                        );
                      },
                      onBlockUser: () {
                        context.read<UserBloc>().add(
                          UserEvent.blocked(user.id),
                        );
                      },
                      onUnblockUser: () {
                        context.read<UserBloc>().add(
                          UserEvent.unblocked(user.id),
                        );
                      },
                    ),
                    _ => const Center(child: CircularProgressIndicator()),
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _onStateChanged(BuildContext context, UserState state) async {
    final failure = switch (state.actionStatus) {
      ErrorStateStatus(:final failure) => failure,
      _ => null,
    };
    if (failure == null) {
      return;
    }
    if (!context.mounted) {
      return;
    }
    BaseSnackbar.error(context, message: failure.messageTextOrDefault(context));
  }
}
