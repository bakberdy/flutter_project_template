import 'package:admin_profile/src/common/admin_profile_context_x.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:admin_profile/src/features/sessions/presentation/widgets/session_list_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DevicesDialogView extends StatefulWidget {
  const DevicesDialogView({super.key});

  @override
  State<DevicesDialogView> createState() => _DevicesDialogViewState();
}

class _DevicesDialogViewState extends State<DevicesDialogView>
    with UiFailureHandlerMixin {
  late final SessionsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.di<SessionsBloc>()..add(const SessionsEvent.started());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _bloc,
    child: BlocConsumer<SessionsBloc, SessionsState>(
      listenWhen: (previous, current) =>
          previous.transientActionFailure == null &&
              current.transientActionFailure != null ||
          !previous.listStatus.isError &&
              current.listStatus.isError &&
              current.sessions.isNotEmpty ||
          !previous.navigateToAuthAfterRevokeAll &&
              current.navigateToAuthAfterRevokeAll,
      listener: _onSessionsStateChanged,
      builder: (context, state) {
        final sessions = state.sessions.where((s) => !s.isRevoked).toList();
        final isInitialLoading =
            state.listStatus.isLoading && state.sessions.isEmpty;
        final isInitialError =
            state.listStatus is ErrorStateStatus && state.sessions.isEmpty;

        return RefreshIndicator.adaptive(
          onRefresh: () => _refresh(context),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: DesignSpacing.md),
            itemCount: switch ((isInitialLoading, isInitialError)) {
              (true, _) || (_, true) => 1,
              _ => sessions.length + 1,
            },
            separatorBuilder: (_, _) => const Divider(
              endIndent: DesignSpacing.md,
              indent: DesignSpacing.md,
            ),
            itemBuilder: (context, index) {
              if (isInitialLoading) {
                return const Padding(
                  padding: EdgeInsets.only(top: DesignSpacing.xl),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (isInitialError) {
                return Padding(
                  padding: const EdgeInsets.only(top: DesignSpacing.xl),
                  child: BaseButton.secondary(
                    onPressed: () => context.read<SessionsBloc>().add(
                      const SessionsEvent.refreshed(),
                    ),
                    label: context.l10n.sessionsRetry,
                  ),
                );
              }
              if (sessions.isEmpty) {
                return BaseListTile(
                  margin: EdgeInsets.zero,
                  title: context.l10n.sessionsListEmptyTitle,
                );
              }
              if (index == sessions.length) {
                return BaseListTile(
                  margin: EdgeInsets.zero,
                  title: context.l10n.revokeAllSessions,
                  foregroundColor: context.designColors.error,
                  onTap: state.revokingAll
                      ? null
                      : () => _confirmRevokeAllSessions(context),
                  disableTopRadius: index != 0,
                );
              }

              final session = sessions[index];
              final formatted = DateFormat.yMMMd().add_jm().format(
                session.lastActive,
              );
              return SessionListItem(
                key: ValueKey(session.id),
                title: _sessionTitle(session),
                subtitle: context.l10n.sessionsSessionLastActive(formatted),
                onRevoke: state.revokingAll || state.revokingSessionId != null
                    ? null
                    : () => _confirmRevokeSession(context, session.id),
                disableTopRadius: index != 0,
                disableBottomRadius: index != sessions.length,
              );
            },
          ),
        );
      },
    ),
  );

  Future<void> _onSessionsStateChanged(
    BuildContext context,
    SessionsState state,
  ) async {
    final transient = state.transientActionFailure;
    if (transient != null) {
      final bloc = context.read<SessionsBloc>();
      await handleFailure(transient, context);
      bloc.add(const SessionsEvent.transientFailureAcknowledged());
      return;
    }

    if (state.navigateToAuthAfterRevokeAll) {
      context.router.markUrlStateForReplace();
      Navigator.of(context).pop();
      context.read<CoreNavigationBloc>().add(
        const CoreNavigationEvent.unAuthenticated(),
      );
      return;
    }

    if (state.listStatus case ErrorStateStatus(:final failure)) {
      await handleFailure(failure, context);
    }
  }

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<SessionsBloc>()
      ..add(const SessionsEvent.refreshed());
    await bloc.stream.firstWhere((state) => !state.listStatus.isLoading);
  }

  Future<void> _confirmRevokeSession(BuildContext context, String sessionId) =>
      BaseDialog.show<void>(
        context,
        title: context.l10n.revokeSessionDialogTitle,
        description: context.l10n.revokeSessionDialogMessage,
        primaryLabel: context.l10n.revokeSession,
        secondaryLabel: context.l10n.dismiss,
        onPrimary: () =>
            _bloc.add(SessionsEvent.sessionRevokeRequested(sessionId)),
        primaryFirst: true,
      );

  Future<void> _confirmRevokeAllSessions(BuildContext context) =>
      BaseDialog.show<void>(
        context,
        title: context.l10n.revokeAllSessionsDialogTitle,
        description: context.l10n.revokeAllSessionsDialogMessage,
        primaryLabel: context.l10n.revokeAllSessions,
        secondaryLabel: context.l10n.dismiss,
        onPrimary: () => _bloc.add(const SessionsEvent.revokeAllRequested()),
        primaryFirst: true,
      );

  String _sessionTitle(Session session) {
    final device = session.device;
    return '${device.model} - ${device.os} ${device.osVersion}';
  }
}
