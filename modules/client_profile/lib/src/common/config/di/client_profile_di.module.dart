// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:client_profile/src/features/profile/data/datasources/user_profile_remote_data_source.dart'
    as _i694;
import 'package:client_profile/src/features/profile/data/repositories/user_profile_repository_impl.dart'
    as _i328;
import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart'
    as _i569;
import 'package:client_profile/src/features/profile/domain/usecases/create_user_profile_use_case.dart'
    as _i243;
import 'package:client_profile/src/features/profile/domain/usecases/get_current_user_profile_use_case.dart'
    as _i722;
import 'package:client_profile/src/features/profile/domain/usecases/get_current_user_use_case.dart'
    as _i225;
import 'package:client_profile/src/features/profile/domain/usecases/log_out_use_case.dart'
    as _i527;
import 'package:client_profile/src/features/profile/domain/usecases/remove_user_avatar_use_case.dart'
    as _i133;
import 'package:client_profile/src/features/profile/domain/usecases/request_account_deletion_use_case.dart'
    as _i61;
import 'package:client_profile/src/features/profile/domain/usecases/update_user_avatar_use_case.dart'
    as _i1046;
import 'package:client_profile/src/features/profile/domain/usecases/update_user_profile_use_case.dart'
    as _i302;
import 'package:client_profile/src/features/profile/presentation/blocs/create_user_profile/create_user_profile_bloc.dart'
    as _i773;
import 'package:client_profile/src/features/profile/presentation/blocs/user/user_bloc.dart'
    as _i100;
import 'package:client_profile/src/features/profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i922;
import 'package:client_profile/src/features/profile/presentation/blocs/user_profile_edit/user_profile_edit_bloc.dart'
    as _i149;
import 'package:client_profile/src/features/sessions/data/datasources/sessions_remote_data_source.dart'
    as _i279;
import 'package:client_profile/src/features/sessions/data/repositories/sessions_repository_impl.dart'
    as _i814;
import 'package:client_profile/src/features/sessions/domain/repositories/sessions_repository.dart'
    as _i481;
import 'package:client_profile/src/features/sessions/domain/usecases/get_sessions_use_case.dart'
    as _i956;
import 'package:client_profile/src/features/sessions/domain/usecases/revoke_all_sessions_use_case.dart'
    as _i57;
import 'package:client_profile/src/features/sessions/domain/usecases/revoke_session_use_case.dart'
    as _i764;
import 'package:client_profile/src/features/sessions/presentation/blocs/sessions/sessions_bloc.dart'
    as _i186;
import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;

class ClientProfilePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i694.UserProfileRemoteDataSource>(() =>
        _i694.UserProfileRemoteDataSourceImpl(
            gh<_i494.ApiClient>(instanceName: 'protectedApiClient')));
    gh.singleton<_i279.SessionsRemoteDataSource>(() =>
        _i279.SessionsRemoteDataSourceImpl(
            gh<_i494.ApiClient>(instanceName: 'protectedApiClient')));
    gh.singleton<_i569.UserProfileRepository>(
        () => _i328.UserProfileRepositoryImpl(
              gh<_i694.UserProfileRemoteDataSource>(),
              gh<_i494.TokenStorage>(),
            ));
    gh.singleton<_i481.SessionsRepository>(() => _i814.SessionsRepositoryImpl(
          gh<_i279.SessionsRemoteDataSource>(),
          gh<_i494.TokenStorage>(),
        ));
    gh.lazySingleton<_i956.GetSessionsUseCase>(
        () => _i956.GetSessionsUseCase(gh<_i481.SessionsRepository>()));
    gh.lazySingleton<_i57.RevokeAllSessionsUseCase>(
        () => _i57.RevokeAllSessionsUseCase(gh<_i481.SessionsRepository>()));
    gh.lazySingleton<_i764.RevokeSessionUseCase>(
        () => _i764.RevokeSessionUseCase(gh<_i481.SessionsRepository>()));
    gh.lazySingleton<_i243.CreateUserProfileUseCase>(() =>
        _i243.CreateUserProfileUseCase(gh<_i569.UserProfileRepository>()));
    gh.lazySingleton<_i722.GetCurrentUserProfileUseCase>(() =>
        _i722.GetCurrentUserProfileUseCase(gh<_i569.UserProfileRepository>()));
    gh.lazySingleton<_i225.GetCurrentUserUseCase>(
        () => _i225.GetCurrentUserUseCase(gh<_i569.UserProfileRepository>()));
    gh.lazySingleton<_i527.LogOutUseCase>(
        () => _i527.LogOutUseCase(gh<_i569.UserProfileRepository>()));
    gh.lazySingleton<_i133.RemoveUserAvatarUseCase>(
        () => _i133.RemoveUserAvatarUseCase(gh<_i569.UserProfileRepository>()));
    gh.lazySingleton<_i61.RequestAccountDeletionUseCase>(() =>
        _i61.RequestAccountDeletionUseCase(gh<_i569.UserProfileRepository>()));
    gh.lazySingleton<_i1046.UpdateUserAvatarUseCase>(() =>
        _i1046.UpdateUserAvatarUseCase(gh<_i569.UserProfileRepository>()));
    gh.lazySingleton<_i302.UpdateUserProfileUseCase>(() =>
        _i302.UpdateUserProfileUseCase(gh<_i569.UserProfileRepository>()));
    gh.factory<_i100.UserBloc>(() => _i100.UserBloc(
          gh<_i225.GetCurrentUserUseCase>(),
          gh<_i527.LogOutUseCase>(),
        ));
    gh.factory<_i922.UserProfileBloc>(() => _i922.UserProfileBloc(
          gh<_i494.GetAppInfoUseCase>(),
          gh<_i225.GetCurrentUserUseCase>(),
          gh<_i722.GetCurrentUserProfileUseCase>(),
          gh<_i1046.UpdateUserAvatarUseCase>(),
          gh<_i133.RemoveUserAvatarUseCase>(),
          gh<_i61.RequestAccountDeletionUseCase>(),
          gh<_i494.CoreAppConfig>(),
        ));
    gh.factory<_i149.UserProfileEditBloc>(
        () => _i149.UserProfileEditBloc(gh<_i302.UpdateUserProfileUseCase>()));
    gh.factory<_i773.CreateUserProfileBloc>(() =>
        _i773.CreateUserProfileBloc(gh<_i243.CreateUserProfileUseCase>()));
    gh.factory<_i186.SessionsBloc>(() => _i186.SessionsBloc(
          gh<_i956.GetSessionsUseCase>(),
          gh<_i764.RevokeSessionUseCase>(),
          gh<_i57.RevokeAllSessionsUseCase>(),
        ));
  }
}
