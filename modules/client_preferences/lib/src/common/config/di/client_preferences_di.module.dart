// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:client_preferences/src/features/user_preferences/data/datasources/user_preferences_local_data_source.dart'
    as _i937;
import 'package:client_preferences/src/features/user_preferences/data/datasources/user_preferences_remote_data_source.dart'
    as _i669;
import 'package:client_preferences/src/features/user_preferences/data/interceptors/accept_language_headers_provider.dart'
    as _i176;
import 'package:client_preferences/src/features/user_preferences/data/repositories/user_preferences_repository_impl.dart'
    as _i233;
import 'package:client_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart'
    as _i796;
import 'package:client_preferences/src/features/user_preferences/domain/usecases/get_user_language_use_case.dart'
    as _i973;
import 'package:client_preferences/src/features/user_preferences/domain/usecases/get_user_preferences_use_case.dart'
    as _i922;
import 'package:client_preferences/src/features/user_preferences/domain/usecases/get_user_theme_use_case.dart'
    as _i434;
import 'package:client_preferences/src/features/user_preferences/domain/usecases/set_user_language_use_case.dart'
    as _i73;
import 'package:client_preferences/src/features/user_preferences/domain/usecases/set_user_notifications_use_case.dart'
    as _i189;
import 'package:client_preferences/src/features/user_preferences/domain/usecases/set_user_theme_use_case.dart'
    as _i212;
import 'package:client_preferences/src/features/user_preferences/presentation/blocs/locale_bloc/locale_bloc.dart'
    as _i220;
import 'package:client_preferences/src/features/user_preferences/presentation/blocs/notifications_bloc/notifications_bloc.dart'
    as _i491;
import 'package:client_preferences/src/features/user_preferences/presentation/blocs/theme_bloc/theme_bloc.dart'
    as _i732;
import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;

class ClientPreferencesPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i937.UserPreferencesLocalDataSource>(() =>
        _i937.UserPreferencesLocalDataSourceImpl(
            localStorage: gh<_i494.LocalStorage>()));
    gh.singleton<_i669.UserPreferencesRemoteDataSource>(() =>
        _i669.UserPreferencesRemoteDataSourceImpl(
            gh<_i494.ApiClient>(instanceName: 'protectedApiClient')));
    gh.lazySingleton<_i176.AcceptLanguageHeadersProvider>(
        () => _i176.AcceptLanguageHeadersProvider(gh<_i494.LocalStorage>()));
    gh.singleton<_i796.UserPreferencesRepository>(
        () => _i233.UserPreferencesRepositoryImpl(
              gh<_i937.UserPreferencesLocalDataSource>(),
              gh<_i669.UserPreferencesRemoteDataSource>(),
            ));
    gh.lazySingleton<_i973.GetUserLanguageUseCase>(() =>
        _i973.GetUserLanguageUseCase(gh<_i796.UserPreferencesRepository>()));
    gh.lazySingleton<_i922.GetUserPreferencesUseCase>(() =>
        _i922.GetUserPreferencesUseCase(gh<_i796.UserPreferencesRepository>()));
    gh.lazySingleton<_i434.GetUserThemeUseCase>(
        () => _i434.GetUserThemeUseCase(gh<_i796.UserPreferencesRepository>()));
    gh.lazySingleton<_i73.SetUserLanguageUseCase>(() =>
        _i73.SetUserLanguageUseCase(gh<_i796.UserPreferencesRepository>()));
    gh.lazySingleton<_i189.SetUserNotificationsUseCase>(() =>
        _i189.SetUserNotificationsUseCase(
            gh<_i796.UserPreferencesRepository>()));
    gh.lazySingleton<_i212.SetUserThemeUseCase>(
        () => _i212.SetUserThemeUseCase(gh<_i796.UserPreferencesRepository>()));
    gh.factory<_i220.LocaleBloc>(() => _i220.LocaleBloc(
          gh<_i973.GetUserLanguageUseCase>(),
          gh<_i73.SetUserLanguageUseCase>(),
        ));
    gh.factory<_i491.NotificationsBloc>(() => _i491.NotificationsBloc(
          gh<_i922.GetUserPreferencesUseCase>(),
          gh<_i189.SetUserNotificationsUseCase>(),
        ));
    gh.factory<_i732.ThemeBloc>(() => _i732.ThemeBloc(
          gh<_i434.GetUserThemeUseCase>(),
          gh<_i212.SetUserThemeUseCase>(),
        ));
  }
}
