// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:core/src/config/app_config.dart' as _i920;
import 'package:core/src/config/core_app_config.dart' as _i693;
import 'package:core/src/core/api/api.dart' as _i419;
import 'package:core/src/core/api/storage/token_storage.dart' as _i932;
import 'package:core/src/core/api/storage/token_storage_impl.dart' as _i81;
import 'package:core/src/core/storage/local_storage/local_storage.dart'
    as _i972;
import 'package:core/src/core/storage/local_storage/shared_preferences_storage.dart'
    as _i777;
import 'package:core/src/core/storage/secure_storage/flutter_secure_storage_impl.dart'
    as _i1027;
import 'package:core/src/core/storage/secure_storage/secure_storage.dart'
    as _i1061;
import 'package:core/src/di/app_module.dart' as _i366;
import 'package:core/src/shared/services/device_info_service.dart' as _i772;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker/talker.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> initCore({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i920.AppConfig>(() => appModule.appConfig);
    gh.singleton<_i693.CoreAppConfig>(() => appModule.coreAppConfig);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i558.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.singleton<_i993.Talker>(() => appModule.talker);
    gh.singleton<_i772.DeviceInfoService>(() => _i772.DeviceInfoService());
    gh.singleton<_i932.TokenStorage>(
      () => _i81.TokenStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i419.ApiClientFactory>(
      () => appModule.apiClientFactory(gh<_i419.TokenStorage>()),
    );
    gh.lazySingleton<_i1061.SecureStorage>(
      () => _i1027.FlutterSecureStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i972.LocalStorage>(
      () => _i777.SharedPreferencesStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i419.ApiClient>(
      () => appModule.apiClient(
        gh<_i920.AppConfig>(),
        gh<_i419.ApiClientFactory>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i366.AppModule {}
