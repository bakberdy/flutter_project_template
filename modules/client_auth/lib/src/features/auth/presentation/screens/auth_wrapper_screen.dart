import 'package:auto_route/auto_route.dart';
import 'package:client_auth/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

@RoutePage()
class AuthWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const AuthWrapperScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => context.di<AuthBloc>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current.status.isSuccess &&
          current.step == AuthStep.success &&
          (!previous.status.isSuccess || previous.step != AuthStep.success),
      listener: (context, state) {
        context.read<CoreNavigationBloc>().add(
          const CoreNavigationEvent.authenticated(),
        );
      },
      child: const AutoRouter(),
    );
  }
}
