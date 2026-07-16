// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:admin_profile/src/features/profile/data/datasources/user_profile_remote_data_source.dart'
    as _i1034;
import 'package:admin_profile/src/features/profile/data/repositories/user_profile_repository_impl.dart'
    as _i411;
import 'package:admin_profile/src/features/profile/domain/repositories/user_profile_repository.dart'
    as _i967;
import 'package:admin_profile/src/features/profile/domain/usecases/create_user_profile_use_case.dart'
    as _i160;
import 'package:admin_profile/src/features/profile/domain/usecases/get_current_user_profile_use_case.dart'
    as _i501;
import 'package:admin_profile/src/features/profile/domain/usecases/get_current_user_use_case.dart'
    as _i1040;
import 'package:admin_profile/src/features/profile/domain/usecases/log_out_use_case.dart'
    as _i775;
import 'package:admin_profile/src/features/profile/domain/usecases/remove_user_avatar_use_case.dart'
    as _i657;
import 'package:admin_profile/src/features/profile/domain/usecases/request_account_deletion_use_case.dart'
    as _i535;
import 'package:admin_profile/src/features/profile/domain/usecases/update_user_avatar_use_case.dart'
    as _i112;
import 'package:admin_profile/src/features/profile/domain/usecases/update_user_profile_use_case.dart'
    as _i647;
import 'package:admin_profile/src/features/profile/presentation/blocs/create_user_profile/create_user_profile_bloc.dart'
    as _i705;
import 'package:admin_profile/src/features/profile/presentation/blocs/user/user_bloc.dart'
    as _i62;
import 'package:admin_profile/src/features/profile/presentation/blocs/user_profile/user_profile_bloc.dart'
    as _i333;
import 'package:admin_profile/src/features/profile/presentation/blocs/user_profile_edit/user_profile_edit_bloc.dart'
    as _i410;
import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;

class AdminProfilePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i1034.UserProfileRemoteDataSource>(() =>
        _i1034.UserProfileRemoteDataSourceImpl(
            gh<_i494.ApiClient>(instanceName: 'protectedApiClient')));
    gh.singleton<_i967.UserProfileRepository>(
        () => _i411.UserProfileRepositoryImpl(
              gh<_i1034.UserProfileRemoteDataSource>(),
              gh<_i494.TokenStorage>(),
            ));
    gh.lazySingleton<_i160.CreateUserProfileUseCase>(() =>
        _i160.CreateUserProfileUseCase(gh<_i967.UserProfileRepository>()));
    gh.lazySingleton<_i501.GetCurrentUserProfileUseCase>(() =>
        _i501.GetCurrentUserProfileUseCase(gh<_i967.UserProfileRepository>()));
    gh.lazySingleton<_i1040.GetCurrentUserUseCase>(
        () => _i1040.GetCurrentUserUseCase(gh<_i967.UserProfileRepository>()));
    gh.lazySingleton<_i775.LogOutUseCase>(
        () => _i775.LogOutUseCase(gh<_i967.UserProfileRepository>()));
    gh.lazySingleton<_i657.RemoveUserAvatarUseCase>(
        () => _i657.RemoveUserAvatarUseCase(gh<_i967.UserProfileRepository>()));
    gh.lazySingleton<_i535.RequestAccountDeletionUseCase>(() =>
        _i535.RequestAccountDeletionUseCase(gh<_i967.UserProfileRepository>()));
    gh.lazySingleton<_i112.UpdateUserAvatarUseCase>(
        () => _i112.UpdateUserAvatarUseCase(gh<_i967.UserProfileRepository>()));
    gh.lazySingleton<_i647.UpdateUserProfileUseCase>(() =>
        _i647.UpdateUserProfileUseCase(gh<_i967.UserProfileRepository>()));
    gh.factory<_i333.UserProfileBloc>(() => _i333.UserProfileBloc(
          gh<_i501.GetCurrentUserProfileUseCase>(),
          gh<_i112.UpdateUserAvatarUseCase>(),
          gh<_i657.RemoveUserAvatarUseCase>(),
          gh<_i535.RequestAccountDeletionUseCase>(),
        ));
    gh.factory<_i705.CreateUserProfileBloc>(() =>
        _i705.CreateUserProfileBloc(gh<_i160.CreateUserProfileUseCase>()));
    gh.factory<_i410.UserProfileEditBloc>(
        () => _i410.UserProfileEditBloc(gh<_i647.UpdateUserProfileUseCase>()));
    gh.factory<_i62.UserBloc>(() => _i62.UserBloc(
          gh<_i1040.GetCurrentUserUseCase>(),
          gh<_i775.LogOutUseCase>(),
        ));
  }
}
