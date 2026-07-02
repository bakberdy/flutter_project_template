import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_users/src/features/users/presentation/blocs/users_list/users_list_bloc.dart';
import 'package:admin_users/src/features/users/presentation/widgets/users_list_view.dart';

@RoutePage()
class UsersScreen extends StatelessWidget implements AutoRouteWrapper {
  const UsersScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create: (context) =>
        sl<UsersListBloc>()..add(const UsersListEvent.started()),
    child: this,
  );

  @override
  Widget build(BuildContext context) => const UsersListView();
}
