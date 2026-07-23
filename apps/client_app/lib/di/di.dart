import 'package:client_app/di/di.config.dart';
import 'package:client_app/src/common/config/app_config.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_preferences/client_preferences.dart';
import 'package:client_profile/client_profile.dart';
import 'package:core/core.dart' show ApiClientFactory, CoreAppConfig, sl;
import 'package:core/di/injection.module.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(ClientAuthPackageModule),
    ExternalModule(ClientProfilePackageModule),
    ExternalModule(ClientPreferencesPackageModule),
  ],
)
Future<void> configureDependencies() async {
  if (!sl.isRegistered<CoreAppConfig>()) {
    sl.registerSingleton<CoreAppConfig>(AppConfig.instance);
  }
  await sl.init();
  sl<ApiClientFactory>().registerHeadersProvider(
    sl<AcceptLanguageHeadersProvider>(),
  );
}
