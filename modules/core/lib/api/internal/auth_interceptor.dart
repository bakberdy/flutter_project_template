import 'package:dio/dio.dart';

import '../../utils/constants/api_constants.dart';
import '../storage/token_storage.dart';
import 'auth_token_refresher.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(
    this._dio,
    this._tokenRefresher,
    this._tokenStorage, {
    this.onUnauthorized,
  });

  final Dio _dio;
  final AuthTokenRefresher _tokenRefresher;
  final TokenStorage _tokenStorage;
  final Future<void> Function()? onUnauthorized;

  bool _isRefreshing = false;
  Future<void>? _refreshFuture;
  Future<void>? _unauthorizedFuture;
  bool _sessionInvalidated = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _tokenStorage.getAccessToken();
      if (token != null) {
        _sessionInvalidated = false;
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
    if (path.contains(AuthTokenRefresher.refreshPath) ||
        path.contains('refresh')) {
      await _handleUnauthorized();
      return handler.reject(_toUnauthorizedError(err));
    }

    final hasRefresh = await _tokenStorage.containsRefreshToken();
    if (!hasRefresh) {
      await _handleUnauthorized();
      return handler.reject(_toUnauthorizedError(err));
    }

    try {
      if (!_isRefreshing) {
        _isRefreshing = true;
        _refreshFuture = _tokenRefresher.refresh().whenComplete(
          () => _isRefreshing = false,
        );
      }
      await _refreshFuture;

      final response = await _retry(err.requestOptions);
      return handler.resolve(response);
    } catch (_) {
      await _handleUnauthorized();
      return handler.reject(_toUnauthorizedError(err));
    }
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

  Future<void> _handleUnauthorized() {
    if (_sessionInvalidated) {
      return Future<void>.value();
    }

    final activeCleanup = _unauthorizedFuture;
    if (activeCleanup != null) {
      return activeCleanup;
    }

    final cleanup = _clearUnauthorizedSession();
    _sessionInvalidated = true;
    _unauthorizedFuture = cleanup;
    return cleanup.whenComplete(() {
      if (identical(_unauthorizedFuture, cleanup)) {
        _unauthorizedFuture = null;
      }
    });
  }

  Future<void> _clearUnauthorizedSession() async {
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
}
