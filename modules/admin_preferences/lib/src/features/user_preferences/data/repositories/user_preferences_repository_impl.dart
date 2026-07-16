import 'dart:async';

import 'package:admin_preferences/src/common/config/admin_preferences_constants.dart';
import 'package:admin_preferences/src/features/user_preferences/data/datasources/user_preferences_local_data_source.dart';
import 'package:admin_preferences/src/features/user_preferences/data/datasources/user_preferences_remote_data_source.dart';
import 'package:admin_preferences/src/features/user_preferences/data/models/user_preferences_model/user_preferences_model.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/repositories/user_preferences_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserPreferencesRepository)
class UserPreferencesRepositoryImpl implements UserPreferencesRepository {
  final UserPreferencesLocalDataSource _localDataSource;
  final UserPreferencesRemoteDataSource _remoteDataSource;
  UserPreferencesRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  FutureEither<UserPreferences?> getPreferences() async {
    try {
      final remotePreferences = await _safeReadRemotePreferences();
      if (remotePreferences == null) {
        return Right(await _localPreferences());
      }
      await _cachePreferences(remotePreferences);
      return Right(remotePreferences);
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.getPreferences'));
    }
  }

  @override
  FutureEither<UserTheme?> getTheme() async {
    try {
      return Right(await _readLocalTheme());
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.getTheme'));
    }
  }

  @override
  FutureEither<UserLanguage?> getLanguage() async {
    try {
      return Right(await _readLocalLanguage());
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.getLanguage'));
    }
  }

  @override
  FutureEither<void> setTheme(UserTheme theme) async {
    try {
      await _writeLocalTheme(theme);
      unawaited(_syncPreferences(theme: theme));
      return const Right(null);
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.setTheme'));
    }
  }

  @override
  FutureEither<void> setLanguage(UserLanguage language) async {
    try {
      await _writeLocalLanguage(language);
      unawaited(_syncPreferences(language: language));
      return const Right(null);
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.setLanguage'));
    }
  }

  @override
  FutureEither<UserPreferences> setNotifications({
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? marketingNotificationsEnabled,
  }) async {
    try {
      final remotePreferences = await _safeReadRemotePreferences();
      if (remotePreferences == null) {
        return Right(
          await _createRemotePreferences(
            language: await _readLocalLanguage() ?? UserLanguage.en,
            theme: await _readLocalTheme() ?? UserTheme.system,
            pushNotificationsEnabled: pushNotificationsEnabled ?? true,
            emailNotificationsEnabled: emailNotificationsEnabled ?? true,
            marketingNotificationsEnabled:
                marketingNotificationsEnabled ?? false,
          ),
        );
      }

      final changedPush =
          pushNotificationsEnabled != null &&
              pushNotificationsEnabled !=
                  remotePreferences.pushNotificationsEnabled
          ? pushNotificationsEnabled
          : null;
      final changedEmail =
          emailNotificationsEnabled != null &&
              emailNotificationsEnabled !=
                  remotePreferences.emailNotificationsEnabled
          ? emailNotificationsEnabled
          : null;
      final changedMarketing =
          marketingNotificationsEnabled != null &&
              marketingNotificationsEnabled !=
                  remotePreferences.marketingNotificationsEnabled
          ? marketingNotificationsEnabled
          : null;

      if (changedPush == null &&
          changedEmail == null &&
          changedMarketing == null) {
        return Right(remotePreferences);
      }

      return Right(
        await _remoteDataSource.updatePreferences(
          pushNotificationsEnabled: changedPush,
          emailNotificationsEnabled: changedEmail,
          marketingNotificationsEnabled: changedMarketing,
        ),
      );
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.setNotifications'));
    }
  }

  Future<void> _syncPreferences({
    UserLanguage? language,
    UserTheme? theme,
  }) async {
    try {
      final remotePreferences = await _safeReadRemotePreferences();
      if (remotePreferences == null) {
        await _createRemotePreferences(
          language: language ?? await _readLocalLanguage() ?? UserLanguage.en,
          theme: theme ?? await _readLocalTheme() ?? UserTheme.system,
        );
        return;
      }

      if (language == null && theme == null) {
        return;
      }

      final changedLanguage =
          language != null && language != remotePreferences.language
          ? language
          : null;
      final changedTheme = theme != null && theme != remotePreferences.theme
          ? theme
          : null;
      if (changedLanguage == null && changedTheme == null) {
        await _cachePreferences(remotePreferences);
        return;
      }

      final updatedPreferences = await _remoteDataSource.updatePreferences(
        language: changedLanguage,
        theme: changedTheme,
      );
      await _cachePreferences(updatedPreferences);
    } on Exception {
      return;
    }
  }

  Future<UserPreferencesModel?> _safeReadRemotePreferences() async {
    try {
      return await _remoteDataSource.getPreferences();
    } on ApiException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 401) {
        return null;
      }
      rethrow;
    }
  }

  Future<UserPreferencesModel> _createRemotePreferences({
    required UserLanguage language,
    required UserTheme theme,
    bool pushNotificationsEnabled = true,
    bool emailNotificationsEnabled = true,
    bool marketingNotificationsEnabled = false,
  }) async {
    final preferences = await _remoteDataSource.createPreferences(
      language: language,
      theme: theme,
      pushNotificationsEnabled: pushNotificationsEnabled,
      emailNotificationsEnabled: emailNotificationsEnabled,
      marketingNotificationsEnabled: marketingNotificationsEnabled,
    );
    await _cachePreferences(preferences);
    return preferences;
  }

  Future<UserPreferences?> _localPreferences() async {
    final language = await _readLocalLanguage();
    final theme = await _readLocalTheme();
    if (language == null && theme == null) {
      return null;
    }

    final now = DateTime.now();
    return UserPreferences(
      userId: '',
      language: language ?? UserLanguage.en,
      theme: theme ?? UserTheme.system,
      pushNotificationsEnabled: true,
      emailNotificationsEnabled: true,
      marketingNotificationsEnabled: false,
      createdAt: now,
      updatedAt: now,
    );
  }

  Future<void> _cachePreferences(UserPreferences preferences) async {
    await _writeLocalLanguage(preferences.language);
    await _writeLocalTheme(preferences.theme);
  }

  Future<UserLanguage?> _readLocalLanguage() async {
    final value = await _localDataSource.getUserPreference(
      key: AdminPreferencesConstants.localeStorageKey,
    );
    if (value == null) {
      return null;
    }
    return const UserLanguageJsonConverter().fromJson(value);
  }

  Future<void> _writeLocalLanguage(UserLanguage language) =>
      _localDataSource.setUserPreference(
        key: AdminPreferencesConstants.localeStorageKey,
        value: const UserLanguageJsonConverter().toJson(language),
      );

  Future<UserTheme?> _readLocalTheme() async {
    final value = await _localDataSource.getUserPreference(
      key: AdminPreferencesConstants.themeModeStorageKey,
    );
    if (value == null) {
      return null;
    }
    return const UserThemeJsonConverter().fromJson(value);
  }

  Future<void> _writeLocalTheme(UserTheme theme) =>
      _localDataSource.setUserPreference(
        key: AdminPreferencesConstants.themeModeStorageKey,
        value: const UserThemeJsonConverter().toJson(theme),
      );
}
