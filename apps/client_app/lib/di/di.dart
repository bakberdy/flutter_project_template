import 'package:client_auth/client_auth.dart';
import 'package:client_preferences/client_preferences.dart';
import 'package:core/core.dart' show ApiClientFactory, sl;
import 'package:core/di/injection.module.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(ClientAuthPackageModule),
    ExternalModule(ClientPreferencesPackageModule),
  ],
)
Future<void> configureDependencies() async {
  await sl.init();
  sl<ApiClientFactory>().registerHeadersProvider(
    sl<AcceptLanguageHeadersProvider>(),
  );
}
