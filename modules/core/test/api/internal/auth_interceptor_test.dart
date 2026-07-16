import 'dart:async';
import 'dart:convert';

import 'package:core/api/internal/auth_interceptor.dart';
import 'package:core/api/internal/auth_token_refresher.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
  });

  test('clears tokens and notifies the app after a final 401', () async {
    final tokenStorage = _MockTokenStorage();
    _stubTokenStorage(tokenStorage, _TokenState());
    final adapter = _MockHttpClientAdapter();
    _stubUnauthorizedAdapter(adapter);
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final refreshDio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    var unauthorizedNotifications = 0;

    dio
      ..httpClientAdapter = adapter
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
    verify(tokenStorage.clearTokens).called(1);
    expect(unauthorizedNotifications, 1);
  });

  test('uses refresh token without passing through auth interceptor', () async {
    final tokenStorage = _MockTokenStorage();
    final tokenState = _TokenState(
      accessToken: 'expired-access',
      refreshToken: 'valid-refresh',
    );
    _stubTokenStorage(tokenStorage, tokenState);
    final protectedAdapter = _MockHttpClientAdapter();
    final protectedState = _stubRetryAdapter(protectedAdapter);
    final refreshAdapter = _MockHttpClientAdapter();
    final refreshState = _stubRefreshAdapter(refreshAdapter, statusCode: 200);
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
    expect(refreshState.authorization, 'Bearer valid-refresh');
    expect(tokenState.accessToken, 'new-access');
    expect(tokenState.refreshToken, 'new-refresh');
    expect(protectedState.requests, 2);
  });

  test('notifies only once when refresh is rejected', () async {
    final tokenStorage = _MockTokenStorage();
    final tokenState = _TokenState(
      accessToken: 'expired-access',
      refreshToken: 'expired-refresh',
    );
    _stubTokenStorage(tokenStorage, tokenState);
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final refreshDio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final protectedAdapter = _MockHttpClientAdapter();
    _stubUnauthorizedAdapter(protectedAdapter);
    final refreshAdapter = _MockHttpClientAdapter();
    final refreshState = _stubRefreshAdapter(refreshAdapter, statusCode: 401);
    var unauthorizedNotifications = 0;

    dio
      ..httpClientAdapter = protectedAdapter
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

    expect(refreshState.authorization, 'Bearer expired-refresh');
    verify(tokenStorage.clearTokens).called(1);
    expect(unauthorizedNotifications, 1);
  });

  test('deduplicates unauthorized cleanup for concurrent requests', () async {
    final tokenStorage = _MockTokenStorage();
    final tokenState = _TokenState(
      accessToken: 'expired-access',
      refreshToken: 'expired-refresh',
    );
    _stubTokenStorage(tokenStorage, tokenState);
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final refreshDio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final notificationCompleter = Completer<void>();
    var unauthorizedNotifications = 0;

    final protectedAdapter = _MockHttpClientAdapter();
    _stubUnauthorizedAdapter(protectedAdapter);
    final refreshAdapter = _MockHttpClientAdapter();
    _stubRefreshAdapter(refreshAdapter, statusCode: 401);

    dio
      ..httpClientAdapter = protectedAdapter
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
    refreshDio.httpClientAdapter = refreshAdapter;

    final requests = Future.wait([
      dio.get<void>('/users/me'),
      dio.get<void>('/users/me/profile'),
    ]);
    unawaited(Future<void>.microtask(notificationCompleter.complete));

    await expectLater(requests, throwsA(isA<DioException>()));
    verify(tokenStorage.clearTokens).called(1);
    expect(unauthorizedNotifications, 1);
  });
}

void _stubUnauthorizedAdapter(_MockHttpClientAdapter adapter) {
  when(() => adapter.fetch(any(), any(), any())).thenAnswer(
    (_) async => ResponseBody.fromString(
      jsonEncode({'message': 'Unauthorized'}),
      401,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    ),
  );
}

_RetryState _stubRetryAdapter(_MockHttpClientAdapter adapter) {
  final state = _RetryState();
  when(() => adapter.fetch(any(), any(), any())).thenAnswer((_) async {
    state.requests++;
    return ResponseBody.fromString('', state.requests == 1 ? 401 : 200);
  });
  return state;
}

_RefreshState _stubRefreshAdapter(
  _MockHttpClientAdapter adapter, {
  required int statusCode,
}) {
  final state = _RefreshState();
  when(() => adapter.fetch(any(), any(), any())).thenAnswer((invocation) async {
    final options = invocation.positionalArguments.first as RequestOptions;
    state.authorization = options.headers['Authorization'] as String?;
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
  });
  return state;
}

void _stubTokenStorage(_MockTokenStorage storage, _TokenState state) {
  when(() => storage.clearTokens()).thenAnswer((_) async {
    state.accessToken = null;
    state.refreshToken = null;
  });
  when(
    () => storage.containsRefreshToken(),
  ).thenAnswer((_) async => state.refreshToken != null);
  when(
    () => storage.getAccessToken(),
  ).thenAnswer((_) async => state.accessToken);
  when(
    () => storage.getRefreshToken(),
  ).thenAnswer((_) async => state.refreshToken);
  when(() => storage.saveAccessToken(any())).thenAnswer((invocation) async {
    state.accessToken = invocation.positionalArguments.first as String;
  });
  when(() => storage.saveRefreshToken(any())).thenAnswer((invocation) async {
    state.refreshToken = invocation.positionalArguments.first as String;
  });
}

class _TokenState {
  _TokenState({this.accessToken, this.refreshToken});

  String? accessToken;
  String? refreshToken;
}

class _RetryState {
  int requests = 0;
}

class _RefreshState {
  String? authorization;
}

class _MockHttpClientAdapter extends Mock implements HttpClientAdapter {}

class _MockTokenStorage extends Mock implements TokenStorage {}
