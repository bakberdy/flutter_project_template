import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:core/core.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:client_auth/src/features/sessions/domain/entities/session.dart';
import 'package:client_auth/src/features/sessions/presentation/blocs/sessions/sessions_bloc.dart';
import 'package:client_auth/src/features/sessions/presentation/widgets/session_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage()
class SessionsScreen extends StatelessWidget
    with UiFailureHandlerMixin
    implements AutoRouteWrapper {
  const SessionsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.di<SessionsBloc>()..add(const SessionsEvent.started()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionsBloc, SessionsState>(
      listenWhen: (previous, current) {
        return previous.transientActionFailure == null &&
                current.transientActionFailure != null ||
            !previous.listStatus.isError &&
                current.listStatus.isError &&
                current.sessions.isNotEmpty ||
            !previous.navigateToAuthAfterRevokeAll &&
                current.navigateToAuthAfterRevokeAll;
      },
      listener: _onSessionsStateChanged,
      builder: (context, state) {
        final sessions = state.sessions.where((s) => !s.isRevoked).toList();
        final isInitialLoading =
            state.listStatus.isLoading && state.sessions.isEmpty;
        final isInitialError =
            state.listStatus is ErrorStateStatus && state.sessions.isEmpty;

        return Scaffold(
          appBar: AppBar(
            title: Text(ClientAuthLocalizations.of(context).sessionsTitle),
          ),
          body: RefreshIndicator.adaptive(
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
                      label: ClientAuthLocalizations.of(context).sessionsRetry,
                    ),
                  );
                }
                if (sessions.isEmpty) {
                  return AppItemCard(
                    margin: EdgeInsets.zero,
                    title: ClientAuthLocalizations.of(
                      context,
                    ).sessionsListEmptyTitle,
                  );
                }
                if (index == sessions.length) {
                  return AppItemCard(
                    margin: EdgeInsets.zero,
                    title: ClientAuthLocalizations.of(
                      context,
                    ).revokeAllSessions,
                    foregroundColor: context.colorScheme.error,
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
                  subtitle: ClientAuthLocalizations.of(
                    context,
                  ).sessionsSessionLastActive(formatted),
                  onRevoke: state.revokingAll || state.revokingSessionId != null
                      ? null
                      : () => _confirmRevokeSession(context, session.id),
                  disableTopRadius: index != 0,
                  disableBottomRadius: index != sessions.length,
                );
              },
            ),
          ),
        );
      },
    );
  }

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

  Future<void> _confirmRevokeSession(
    BuildContext context,
    String sessionId,
  ) async {
    final bloc = context.read<SessionsBloc>();
    await BaseDialog.show<void>(
      context,
      title: ClientAuthLocalizations.of(context).revokeSessionDialogTitle,
      description: ClientAuthLocalizations.of(
        context,
      ).revokeSessionDialogMessage,
      primaryLabel: ClientAuthLocalizations.of(context).revokeSession,
      secondaryLabel: ClientAuthLocalizations.of(context).dismiss,
      onPrimary: () =>
          bloc.add(SessionsEvent.sessionRevokeRequested(sessionId)),
      primaryFirst: true,
    );
  }

  Future<void> _confirmRevokeAllSessions(BuildContext context) async {
    final bloc = context.read<SessionsBloc>();
    await BaseDialog.show<void>(
      context,
      title: ClientAuthLocalizations.of(context).revokeAllSessionsDialogTitle,
      description: ClientAuthLocalizations.of(
        context,
      ).revokeAllSessionsDialogMessage,
      primaryLabel: ClientAuthLocalizations.of(context).revokeAllSessions,
      secondaryLabel: ClientAuthLocalizations.of(context).dismiss,
      onPrimary: () => bloc.add(const SessionsEvent.revokeAllRequested()),
      primaryFirst: true,
    );
  }

  String _sessionTitle(Session session) {
    final device = session.device;
    return '${device.model} - ${device.os} ${device.osVersion}';
  }
}
