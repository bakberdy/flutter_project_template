import 'package:client_profile/src/common/config/di/client_profile_di.module.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(
  ignoreUnregisteredTypes: [
    ApiClient,
    CoreAppConfig,
    GetAppInfoUseCase,
    TokenStorage,
  ],
)
Future<void> configureClientProfileDependencies() async =>
    ClientProfilePackageModule().init(GetItHelper(GetIt.instance));
