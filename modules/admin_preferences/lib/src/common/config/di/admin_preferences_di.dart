import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'admin_preferences_di.module.dart';

@InjectableInit.microPackage(ignoreUnregisteredTypes: [ApiClient, LocalStorage])
Future<void> configureAdminPreferencesDependencies() async =>
    AdminPreferencesPackageModule().init(GetItHelper(GetIt.instance));
