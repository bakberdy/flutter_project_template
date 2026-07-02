import 'package:core/config/app_config.dart';
import 'package:core/config/core_app_config.dart';
import 'package:core/api/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

@module
abstract class CoreModule {
  @singleton
  AppConfig get appConfig => AppConfig.instance;

  @singleton
  CoreAppConfig get coreAppConfig => AppConfig.instance;

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences async =>
      await SharedPreferences.getInstance();

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @singleton
  Talker get talker => Talker();

  @lazySingleton
  ApiClientFactory apiClientFactory(TokenStorage tokenStorage) =>
      ApiClientFactory(tokenStorage: tokenStorage);

  @Named('protectedApiClient')
  @lazySingleton
  ApiClient protectedApiClient(
    AppConfig appConfig,
    ApiClientFactory apiClientFactory,
  ) {
    return apiClientFactory.createProtected(
      config: ApiConfig(
        baseUrl: appConfig.baseUrl,
        connectTimeout: appConfig.connectTimeout,
        receiveTimeout: appConfig.receiveTimeout,
        sendTimeout: appConfig.sendTimeout,
        defaultHeaders: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  @Named('publicApiClient')
  @lazySingleton
  ApiClient publicApiClient(
    AppConfig appConfig,
    ApiClientFactory apiClientFactory,
  ) {
    return apiClientFactory.createPublic(
      config: ApiConfig(
        baseUrl: appConfig.baseUrl,
        connectTimeout: appConfig.connectTimeout,
        receiveTimeout: appConfig.receiveTimeout,
        sendTimeout: appConfig.sendTimeout,
        defaultHeaders: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }
}
