import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core_navigation_bloc.dart';

class CoreNavigationListener extends StatelessWidget {
  const CoreNavigationListener({
    required this.router,
    required this.child,
    super.key,
    this.onAuthenticated,
    this.onUnauthenticated,
    this.onRefreshUser,
  });

  final StackRouter router;
  final Widget child;

  final VoidCallback? onAuthenticated;
  final VoidCallback? onUnauthenticated;
  final VoidCallback? onRefreshUser;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoreNavigationBloc, CoreNavigationState>(
      listenWhen: (previous, current) =>
          previous.nextCommand?.id != current.nextCommand?.id,
      listener: _handleNavigation,
      child: child,
    );
  }

  Future<void> _handleNavigation(
    BuildContext context,
    CoreNavigationState state,
  ) async {
    final command = state.nextCommand;
    if (command == null) {
      return;
    }

    switch (command) {
      case PushNavigationCommand(:final route):
        unawaited(router.push(route));
      case ReplaceNavigationCommand(:final route):
        unawaited(router.popAndPush(route));
      case ReplaceAllNavigationCommand(:final routes):
        unawaited(router.replaceAll(routes));
      case PopNavigationCommand(:final result):
        await router.maybePopTop(result);
      case PopUntilNavigationCommand(:final route):
        router.popUntilRouteWithName(route.routeName, scoped: false);
      case OpenDeepLinkNavigationCommand(:final uri):
        unawaited(router.pushPath(uri.toString()));
      case UnAuthenticatedNavigationCommand():
        onUnauthenticated?.call();
      case RefreshUserNavigationCommand():
        onRefreshUser?.call();
      case AuthenticatedNavigationCommand():
        onAuthenticated?.call();
    }

    if (!context.mounted) {
      return;
    }
    context.read<CoreNavigationBloc>().add(
      CoreNavigationEvent.commandHandled(command.id),
    );
  }
}
