part of 'api_client.dart';

class ApiClientFactory {
  const ApiClientFactory({required this.tokenStorage, this.onUnauthorized});

  final TokenStorage tokenStorage;
  final FutureOr<void> Function()? onUnauthorized;

  ApiClient create({
    required ApiConfig config,
    String? baseUrl,
    bool? enableAuthInterceptor,
  }) {
    final effectiveConfig = baseUrl == null
        ? config
        : config.copyWith(baseUrl: baseUrl);

    final dio = Dio(
      BaseOptions(
        baseUrl: effectiveConfig.baseUrl,
        connectTimeout: effectiveConfig.connectTimeout,
        receiveTimeout: effectiveConfig.receiveTimeout,
        sendTimeout: effectiveConfig.sendTimeout,
        headers: effectiveConfig.defaultHeaders,
      ),
    );

    final useAuth =
        enableAuthInterceptor ?? effectiveConfig.enableAuthInterceptor;
    if (useAuth) {
      dio.interceptors.add(
        AuthInterceptor(
          dio,
          tokenStorage,
          onUnauthorized: onUnauthorized,
          publicPaths: effectiveConfig.publicPaths,
          refreshPath: effectiveConfig.refreshPath,
        ),
      );
    }

    return ApiClient._(dio);
  }
}
