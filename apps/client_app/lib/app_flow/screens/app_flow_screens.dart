import 'package:auto_route/auto_route.dart';
import 'package:client_app/app_flow/bloc/user_bloc.dart';
import 'package:client_app/navigation/client_app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ClientAppFlowScreen extends StatelessWidget {
  const ClientAppFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserBloc>().state;

    return AutoRouter.declarative(
      routes: (_) => [_routeForUserState(userState)],
    );
  }

  PageRouteInfo _routeForUserState(UserState state) {
    return switch (state) {
      UserInitial() => const UserInitialRoute(),
      UserLoggedOut() => const UserLoggedOutRoute(),
      UserLoggedIn(:final isOnboarded, :final isFilledProfile) =>
        !isOnboarded
            ? const UserOnboardingRoute()
            : !isFilledProfile
            ? const UserProfileRequiredRoute()
            : const UserHomeRoute(),
    };
  }
}

@RoutePage()
class UserInitialScreen extends StatelessWidget {
  const UserInitialScreen({super.key});

  @override
  Widget build(BuildContext context) => _UserStateScaffold(
    title: 'Initial',
    description: 'Startup checks are still pending.',
    primaryLabel: 'Finish startup',
    onPrimaryPressed: () => context.read<UserBloc>().add(UserLogoutEvent()),
  );
}

@RoutePage()
class UserLoggedOutScreen extends StatelessWidget {
  const UserLoggedOutScreen({super.key});

  @override
  Widget build(BuildContext context) => _UserStateScaffold(
    title: 'Logged out',
    description: 'The user must sign in before entering the app.',
    primaryLabel: 'Log in',
    onPrimaryPressed: () => context.read<UserBloc>().add(UserLoginEvent()),
  );
}

@RoutePage()
class UserOnboardingScreen extends StatelessWidget {
  const UserOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) => _UserStateScaffold(
    title: 'Onboarding required',
    description: 'The user is authenticated but has not completed onboarding.',
    primaryLabel: 'Complete onboarding',
    onPrimaryPressed: () => context.read<UserBloc>().add(UserOnboardedEvent()),
    secondaryLabel: 'Log out',
    onSecondaryPressed: () => context.read<UserBloc>().add(UserLogoutEvent()),
  );
}

@RoutePage()
class UserProfileRequiredScreen extends StatelessWidget {
  const UserProfileRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) => _UserStateScaffold(
    title: 'Profile required',
    description: 'The user must fill profile data before entering the app.',
    primaryLabel: 'Fill profile',
    onPrimaryPressed: () =>
        context.read<UserBloc>().add(UserProfileFilledEvent()),
    secondaryLabel: 'Log out',
    onSecondaryPressed: () => context.read<UserBloc>().add(UserLogoutEvent()),
  );
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
          tooltip: 'Log out',
          onPressed: () => context.read<UserBloc>().add(UserLogoutEvent()),
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
  Widget build(BuildContext context) => _UserStateScaffold(
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
  Widget build(BuildContext context) => _UserStateScaffold(
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
  Widget build(BuildContext context) => _UserStateScaffold(
    title: 'Settings',
    description: 'This route is still inside the authorized zone.',
    primaryLabel: 'Pop',
    onPrimaryPressed: () => context.router.maybePop(),
    secondaryLabel: 'Log out',
    onSecondaryPressed: () => context.read<UserBloc>().add(UserLogoutEvent()),
  );
}

class _UserStateScaffold extends StatelessWidget {
  const _UserStateScaffold({
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
    appBar: AppBar(title: Text(title)),
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
