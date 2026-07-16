import 'package:admin_preferences/src/common/admin_preferences_context_x.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/widgets/user_preferences_notification_switch_card.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsDialogView extends StatefulWidget {
  const NotificationsDialogView({super.key});

  @override
  State<NotificationsDialogView> createState() =>
      _NotificationsDialogViewState();
}

class _NotificationsDialogViewState extends State<NotificationsDialogView>
    with UiFailureHandlerMixin {
  late final NotificationsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.di<NotificationsBloc>()..start();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _bloc,
    child: BlocListener<NotificationsBloc, NotificationsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status case ErrorStateStatus(:final failure)) {
          await handleFailure(failure, context);
        }
      },
      child: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          final preferences = state.preferences;
          return ListView(
            padding: EdgeInsets.symmetric(vertical: context.designSpacing.sm),
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
              Divider(
                height: 1,
                indent: context.designSpacing.lg,
                endIndent: context.designSpacing.lg,
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
              Divider(
                height: 1,
                indent: context.designSpacing.lg,
                endIndent: context.designSpacing.lg,
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
  );
}
