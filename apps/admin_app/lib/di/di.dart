import 'package:admin_auth/admin_auth.dart';
import 'package:admin_preferences/admin_preferences.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:admin_users/admin_users.dart';
import 'package:core/core.dart' show ApiClientFactory, sl;
import 'package:core/di/injection.module.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(AdminAuthPackageModule),
    ExternalModule(AdminProfilePackageModule),
    ExternalModule(AdminPreferencesPackageModule),
    ExternalModule(AdminUsersPackageModule),
  ],
)
Future<void> configureDependencies() async {
  await sl.init();
  sl<ApiClientFactory>().registerHeadersProvider(
    sl<AcceptLanguageHeadersProvider>(),
  );
}
