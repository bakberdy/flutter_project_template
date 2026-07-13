import 'package:auto_route/auto_route.dart';
import 'package:admin_preferences/src/common/admin_preferences_context_x.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/widgets/user_preferences_notification_switch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserPreferencesNotificationsScreen extends StatelessWidget
    with UiFailureHandlerMixin
    implements AutoRouteWrapper {
  const UserPreferencesNotificationsScreen({super.key, this.showAppBar = true});

  final bool showAppBar;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => context.di<NotificationsBloc>()..start(),
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
        appBar: showAppBar
            ? AppBar(title: Text(context.l10n.notificationsTitle))
            : null,
        body: SafeArea(
          child: BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              final preferences = state.preferences;
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: DesignSpacing.sm),
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
                      context.read<NotificationsBloc>().setNotification(
                        UserPreferencesNotificationType.push,
                        value,
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    indent: DesignSpacing.lg,
                    endIndent: DesignSpacing.lg,
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
                      context.read<NotificationsBloc>().setNotification(
                        UserPreferencesNotificationType.email,
                        value,
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    indent: DesignSpacing.lg,
                    endIndent: DesignSpacing.lg,
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
                      context.read<NotificationsBloc>().setNotification(
                        UserPreferencesNotificationType.marketing,
                        value,
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
