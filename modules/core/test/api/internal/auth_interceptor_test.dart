import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:core/api/internal/auth_interceptor.dart';
import 'package:core/api/internal/auth_token_refresher.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('clears tokens and notifies the app after a final 401', () async {
    final tokenStorage = _FakeTokenStorage();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final refreshDio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    var unauthorizedNotifications = 0;

    dio
      ..httpClientAdapter = _UnauthorizedAdapter()
      ..interceptors.add(
        AuthInterceptor(
          dio,
          AuthTokenRefresher(refreshDio, tokenStorage),
          tokenStorage,
          onUnauthorized: () async => unauthorizedNotifications++,
        ),
      );

    await expectLater(
      dio.patch<void>('/users/me/profile'),
      throwsA(
        isA<DioException>().having(
          (error) => error.response?.statusCode,
          'status code',
          401,
        ),
      ),
    );
    expect(tokenStorage.clearCalls, 1);
    expect(unauthorizedNotifications, 1);
  });

  test('uses refresh token without passing through auth interceptor', () async {
    final tokenStorage = _FakeTokenStorage(
      accessToken: 'expired-access',
      refreshToken: 'valid-refresh',
    );
    final protectedAdapter = _RetryAdapter();
    final refreshAdapter = _RefreshAdapter(statusCode: 200);
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final refreshDio = Dio(BaseOptions(baseUrl: 'https://example.test'));

    dio
      ..httpClientAdapter = protectedAdapter
      ..interceptors.add(
        AuthInterceptor(
          dio,
          AuthTokenRefresher(refreshDio, tokenStorage),
          tokenStorage,
        ),
      );
    refreshDio.httpClientAdapter = refreshAdapter;

    final response = await dio.patch<void>('/users/me/profile');

    expect(response.statusCode, 200);
    expect(refreshAdapter.authorization, 'Bearer valid-refresh');
    expect(tokenStorage.accessToken, 'new-access');
    expect(tokenStorage.refreshToken, 'new-refresh');
    expect(protectedAdapter.requests, 2);
  });

  test('notifies only once when refresh is rejected', () async {
    final tokenStorage = _FakeTokenStorage(
      accessToken: 'expired-access',
      refreshToken: 'expired-refresh',
    );
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final refreshDio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final refreshAdapter = _RefreshAdapter(statusCode: 401);
    var unauthorizedNotifications = 0;

    dio
      ..httpClientAdapter = _UnauthorizedAdapter()
      ..interceptors.add(
        AuthInterceptor(
          dio,
          AuthTokenRefresher(refreshDio, tokenStorage),
          tokenStorage,
          onUnauthorized: () async => unauthorizedNotifications++,
        ),
      );
    refreshDio.httpClientAdapter = refreshAdapter;

    await expectLater(
      dio.patch<void>('/users/me/profile'),
      throwsA(isA<DioException>()),
    );

    expect(refreshAdapter.authorization, 'Bearer expired-refresh');
    expect(tokenStorage.clearCalls, 1);
    expect(unauthorizedNotifications, 1);
  });

  test('deduplicates unauthorized cleanup for concurrent requests', () async {
    final tokenStorage = _FakeTokenStorage(
      accessToken: 'expired-access',
      refreshToken: 'expired-refresh',
    );
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final refreshDio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final notificationCompleter = Completer<void>();
    var unauthorizedNotifications = 0;

    dio
      ..httpClientAdapter = _UnauthorizedAdapter()
      ..interceptors.add(
        AuthInterceptor(
          dio,
          AuthTokenRefresher(refreshDio, tokenStorage),
          tokenStorage,
          onUnauthorized: () async {
            unauthorizedNotifications++;
            await notificationCompleter.future;
          },
        ),
      );
    refreshDio.httpClientAdapter = _RefreshAdapter(statusCode: 401);

    final requests = Future.wait([
      dio.get<void>('/users/me'),
      dio.get<void>('/users/me/profile'),
    ]);
    unawaited(Future<void>.microtask(notificationCompleter.complete));

    await expectLater(requests, throwsA(isA<DioException>()));
    expect(tokenStorage.clearCalls, 1);
    expect(unauthorizedNotifications, 1);
  });
}

class _UnauthorizedAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    jsonEncode({'message': 'Unauthorized'}),
    401,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

class _RetryAdapter implements HttpClientAdapter {
  int requests = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests++;
    return ResponseBody.fromString('', requests == 1 ? 401 : 200);
  }

  @override
  void close({bool force = false}) {}
}

class _RefreshAdapter implements HttpClientAdapter {
  _RefreshAdapter({required this.statusCode});

  final int statusCode;
  String? authorization;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    authorization = options.headers['Authorization'] as String?;
    return ResponseBody.fromString(
      jsonEncode(
        statusCode == 200
            ? {'access_token': 'new-access', 'refresh_token': 'new-refresh'}
            : {'message': 'Unauthorized'},
      ),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FakeTokenStorage implements TokenStorage {
  _FakeTokenStorage({this.accessToken, this.refreshToken});

  int clearCalls = 0;
  String? accessToken;
  String? refreshToken;

  @override
  Future<void> clearTokens() async {
    clearCalls++;
    accessToken = null;
    refreshToken = null;
  }

  @override
  Future<bool> containsRefreshToken() async => refreshToken != null;

  @override
  Future<String?> getAccessToken() async => accessToken;

  @override
  Future<String?> getRefreshToken() async => refreshToken;

  @override
  Future<void> saveAccessToken(String token) async => accessToken = token;

  @override
  Future<void> saveRefreshToken(String token) async => refreshToken = token;
}
