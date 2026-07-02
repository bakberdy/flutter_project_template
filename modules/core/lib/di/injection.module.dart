// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:core/api/api.dart' as _i229;
import 'package:core/api/storage/token_storage.dart' as _i610;
import 'package:core/api/storage/token_storage_impl.dart' as _i511;
import 'package:core/config/app_config.dart' as _i776;
import 'package:core/config/core_app_config.dart' as _i283;
import 'package:core/di/core_module.dart' as _i674;
import 'package:core/shared/services/device_info_service.dart' as _i19;
import 'package:core/storage/local/local_storage.dart' as _i2;
import 'package:core/storage/local/shared_preferences_storage.dart' as _i862;
import 'package:core/storage/secure/flutter_secure_storage_impl.dart' as _i181;
import 'package:core/storage/secure/secure_storage.dart' as _i423;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker/talker.dart' as _i993;

class CorePackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final coreModule = _$CoreModule();
    gh.singleton<_i776.AppConfig>(() => coreModule.appConfig);
    gh.singleton<_i283.CoreAppConfig>(() => coreModule.coreAppConfig);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => coreModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i558.FlutterSecureStorage>(() => coreModule.secureStorage);
    gh.singleton<_i993.Talker>(() => coreModule.talker);
    gh.singleton<_i19.DeviceInfoService>(() => _i19.DeviceInfoService());
    gh.lazySingleton<_i423.SecureStorage>(
      () => _i181.FlutterSecureStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i610.TokenStorage>(
      () => _i511.TokenStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i2.LocalStorage>(
      () => _i862.SharedPreferencesStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i229.ApiClientFactory>(
      () => coreModule.apiClientFactory(gh<_i229.TokenStorage>()),
    );
    gh.lazySingleton<_i229.ApiClient>(
      () => coreModule.protectedApiClient(
        gh<_i776.AppConfig>(),
        gh<_i229.ApiClientFactory>(),
      ),
      instanceName: 'protectedApiClient',
    );
    gh.lazySingleton<_i229.ApiClient>(
      () => coreModule.publicApiClient(
        gh<_i776.AppConfig>(),
        gh<_i229.ApiClientFactory>(),
      ),
      instanceName: 'publicApiClient',
    );
  }
}

class _$CoreModule extends _i674.CoreModule {}
