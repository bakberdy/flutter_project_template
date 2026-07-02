import 'dart:async';

import 'package:dio/dio.dart';

import '../../utils/constants/api_constants.dart';
import '../storage/token_storage.dart';

typedef UnauthorizedCallback = FutureOr<void> Function();

class AuthInterceptor extends Interceptor {
  AuthInterceptor(
    this._dio,
    this._tokenStorage, {
    this.onUnauthorized,
    this.refreshPath = '/auth/refresh',
    this.publicPaths = const [],
  });

  final Dio _dio;
  final TokenStorage _tokenStorage;
  final UnauthorizedCallback? onUnauthorized;
  final String refreshPath;
  final List<String> publicPaths;

  bool _isRefreshing = false;
  Future<void>? _refreshFuture;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isPublicPath(options.path)) return handler.next(options);

    try {
      final token = await _tokenStorage.getAccessToken();
      if (token != null) {
        options.headers[ApiConstants.authorizationHeader] =
            '${ApiConstants.bearerPrefix} $token';
      }
    } catch (_) {}

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) return handler.next(err);

    final path = err.requestOptions.path;
    if (path.contains(refreshPath) || path.contains('refresh')) {
      await _handleUnauthorized();
      return handler.reject(_toUnauthorizedError(err));
    }

    if (_isPublicPath(path)) return handler.next(err);

    final hasRefresh = await _tokenStorage.containsRefreshToken();
    if (!hasRefresh) {
      await _handleUnauthorized();
      return handler.reject(_toUnauthorizedError(err));
    }

    try {
      if (!_isRefreshing) {
        _isRefreshing = true;
        _refreshFuture = _doRefresh().whenComplete(() => _isRefreshing = false);
      }
      await _refreshFuture;

      final response = await _retry(err.requestOptions);
      return handler.resolve(response);
    } catch (_) {
      await _handleUnauthorized();
      return handler.reject(_toUnauthorizedError(err));
    }
  }

  Future<void> _doRefresh() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) throw Exception('No refresh token');

    final response = await _dio.post<Map<String, dynamic>>(
      refreshPath,
      data: {'refresh_token': refreshToken},
      options: Options(
        headers: {
          ApiConstants.authorizationHeader:
              '${ApiConstants.bearerPrefix} $refreshToken',
        },
      ),
    );

    if (response.statusCode != 200 || response.data == null) {
      throw Exception('Token refresh failed');
    }

    final newAccess = response.data!['access_token'] as String?;
    final newRefresh = response.data!['refresh_token'] as String?;

    if (newAccess == null) throw Exception('Missing access_token in response');

    await _tokenStorage.saveAccessToken(newAccess);
    if (newRefresh != null) await _tokenStorage.saveRefreshToken(newRefresh);
  }

  Future<Response<dynamic>> _retry(RequestOptions original) async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) throw Exception('No access token after refresh');

    return _dio.request<dynamic>(
      original.path,
      data: original.data,
      queryParameters: original.queryParameters,
      cancelToken: original.cancelToken,
      onReceiveProgress: original.onReceiveProgress,
      onSendProgress: original.onSendProgress,
      options: Options(
        method: original.method,
        headers: {
          ...original.headers,
          ApiConstants.authorizationHeader:
              '${ApiConstants.bearerPrefix} $token',
        },
        responseType: original.responseType,
        contentType: original.contentType,
        extra: original.extra,
        followRedirects: original.followRedirects,
        listFormat: original.listFormat,
        maxRedirects: original.maxRedirects,
        receiveDataWhenStatusError: original.receiveDataWhenStatusError,
        receiveTimeout: original.receiveTimeout,
        requestEncoder: original.requestEncoder,
        responseDecoder: original.responseDecoder,
        sendTimeout: original.sendTimeout,
        validateStatus: original.validateStatus,
      ),
    );
  }

  Future<void> _handleUnauthorized() async {
    await _tokenStorage.clearTokens();
    await onUnauthorized?.call();
  }

  DioException _toUnauthorizedError(DioException source) {
    final response =
        source.response ??
        Response(
          requestOptions: source.requestOptions,
          statusCode: 401,
          statusMessage: 'Unauthorized',
        );
    return DioException(
      requestOptions: source.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  bool _isPublicPath(String path) => publicPaths.any(path.contains);
}
