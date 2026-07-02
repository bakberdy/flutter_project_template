import 'package:admin_auth/admin_auth.dart';
import 'package:admin_users/admin_users.dart';
import 'package:core/core.dart' show sl;
import 'package:core/di/injection.module.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(AdminAuthPackageModule),
    ExternalModule(AdminUsersPackageModule),
  ],
)
Future<void> configureDependencies() async => sl.init();
