import 'package:admin_preferences/src/common/config/di/admin_preferences_di.module.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(ignoreUnregisteredTypes: [ApiClient, LocalStorage])
Future<void> configureAdminPreferencesDependencies() async =>
    AdminPreferencesPackageModule().init(GetItHelper(GetIt.instance));
