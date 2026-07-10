// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:client_auth/src/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i279;
import 'package:client_auth/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i201;
import 'package:client_auth/src/features/auth/data/services/auth_session_invalidator_impl.dart'
    as _i273;
import 'package:client_auth/src/features/auth/domain/repositories/auth_repository.dart'
    as _i296;
import 'package:client_auth/src/features/auth/domain/services/auth_session_invalidator.dart'
    as _i514;
import 'package:client_auth/src/features/auth/domain/usecases/auth_login_use_case.dart'
    as _i4;
import 'package:client_auth/src/features/auth/domain/usecases/auth_verify_use_case.dart'
    as _i454;
import 'package:client_auth/src/features/auth/presentation/blocs/auth/auth_bloc.dart'
    as _i376;
import 'package:client_auth/src/features/sessions/data/datasources/sessions_remote_data_source.dart'
    as _i312;
import 'package:client_auth/src/features/sessions/data/repositories/sessions_repository_impl.dart'
    as _i653;
import 'package:client_auth/src/features/sessions/domain/repositories/sessions_repository.dart'
    as _i339;
import 'package:client_auth/src/features/sessions/domain/usecases/get_sessions_use_case.dart'
    as _i345;
import 'package:client_auth/src/features/sessions/domain/usecases/revoke_all_sessions_use_case.dart'
    as _i712;
import 'package:client_auth/src/features/sessions/domain/usecases/revoke_session_use_case.dart'
    as _i760;
import 'package:client_auth/src/features/sessions/presentation/blocs/sessions/sessions_bloc.dart'
    as _i377;
import 'package:client_auth/src/features/users/data/datasources/user_profile_remote_data_source.dart'
    as _i47;
import 'package:client_auth/src/features/users/data/repositories/user_profile_repository_impl.dart'
    as _i570;
import 'package:client_auth/src/features/users/domain/repositories/user_profile_repository.dart'
    as _i500;
import 'package:client_auth/src/features/users/domain/usecases/create_user_profile_use_case.dart'
    as _i435;
import 'package:client_auth/src/features/users/domain/usecases/get_app_info_use_case.dart'
    as _i490;
import 'package:client_auth/src/features/users/domain/usecases/get_current_user_profile_use_case.dart'
    as _i290;
import 'package:client_auth/src/features/users/domain/usecases/get_current_user_use_case.dart'
    as _i388;
import 'package:client_auth/src/features/users/domain/usecases/remove_user_avatar_use_case.dart'
    as _i641;
import 'package:client_auth/src/features/users/domain/usecases/request_account_deletion_use_case.dart'
    as _i323;
import 'package:client_auth/src/features/users/domain/usecases/update_user_avatar_use_case.dart'
    as _i1052;
import 'package:client_auth/src/features/users/domain/usecases/update_user_profile_use_case.dart'
    as _i430;
import 'package:client_auth/src/features/users/presentation/blocs/create_user_profile_bloc/create_user_profile_bloc.dart'
    as _i509;
import 'package:client_auth/src/features/users/presentation/blocs/user/user_bloc.dart'
    as _i248;
import 'package:client_auth/src/features/users/presentation/blocs/user_profile_bloc/user_profile_bloc.dart'
    as _i192;
import 'package:client_auth/src/features/users/presentation/blocs/user_profile_edit_bloc/user_profile_edit_bloc.dart'
    as _i704;
import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;

class ClientAuthPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i279.AuthRemoteDataSource>(() =>
        _i279.AuthRemoteDataSourceImpl(
            gh<_i494.ApiClient>(instanceName: 'protectedApiClient')));
    gh.singleton<_i514.AuthSessionInvalidator>(
        () => _i273.AuthSessionInvalidatorImpl());
    gh.singleton<_i312.SessionsRemoteDataSource>(() =>
        _i312.SessionsRemoteDataSourceImpl(
            gh<_i494.ApiClient>(instanceName: 'protectedApiClient')));
    gh.singleton<_i47.UserProfileRemoteDataSource>(() =>
        _i47.UserProfileRemoteDataSourceImpl(
            gh<_i494.ApiClient>(instanceName: 'protectedApiClient')));
    gh.lazySingleton<_i490.GetAppInfoUseCase>(
        () => _i490.GetAppInfoUseCase(gh<_i494.DeviceInfoService>()));
    gh.singleton<_i296.AuthRepository>(() => _i201.AuthRepositoryImpl(
          gh<_i279.AuthRemoteDataSource>(),
          gh<_i494.TokenStorage>(),
          gh<_i494.DeviceInfoService>(),
        ));
    gh.singleton<_i500.UserProfileRepository>(() =>
        _i570.UserProfileRepositoryImpl(
            gh<_i47.UserProfileRemoteDataSource>()));
    gh.singleton<_i339.SessionsRepository>(() => _i653.SessionsRepositoryImpl(
          gh<_i312.SessionsRemoteDataSource>(),
          gh<_i494.TokenStorage>(),
        ));
    gh.lazySingleton<_i4.AuthLoginUseCase>(
        () => _i4.AuthLoginUseCase(gh<_i296.AuthRepository>()));
    gh.lazySingleton<_i454.AuthVerifyUseCase>(
        () => _i454.AuthVerifyUseCase(gh<_i296.AuthRepository>()));
    gh.lazySingleton<_i345.GetSessionsUseCase>(
        () => _i345.GetSessionsUseCase(gh<_i339.SessionsRepository>()));
    gh.lazySingleton<_i712.RevokeAllSessionsUseCase>(
        () => _i712.RevokeAllSessionsUseCase(gh<_i339.SessionsRepository>()));
    gh.lazySingleton<_i760.RevokeSessionUseCase>(
        () => _i760.RevokeSessionUseCase(gh<_i339.SessionsRepository>()));
    gh.factory<_i376.AuthBloc>(() => _i376.AuthBloc(
          gh<_i4.AuthLoginUseCase>(),
          gh<_i454.AuthVerifyUseCase>(),
        ));
    gh.lazySingleton<_i435.CreateUserProfileUseCase>(() =>
        _i435.CreateUserProfileUseCase(gh<_i500.UserProfileRepository>()));
    gh.lazySingleton<_i290.GetCurrentUserProfileUseCase>(() =>
        _i290.GetCurrentUserProfileUseCase(gh<_i500.UserProfileRepository>()));
    gh.lazySingleton<_i388.GetCurrentUserUseCase>(
        () => _i388.GetCurrentUserUseCase(gh<_i500.UserProfileRepository>()));
    gh.lazySingleton<_i641.RemoveUserAvatarUseCase>(
        () => _i641.RemoveUserAvatarUseCase(gh<_i500.UserProfileRepository>()));
    gh.lazySingleton<_i323.RequestAccountDeletionUseCase>(() =>
        _i323.RequestAccountDeletionUseCase(gh<_i500.UserProfileRepository>()));
    gh.lazySingleton<_i1052.UpdateUserAvatarUseCase>(() =>
        _i1052.UpdateUserAvatarUseCase(gh<_i500.UserProfileRepository>()));
    gh.lazySingleton<_i430.UpdateUserProfileUseCase>(() =>
        _i430.UpdateUserProfileUseCase(gh<_i500.UserProfileRepository>()));
    gh.factory<_i377.SessionsBloc>(() => _i377.SessionsBloc(
          gh<_i345.GetSessionsUseCase>(),
          gh<_i760.RevokeSessionUseCase>(),
          gh<_i712.RevokeAllSessionsUseCase>(),
        ));
    gh.factory<_i509.CreateUserProfileBloc>(() =>
        _i509.CreateUserProfileBloc(gh<_i435.CreateUserProfileUseCase>()));
    gh.factory<_i192.UserProfileBloc>(() => _i192.UserProfileBloc(
          gh<_i490.GetAppInfoUseCase>(),
          gh<_i388.GetCurrentUserUseCase>(),
          gh<_i290.GetCurrentUserProfileUseCase>(),
          gh<_i1052.UpdateUserAvatarUseCase>(),
          gh<_i641.RemoveUserAvatarUseCase>(),
          gh<_i323.RequestAccountDeletionUseCase>(),
          gh<_i494.CoreAppConfig>(),
        ));
    gh.factory<_i704.UserProfileEditBloc>(
        () => _i704.UserProfileEditBloc(gh<_i430.UpdateUserProfileUseCase>()));
    gh.factory<_i248.UserBloc>(
        () => _i248.UserBloc(gh<_i388.GetCurrentUserUseCase>()));
  }
}
