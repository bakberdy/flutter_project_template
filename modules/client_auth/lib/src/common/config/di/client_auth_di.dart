import 'package:client_auth/src/common/config/di/client_auth_di.module.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

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
