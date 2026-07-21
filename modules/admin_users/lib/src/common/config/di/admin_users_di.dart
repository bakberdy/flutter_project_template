import 'package:admin_users/src/common/config/di/admin_users_di.module.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(ignoreUnregisteredTypes: [ApiClient])
Future<void> configureAdminUsersDependencies() async =>
    AdminUsersPackageModule().init(GetItHelper(GetIt.instance));
