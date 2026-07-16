// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:admin_auth/src/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i655;
import 'package:admin_auth/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i71;
import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart'
    as _i318;
import 'package:admin_auth/src/features/auth/domain/usecases/auth_login_use_case.dart'
    as _i38;
import 'package:admin_auth/src/features/auth/domain/usecases/auth_refresh_token_use_case.dart'
    as _i751;
import 'package:admin_auth/src/features/auth/domain/usecases/auth_set_notification_token_use_case.dart'
    as _i80;
import 'package:admin_auth/src/features/auth/domain/usecases/auth_verify_use_case.dart'
    as _i1060;
import 'package:admin_auth/src/features/auth/presentation/blocs/auth/auth_bloc.dart'
    as _i698;
import 'package:admin_auth/src/features/sessions/data/datasources/sessions_remote_data_source.dart'
    as _i329;
import 'package:admin_auth/src/features/sessions/data/repositories/sessions_repository_impl.dart'
    as _i403;
import 'package:admin_auth/src/features/sessions/domain/repositories/sessions_repository.dart'
    as _i49;
import 'package:admin_auth/src/features/sessions/domain/usecases/get_sessions_use_case.dart'
    as _i712;
import 'package:admin_auth/src/features/sessions/domain/usecases/revoke_all_sessions_use_case.dart'
    as _i267;
import 'package:admin_auth/src/features/sessions/domain/usecases/revoke_session_use_case.dart'
    as _i132;
import 'package:admin_auth/src/features/sessions/presentation/blocs/sessions/sessions_bloc.dart'
    as _i230;
import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;

class AdminAuthPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i329.SessionsRemoteDataSource>(() =>
        _i329.SessionsRemoteDataSourceImpl(
            gh<_i494.ApiClient>(instanceName: 'protectedApiClient')));
    gh.singleton<_i49.SessionsRepository>(() => _i403.SessionsRepositoryImpl(
          gh<_i329.SessionsRemoteDataSource>(),
          gh<_i494.TokenStorage>(),
        ));
    gh.lazySingleton<_i712.GetSessionsUseCase>(
        () => _i712.GetSessionsUseCase(gh<_i49.SessionsRepository>()));
    gh.lazySingleton<_i267.RevokeAllSessionsUseCase>(
        () => _i267.RevokeAllSessionsUseCase(gh<_i49.SessionsRepository>()));
    gh.lazySingleton<_i132.RevokeSessionUseCase>(
        () => _i132.RevokeSessionUseCase(gh<_i49.SessionsRepository>()));
    gh.singleton<_i655.AuthRemoteDataSource>(
        () => _i655.AuthRemoteDataSourceImpl(
              gh<_i494.ApiClient>(instanceName: 'publicApiClient'),
              gh<_i494.ApiClient>(instanceName: 'protectedApiClient'),
            ));
    gh.factory<_i230.SessionsBloc>(() => _i230.SessionsBloc(
          gh<_i712.GetSessionsUseCase>(),
          gh<_i132.RevokeSessionUseCase>(),
          gh<_i267.RevokeAllSessionsUseCase>(),
        ));
    gh.singleton<_i318.AuthRepository>(() => _i71.AuthRepositoryImpl(
          gh<_i655.AuthRemoteDataSource>(),
          gh<_i494.TokenStorage>(),
        ));
    gh.lazySingleton<_i38.AuthLoginUseCase>(
        () => _i38.AuthLoginUseCase(gh<_i318.AuthRepository>()));
    gh.lazySingleton<_i751.AuthRefreshTokenUseCase>(
        () => _i751.AuthRefreshTokenUseCase(gh<_i318.AuthRepository>()));
    gh.lazySingleton<_i80.AuthSetNotificationTokenUseCase>(
        () => _i80.AuthSetNotificationTokenUseCase(gh<_i318.AuthRepository>()));
    gh.lazySingleton<_i1060.AuthVerifyUseCase>(
        () => _i1060.AuthVerifyUseCase(gh<_i318.AuthRepository>()));
    gh.factory<_i698.AuthBloc>(() => _i698.AuthBloc(
          gh<_i38.AuthLoginUseCase>(),
          gh<_i1060.AuthVerifyUseCase>(),
        ));
  }
}
