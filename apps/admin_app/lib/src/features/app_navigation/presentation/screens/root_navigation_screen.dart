import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_app/src/features/app_navigation/presentation/blocs/user/user_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RootNavigationScreen extends StatelessWidget {
  const RootNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
    builder: (context, state) =>
        AutoRouter.declarative(routes: (_) => [_routeForState(state)]),
  );

  PageRouteInfo<dynamic> _routeForState(UserState state) => switch (state) {
    UserInitial() => const SplashRoute(),
    UserLoggedOut() => const AdminSignInRoute(),
    UserLoggedIn() => const MainNavigationRoute(),
  };
}
