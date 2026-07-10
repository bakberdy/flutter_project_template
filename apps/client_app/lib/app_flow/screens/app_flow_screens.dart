import 'package:auto_route/auto_route.dart';
import 'package:client_app/navigation/client_app_router.dart';
import 'package:client_auth/client_auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ClientAppFlowScreen extends StatelessWidget {
  const ClientAppFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return AutoRouter.declarative(routes: (_) => _routesForState(state));
      },
    );
  }

  List<PageRouteInfo<dynamic>> _routesForState(UserState state) {
    if (state.status.isInitial || state.status.isLoading) {
      return const [SplashRoute()];
    }

    final user = state.user;
    if (!state.status.isSuccess || user == null) {
      return const [AuthWrapperRoute()];
    }

    return switch (user.status) {
      UserStatus.blocked => const [UserBlockedRoute()],
      UserStatus.deletionRequested ||
      UserStatus.deleted => const [UserDeletionRequestedRoute()],
      UserStatus.active =>
        user.isUserDataUploaded
            ? const [
                UserHomeRoute(children: [AuthorizedDashboardRoute()]),
              ]
            : const [UserDataRegistrationRoute()],
    };
  }
}

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}

@RoutePage()
class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Authorized zone'),
      actions: [
        IconButton(
          tooltip: 'Profile',
          onPressed: () => context.router.push(const ProfileTabShellRoute()),
          icon: const Icon(Icons.person_outline),
        ),
        IconButton(
          tooltip: 'Log out',
          onPressed: () => context.read<CoreNavigationBloc>().add(
            const CoreNavigationEvent.unAuthenticated(),
          ),
          icon: const Icon(Icons.logout),
        ),
      ],
    ),
    body: const AutoRouter(),
  );
}

@RoutePage()
class AuthorizedDashboardScreen extends StatelessWidget {
  const AuthorizedDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => _AuthorizedScaffold(
    title: 'Dashboard',
    description: 'This is the initial screen inside the authorized zone.',
    primaryLabel: 'Push details',
    onPrimaryPressed: () =>
        context.router.push(AuthorizedDetailsRoute(id: 'details-1')),
    secondaryLabel: 'Open settings',
    onSecondaryPressed: () =>
        context.router.push(const AuthorizedSettingsRoute()),
  );
}

@RoutePage()
class AuthorizedDetailsScreen extends StatelessWidget {
  const AuthorizedDetailsScreen({@PathParam('id') required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) => _AuthorizedScaffold(
    title: 'Details',
    description: 'Authorized details route id: $id',
    primaryLabel: 'Push next details',
    onPrimaryPressed: () =>
        context.router.push(AuthorizedDetailsRoute(id: 'details-2')),
    secondaryLabel: 'Replace with settings',
    onSecondaryPressed: () =>
        context.router.replace(const AuthorizedSettingsRoute()),
  );
}

@RoutePage()
class AuthorizedSettingsScreen extends StatelessWidget {
  const AuthorizedSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => _AuthorizedScaffold(
    title: 'Settings',
    description: 'This route is still inside the authorized zone.',
    primaryLabel: 'Pop',
    onPrimaryPressed: () => context.router.maybePop(),
    secondaryLabel: 'Log out',
    onSecondaryPressed: () => context.read<CoreNavigationBloc>().add(
      const CoreNavigationEvent.unAuthenticated(),
    ),
  );
}

class _AuthorizedScaffold extends StatelessWidget {
  const _AuthorizedScaffold({
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
  });

  final String title;
  final String description;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text(description),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onPrimaryPressed,
                child: Text(primaryLabel),
              ),
              if (secondaryLabel != null && onSecondaryPressed != null) ...[
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: onSecondaryPressed,
                  child: Text(secondaryLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
