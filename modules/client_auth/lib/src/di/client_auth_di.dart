import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'client_auth_di.module.dart';

@InjectableInit.microPackage(
  ignoreUnregisteredTypes: [
    ApiClient,
    CoreAppConfig,
    TokenStorage,
    DeviceInfoService,
  ],
)
Future<void> configureClientAuthDependencies() async =>
    ClientAuthPackageModule().init(GetItHelper(GetIt.instance));
