import 'dart:convert';
import 'dart:typed_data';

import 'package:core/api/internal/auth_interceptor.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('clears tokens and notifies the app after a final 401', () async {
    final tokenStorage = _FakeTokenStorage();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    var unauthorizedNotifications = 0;

    dio
      ..httpClientAdapter = _UnauthorizedAdapter()
      ..interceptors.add(
        AuthInterceptor(
          dio,
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

class _FakeTokenStorage implements TokenStorage {
  int clearCalls = 0;

  @override
  Future<void> clearTokens() async => clearCalls++;

  @override
  Future<bool> containsRefreshToken() async => false;

  @override
  Future<String?> getAccessToken() async => null;

  @override
  Future<String?> getRefreshToken() async => null;

  @override
  Future<void> saveAccessToken(String token) async {}

  @override
  Future<void> saveRefreshToken(String token) async {}
}
