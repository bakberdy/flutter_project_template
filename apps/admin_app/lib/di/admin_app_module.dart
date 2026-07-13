import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_app/src/features/app_navigation/presentation/blocs/user/user_bloc.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AdminAppModule {
  @singleton
  AdminAppRouter get appRouter => AdminAppRouter();

  @singleton
  CoreNavigationBloc get navigationBloc => CoreNavigationBloc();

  @factoryMethod
  UserBloc userBloc(TokenStorage tokenStorage) => UserBloc(tokenStorage);
}
