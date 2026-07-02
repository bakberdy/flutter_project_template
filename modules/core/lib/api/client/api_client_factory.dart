part of 'api_client.dart';

class ApiClientFactory {
  const ApiClientFactory({required this.tokenStorage, required this.talker});

  final TokenStorage tokenStorage;
  final Talker talker;

  ApiClient createPublic({required ApiConfig config}) {
    return ApiClient._(_createDio(config: config));
  }

  ApiClient createProtected({required ApiConfig config}) {
    final dio = _createDio(config: config);
    dio.interceptors.add(AuthInterceptor(dio, tokenStorage));

    return ApiClient._(dio);
  }

  Dio _createDio({required ApiConfig config}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        sendTimeout: config.sendTimeout,
        headers: config.defaultHeaders,
      ),
    );
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          hiddenHeaders: {'authorization'},
          printRequestHeaders: true,
          printResponseTime: true,
        ),
      ),
    );

    return dio;
  }
}
