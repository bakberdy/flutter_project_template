import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'admin_users_di.module.dart';

@InjectableInit.microPackage(ignoreUnregisteredTypes: [ApiClient])
Future<void> configureAdminUsersDependencies() async =>
    AdminUsersPackageModule().init(GetItHelper(GetIt.instance));
