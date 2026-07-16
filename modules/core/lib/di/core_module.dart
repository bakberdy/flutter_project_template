import 'package:core/api/api.dart';
import 'package:core/config/core_app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

@module
abstract class CoreModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences async =>
      await SharedPreferences.getInstance();

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @singleton
  Talker get talker => TalkerFlutter.init();

  @lazySingleton
  ApiClientFactory apiClientFactory(TokenStorage tokenStorage, Talker talker) =>
      ApiClientFactory(tokenStorage: tokenStorage, talker: talker);

  @Named('protectedApiClient')
  @lazySingleton
  ApiClient protectedApiClient(
    CoreAppConfig appConfig,
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
    CoreAppConfig appConfig,
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
