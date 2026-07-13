import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AdminAppModule {
  @singleton
  AdminAppRouter get appRouter => AdminAppRouter();

  @singleton
  CoreNavigationBloc get navigationBloc => CoreNavigationBloc();
}
