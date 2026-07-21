import 'package:admin_profile/src/common/config/di/admin_profile_di.module.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(
  ignoreUnregisteredTypes: [
    ApiClient,
    CoreAppConfig,
    DeviceInfoService,
    TokenStorage,
  ],
)
Future<void> configureAdminProfileDependencies() async =>
    AdminProfilePackageModule().init(GetItHelper(GetIt.instance));
