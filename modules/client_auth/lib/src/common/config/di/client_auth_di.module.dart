// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:client_auth/src/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i279;
import 'package:client_auth/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i201;
import 'package:client_auth/src/features/auth/domain/repositories/auth_repository.dart'
    as _i296;
import 'package:client_auth/src/features/auth/domain/usecases/auth_log_out_use_case.dart'
    as _i288;
import 'package:client_auth/src/features/auth/domain/usecases/auth_login_use_case.dart'
    as _i4;
import 'package:client_auth/src/features/auth/domain/usecases/auth_refresh_token_use_case.dart'
    as _i974;
import 'package:client_auth/src/features/auth/domain/usecases/auth_set_notification_token_use_case.dart'
    as _i180;
import 'package:client_auth/src/features/auth/domain/usecases/auth_verify_use_case.dart'
    as _i454;
import 'package:client_auth/src/features/auth/presentation/blocs/auth/auth_bloc.dart'
    as _i376;
import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;

class ClientAuthPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i279.AuthRemoteDataSource>(
        () => _i279.AuthRemoteDataSourceImpl(
              gh<_i494.ApiClient>(instanceName: 'publicApiClient'),
              gh<_i494.ApiClient>(instanceName: 'protectedApiClient'),
            ));
    gh.singleton<_i296.AuthRepository>(() => _i201.AuthRepositoryImpl(
          gh<_i279.AuthRemoteDataSource>(),
          gh<_i494.TokenStorage>(),
          gh<_i494.DeviceInfoService>(),
        ));
    gh.lazySingleton<_i288.AuthLogOutUseCase>(
        () => _i288.AuthLogOutUseCase(gh<_i296.AuthRepository>()));
    gh.lazySingleton<_i4.AuthLoginUseCase>(
        () => _i4.AuthLoginUseCase(gh<_i296.AuthRepository>()));
    gh.lazySingleton<_i974.AuthRefreshTokenUseCase>(
        () => _i974.AuthRefreshTokenUseCase(gh<_i296.AuthRepository>()));
    gh.lazySingleton<_i180.AuthSetNotificationTokenUseCase>(() =>
        _i180.AuthSetNotificationTokenUseCase(gh<_i296.AuthRepository>()));
    gh.lazySingleton<_i454.AuthVerifyUseCase>(
        () => _i454.AuthVerifyUseCase(gh<_i296.AuthRepository>()));
    gh.factory<_i376.AuthBloc>(() => _i376.AuthBloc(
          gh<_i4.AuthLoginUseCase>(),
          gh<_i454.AuthVerifyUseCase>(),
        ));
  }
}
