// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

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
import 'package:client_profile/src/features/users/data/datasources/user_profile_remote_data_source.dart'
    as _i869;
import 'package:client_profile/src/features/users/data/repositories/user_profile_repository_impl.dart'
    as _i664;
import 'package:client_profile/src/features/users/domain/repositories/user_profile_repository.dart'
    as _i882;
import 'package:client_profile/src/features/users/domain/usecases/create_user_profile_use_case.dart'
    as _i330;
import 'package:client_profile/src/features/users/domain/usecases/get_app_info_use_case.dart'
    as _i23;
import 'package:client_profile/src/features/users/domain/usecases/get_current_user_profile_use_case.dart'
    as _i271;
import 'package:client_profile/src/features/users/domain/usecases/get_current_user_use_case.dart'
    as _i148;
import 'package:client_profile/src/features/users/domain/usecases/remove_user_avatar_use_case.dart'
    as _i771;
import 'package:client_profile/src/features/users/domain/usecases/request_account_deletion_use_case.dart'
    as _i100;
import 'package:client_profile/src/features/users/domain/usecases/update_user_avatar_use_case.dart'
    as _i815;
import 'package:client_profile/src/features/users/domain/usecases/update_user_profile_use_case.dart'
    as _i38;
import 'package:client_profile/src/features/users/presentation/blocs/create_user_profile_bloc/create_user_profile_bloc.dart'
    as _i357;
import 'package:client_profile/src/features/users/presentation/blocs/user/user_bloc.dart'
    as _i406;
import 'package:client_profile/src/features/users/presentation/blocs/user_profile_bloc/user_profile_bloc.dart'
    as _i107;
import 'package:client_profile/src/features/users/presentation/blocs/user_profile_edit_bloc/user_profile_edit_bloc.dart'
    as _i370;
import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;

class ClientProfilePackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i869.UserProfileRemoteDataSource>(
      () => _i869.UserProfileRemoteDataSourceImpl(
        gh<_i494.ApiClient>(instanceName: 'protectedApiClient'),
      ),
    );
    gh.singleton<_i279.SessionsRemoteDataSource>(
      () => _i279.SessionsRemoteDataSourceImpl(
        gh<_i494.ApiClient>(instanceName: 'protectedApiClient'),
      ),
    );
    gh.lazySingleton<_i23.GetAppInfoUseCase>(
      () => _i23.GetAppInfoUseCase(gh<_i494.DeviceInfoService>()),
    );
    gh.singleton<_i882.UserProfileRepository>(
      () => _i664.UserProfileRepositoryImpl(
        gh<_i869.UserProfileRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i330.CreateUserProfileUseCase>(
      () => _i330.CreateUserProfileUseCase(gh<_i882.UserProfileRepository>()),
    );
    gh.lazySingleton<_i271.GetCurrentUserProfileUseCase>(
      () =>
          _i271.GetCurrentUserProfileUseCase(gh<_i882.UserProfileRepository>()),
    );
    gh.lazySingleton<_i148.GetCurrentUserUseCase>(
      () => _i148.GetCurrentUserUseCase(gh<_i882.UserProfileRepository>()),
    );
    gh.lazySingleton<_i771.RemoveUserAvatarUseCase>(
      () => _i771.RemoveUserAvatarUseCase(gh<_i882.UserProfileRepository>()),
    );
    gh.lazySingleton<_i100.RequestAccountDeletionUseCase>(
      () => _i100.RequestAccountDeletionUseCase(
        gh<_i882.UserProfileRepository>(),
      ),
    );
    gh.lazySingleton<_i815.UpdateUserAvatarUseCase>(
      () => _i815.UpdateUserAvatarUseCase(gh<_i882.UserProfileRepository>()),
    );
    gh.lazySingleton<_i38.UpdateUserProfileUseCase>(
      () => _i38.UpdateUserProfileUseCase(gh<_i882.UserProfileRepository>()),
    );
    gh.singleton<_i481.SessionsRepository>(
      () => _i814.SessionsRepositoryImpl(
        gh<_i279.SessionsRemoteDataSource>(),
        gh<_i494.TokenStorage>(),
      ),
    );
    gh.lazySingleton<_i956.GetSessionsUseCase>(
      () => _i956.GetSessionsUseCase(gh<_i481.SessionsRepository>()),
    );
    gh.lazySingleton<_i57.RevokeAllSessionsUseCase>(
      () => _i57.RevokeAllSessionsUseCase(gh<_i481.SessionsRepository>()),
    );
    gh.lazySingleton<_i764.RevokeSessionUseCase>(
      () => _i764.RevokeSessionUseCase(gh<_i481.SessionsRepository>()),
    );
    gh.factory<_i370.UserProfileEditBloc>(
      () => _i370.UserProfileEditBloc(gh<_i38.UpdateUserProfileUseCase>()),
    );
    gh.factory<_i107.UserProfileBloc>(
      () => _i107.UserProfileBloc(
        gh<_i23.GetAppInfoUseCase>(),
        gh<_i148.GetCurrentUserUseCase>(),
        gh<_i271.GetCurrentUserProfileUseCase>(),
        gh<_i815.UpdateUserAvatarUseCase>(),
        gh<_i771.RemoveUserAvatarUseCase>(),
        gh<_i100.RequestAccountDeletionUseCase>(),
        gh<_i494.CoreAppConfig>(),
      ),
    );
    gh.factory<_i406.UserBloc>(
      () => _i406.UserBloc(gh<_i148.GetCurrentUserUseCase>()),
    );
    gh.factory<_i357.CreateUserProfileBloc>(
      () => _i357.CreateUserProfileBloc(gh<_i330.CreateUserProfileUseCase>()),
    );
    gh.factory<_i186.SessionsBloc>(
      () => _i186.SessionsBloc(
        gh<_i956.GetSessionsUseCase>(),
        gh<_i764.RevokeSessionUseCase>(),
        gh<_i57.RevokeAllSessionsUseCase>(),
      ),
    );
  }
}
