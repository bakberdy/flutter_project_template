import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'admin_users_di.config.dart';

@InjectableInit(
  initializerName: 'initAdminUsers',
  ignoreUnregisteredTypes: [ApiClient],
)
void configureAdminUsersDependencies() => GetIt.instance.initAdminUsers();
