import 'package:auto_route/auto_route.dart';
import 'package:client_profile/src/features/users/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileTabShellScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const ProfileTabShellScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.di<UserProfileBloc>()..add(const UserProfileEvent.started()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
