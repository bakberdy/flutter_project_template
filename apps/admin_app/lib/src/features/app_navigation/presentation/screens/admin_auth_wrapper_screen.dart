import 'package:admin_auth/admin_auth.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/app_route_outlet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AdminAuthWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const AdminAuthWrapperScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider(create: (context) => context.di<AuthBloc>(), child: this);

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
    listenWhen: (previous, current) =>
        current.status.isSuccess &&
        current.step == AuthStep.success &&
        (!previous.status.isSuccess || previous.step != AuthStep.success),
    listener: (context, state) {
      context.router.markUrlStateForReplace();
      context.read<CoreNavigationBloc>().add(
        const CoreNavigationEvent.authenticated(),
      );
    },
    child: const AppRouteOutlet(),
  );
}
