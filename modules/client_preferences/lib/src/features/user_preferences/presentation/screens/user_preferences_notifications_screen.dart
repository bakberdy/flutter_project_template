import 'package:auto_route/auto_route.dart';
import 'package:client_preferences/src/common/presentation/extensions/client_preferences_context_x.dart';
import 'package:client_preferences/src/features/user_preferences/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:client_preferences/src/features/user_preferences/presentation/widgets/user_preferences_notification_switch_card.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

@RoutePage()
class UserPreferencesNotificationsScreen extends StatelessWidget
    with UiFailureHandlerMixin
    implements AutoRouteWrapper {
  const UserPreferencesNotificationsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.di<NotificationsBloc>()
            ..add(const NotificationsEvent.started()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsBloc, NotificationsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status case ErrorStateStatus(:final failure)) {
          await handleFailure(failure, context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.notificationsTitle)),
        body: SafeArea(
          child: BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              final preferences = state.preferences;
              return ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: DesignSpacingTokens.sm,
                ),
                children: [
                  UserPreferencesNotificationSwitchCard(
                    disableBottomRadius: true,
                    title: context.l10n.pushNotifications,
                    value: preferences?.pushNotificationsEnabled ?? true,
                    loading:
                        state.updatingType ==
                            UserPreferencesNotificationType.push &&
                        state.status.isLoading,
                    onChanged: (value) {
                      context.read<NotificationsBloc>().add(
                        NotificationsEvent.changed(
                          type: UserPreferencesNotificationType.push,
                          enabled: value,
                        ),
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    indent: DesignSpacingTokens.lg,
                    endIndent: DesignSpacingTokens.lg,
                  ),
                  UserPreferencesNotificationSwitchCard(
                    disableTopRadius: true,
                    disableBottomRadius: true,
                    title: context.l10n.emailNotifications,
                    value: preferences?.emailNotificationsEnabled ?? true,
                    loading:
                        state.updatingType ==
                            UserPreferencesNotificationType.email &&
                        state.status.isLoading,
                    onChanged: (value) {
                      context.read<NotificationsBloc>().add(
                        NotificationsEvent.changed(
                          type: UserPreferencesNotificationType.email,
                          enabled: value,
                        ),
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    indent: DesignSpacingTokens.lg,
                    endIndent: DesignSpacingTokens.lg,
                  ),
                  UserPreferencesNotificationSwitchCard(
                    disableTopRadius: true,
                    title: context.l10n.marketingNotifications,
                    value: preferences?.marketingNotificationsEnabled ?? false,
                    loading:
                        state.updatingType ==
                            UserPreferencesNotificationType.marketing &&
                        state.status.isLoading,
                    onChanged: (value) {
                      context.read<NotificationsBloc>().add(
                        NotificationsEvent.changed(
                          type: UserPreferencesNotificationType.marketing,
                          enabled: value,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
