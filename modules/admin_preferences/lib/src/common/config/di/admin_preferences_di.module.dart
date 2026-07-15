// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:admin_preferences/src/features/user_preferences/data/datasources/user_preferences_local_data_source.dart'
    as _i693;
import 'package:admin_preferences/src/features/user_preferences/data/datasources/user_preferences_remote_data_source.dart'
    as _i904;
import 'package:admin_preferences/src/features/user_preferences/data/interceptors/accept_language_headers_provider.dart'
    as _i1065;
import 'package:admin_preferences/src/features/user_preferences/data/repositories/user_preferences_repository_impl.dart'
    as _i712;
import 'package:admin_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart'
    as _i415;
import 'package:admin_preferences/src/features/user_preferences/domain/usecases/get_user_language_use_case.dart'
    as _i640;
import 'package:admin_preferences/src/features/user_preferences/domain/usecases/get_user_preferences_use_case.dart'
    as _i732;
import 'package:admin_preferences/src/features/user_preferences/domain/usecases/get_user_theme_use_case.dart'
    as _i829;
import 'package:admin_preferences/src/features/user_preferences/domain/usecases/set_user_language_use_case.dart'
    as _i1013;
import 'package:admin_preferences/src/features/user_preferences/domain/usecases/set_user_notifications_use_case.dart'
    as _i909;
import 'package:admin_preferences/src/features/user_preferences/domain/usecases/set_user_theme_use_case.dart'
    as _i158;
import 'package:admin_preferences/src/features/user_preferences/presentation/blocs/locale/locale_bloc.dart'
    as _i105;
import 'package:admin_preferences/src/features/user_preferences/presentation/blocs/notifications/notifications_bloc.dart'
    as _i363;
import 'package:admin_preferences/src/features/user_preferences/presentation/blocs/theme/theme_bloc.dart'
    as _i76;
import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;

class AdminPreferencesPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i693.UserPreferencesLocalDataSource>(
      () => _i693.UserPreferencesLocalDataSourceImpl(
        localStorage: gh<_i494.LocalStorage>(),
      ),
    );
    gh.singleton<_i904.UserPreferencesRemoteDataSource>(
      () => _i904.UserPreferencesRemoteDataSourceImpl(
        gh<_i494.ApiClient>(instanceName: 'protectedApiClient'),
      ),
    );
    gh.singleton<_i415.UserPreferencesRepository>(
      () => _i712.UserPreferencesRepositoryImpl(
        gh<_i693.UserPreferencesLocalDataSource>(),
        gh<_i904.UserPreferencesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i494.ApiRequestHeadersProvider>(
      () => _i1065.AcceptLanguageHeadersProvider(gh<_i494.LocalStorage>()),
    );
    gh.lazySingleton<_i640.GetUserLanguageUseCase>(
      () => _i640.GetUserLanguageUseCase(gh<_i415.UserPreferencesRepository>()),
    );
    gh.lazySingleton<_i732.GetUserPreferencesUseCase>(
      () => _i732.GetUserPreferencesUseCase(
        gh<_i415.UserPreferencesRepository>(),
      ),
    );
    gh.lazySingleton<_i829.GetUserThemeUseCase>(
      () => _i829.GetUserThemeUseCase(gh<_i415.UserPreferencesRepository>()),
    );
    gh.lazySingleton<_i1013.SetUserLanguageUseCase>(
      () =>
          _i1013.SetUserLanguageUseCase(gh<_i415.UserPreferencesRepository>()),
    );
    gh.lazySingleton<_i909.SetUserNotificationsUseCase>(
      () => _i909.SetUserNotificationsUseCase(
        gh<_i415.UserPreferencesRepository>(),
      ),
    );
    gh.lazySingleton<_i158.SetUserThemeUseCase>(
      () => _i158.SetUserThemeUseCase(gh<_i415.UserPreferencesRepository>()),
    );
    gh.factory<_i363.NotificationsBloc>(
      () => _i363.NotificationsBloc(
        gh<_i732.GetUserPreferencesUseCase>(),
        gh<_i909.SetUserNotificationsUseCase>(),
      ),
    );
    gh.factory<_i76.ThemeBloc>(
      () => _i76.ThemeBloc(
        gh<_i829.GetUserThemeUseCase>(),
        gh<_i158.SetUserThemeUseCase>(),
      ),
    );
    gh.factory<_i105.LocaleBloc>(
      () => _i105.LocaleBloc(
        gh<_i640.GetUserLanguageUseCase>(),
        gh<_i1013.SetUserLanguageUseCase>(),
      ),
    );
  }
}
