import 'package:client_preferences/src/common/config/di/client_preferences_di.module.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(ignoreUnregisteredTypes: [ApiClient, LocalStorage])
Future<void> configureClientPreferencesDependencies() async =>
    ClientPreferencesPackageModule().init(GetItHelper(GetIt.instance));
