// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:admin_users/src/features/users/data/datasources/users_remote_data_source.dart'
    as _i30;
import 'package:admin_users/src/features/users/data/repositories/users_repository_impl.dart'
    as _i67;
import 'package:admin_users/src/features/users/data/services/users_repository_request_handler.dart'
    as _i166;
import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart'
    as _i523;
import 'package:admin_users/src/features/users/domain/usecases/approve_user_deletion_request_use_case.dart'
    as _i600;
import 'package:admin_users/src/features/users/domain/usecases/change_user_role_use_case.dart'
    as _i771;
import 'package:admin_users/src/features/users/domain/usecases/change_user_status_use_case.dart'
    as _i735;
import 'package:admin_users/src/features/users/domain/usecases/get_user_profile_use_case.dart'
    as _i704;
import 'package:admin_users/src/features/users/domain/usecases/get_user_use_case.dart'
    as _i53;
import 'package:admin_users/src/features/users/domain/usecases/get_users_use_case.dart'
    as _i183;
import 'package:admin_users/src/features/users/presentation/blocs/user/user_bloc.dart'
    as _i422;
import 'package:admin_users/src/features/users/presentation/blocs/users_list/users_list_bloc.dart'
    as _i501;
import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;

class AdminUsersPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i166.UsersRepositoryRequestHandler>(
        () => const _i166.UsersRepositoryRequestHandler());
    gh.singleton<_i30.UsersRemoteDataSource>(() =>
        _i30.UsersRemoteDataSourceImpl(
            gh<_i494.ApiClient>(instanceName: 'protectedApiClient')));
    gh.singleton<_i523.UsersRepository>(() => _i67.UsersRepositoryImpl(
          gh<_i30.UsersRemoteDataSource>(),
          gh<_i166.UsersRepositoryRequestHandler>(),
        ));
    gh.lazySingleton<_i600.ApproveUserDeletionRequestUseCase>(() =>
        _i600.ApproveUserDeletionRequestUseCase(gh<_i523.UsersRepository>()));
    gh.lazySingleton<_i771.ChangeUserRoleUseCase>(
        () => _i771.ChangeUserRoleUseCase(gh<_i523.UsersRepository>()));
    gh.lazySingleton<_i735.ChangeUserStatusUseCase>(
        () => _i735.ChangeUserStatusUseCase(gh<_i523.UsersRepository>()));
    gh.lazySingleton<_i704.GetUserProfileUseCase>(
        () => _i704.GetUserProfileUseCase(gh<_i523.UsersRepository>()));
    gh.lazySingleton<_i53.GetUserUseCase>(
        () => _i53.GetUserUseCase(gh<_i523.UsersRepository>()));
    gh.lazySingleton<_i183.GetUsersUseCase>(
        () => _i183.GetUsersUseCase(gh<_i523.UsersRepository>()));
    gh.factory<_i422.UserBloc>(() => _i422.UserBloc(
          gh<_i53.GetUserUseCase>(),
          gh<_i704.GetUserProfileUseCase>(),
          gh<_i735.ChangeUserStatusUseCase>(),
          gh<_i600.ApproveUserDeletionRequestUseCase>(),
        ));
    gh.factory<_i501.UsersListBloc>(
        () => _i501.UsersListBloc(gh<_i183.GetUsersUseCase>()));
  }
}
