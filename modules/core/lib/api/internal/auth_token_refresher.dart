import 'package:core/api/storage/token_storage.dart';
import 'package:core/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';

class AuthTokenRefresher {
  AuthTokenRefresher(this._dio, this._tokenStorage);

  static const refreshPath = '/auth/refresh';

  final Dio _dio;
  final TokenStorage _tokenStorage;

  Future<void> refresh() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      throw StateError('No refresh token');
    }

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
      throw StateError('Token refresh failed');
    }

    final newAccessToken = response.data!['access_token'] as String?;
    final newRefreshToken = response.data!['refresh_token'] as String?;
    if (newAccessToken == null) {
      throw StateError('Missing access_token in response');
    }

    await _tokenStorage.saveAccessToken(newAccessToken);
    if (newRefreshToken != null) {
      await _tokenStorage.saveRefreshToken(newRefreshToken);
    }
  }
}
