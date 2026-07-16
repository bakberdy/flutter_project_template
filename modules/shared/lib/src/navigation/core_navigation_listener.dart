import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoreNavigationListener extends StatelessWidget {
  const CoreNavigationListener({
    required this.router,
    required this.child,
    super.key,
    this.onAuthenticated,
    this.onLoggedOut,
    this.onRefreshUser,
    this.onNavigationError,
  });

  final StackRouter router;
  final Widget child;

  final VoidCallback? onAuthenticated;
  final VoidCallback? onLoggedOut;
  final VoidCallback? onRefreshUser;
  final void Function(Object error, StackTrace stackTrace)? onNavigationError;

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

    try {
      switch (command) {
        case PushNavigationCommand(:final route):
          _dispatch(router.push(route));
        case NavigatePathNavigationCommand(
          :final path,
          :final includePrefixMatches,
        ):
          _dispatch(
            router.navigatePath(
              path,
              includePrefixMatches: includePrefixMatches,
            ),
          );
        case ReplaceNavigationCommand(:final route):
          _dispatch(router.popAndPush(route));
        case ReplaceAllNavigationCommand(:final routes):
          _dispatch(router.replaceAll(routes));
        case PopNavigationCommand(:final result):
          await router.maybePopTop(result);
        case PopUntilNavigationCommand(:final route):
          router.popUntilRouteWithName(route.routeName, scoped: false);
        case OpenDeepLinkNavigationCommand(:final uri):
          _dispatch(router.pushPath(uri.toString()));
        case LoggedOutNavigationCommand():
          onLoggedOut?.call();
        case RefreshUserNavigationCommand():
          onRefreshUser?.call();
        case AuthenticatedNavigationCommand():
          onAuthenticated?.call();
      }
    } on Object catch (error, stackTrace) {
      onNavigationError?.call(error, stackTrace);
    }

    if (!context.mounted) {
      return;
    }
    context.read<CoreNavigationBloc>().add(
      CoreNavigationEvent.commandHandled(command.id),
    );
  }

  void _dispatch(Future<dynamic> operation) {
    unawaited(
      operation.then<void>((_) {}).onError((error, stackTrace) {
        if (error != null) {
          onNavigationError?.call(error, stackTrace);
        }
      }),
    );
  }
}
