import 'package:client_app/navigation/client_app_router.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ClientAppModule {
  @singleton
  ClientAppRouter get appRouter => ClientAppRouter();

  @singleton
  CoreNavigationBloc get navigationBloc => CoreNavigationBloc();
}
