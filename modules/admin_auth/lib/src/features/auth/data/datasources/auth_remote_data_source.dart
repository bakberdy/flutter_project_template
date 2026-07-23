import 'package:admin_auth/src/common/config/constants/admin_auth_api_endpoints.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

abstract class AuthRemoteDataSource {
  Future<AuthLoginResponseModel> login(AuthLoginRequestModel request);
  Future<AuthVerifyResponseModel> verify(AuthVerifyRequestModel request);
  Future<AuthVerifyResponseModel> refreshToken(String refreshToken);
  Future<void> setNotificationToken(String token, String provider);
}

@Singleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(
    @Named('publicApiClient') this._publicApiClient,
    @Named('protectedApiClient') this._protectedApiClient,
  );
  static const _authorizationHeader = 'Authorization';
  static const _bearerPrefix = 'Bearer';

  final ApiClient _publicApiClient;
  final ApiClient _protectedApiClient;

  @override
  Future<AuthLoginResponseModel> login(AuthLoginRequestModel request) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      AdminAuthApiEndpoints.login,
      data: request.toJson(),
    );
    return AuthLoginResponseModel.fromJson(response.data!);
  }

  @override
  Future<AuthVerifyResponseModel> verify(AuthVerifyRequestModel request) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      AdminAuthApiEndpoints.verifyEmail,
      data: request.toJson(),
    );
    return AuthVerifyResponseModel.fromJson(response.data!);
  }

  @override
  Future<AuthVerifyResponseModel> refreshToken(String refreshToken) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      AdminAuthApiEndpoints.refresh,
      data: {'refresh_token': refreshToken},
      options: ApiOptions(
        headers: {_authorizationHeader: '$_bearerPrefix $refreshToken'},
      ),
    );
    return AuthVerifyResponseModel.fromJson(response.data!);
  }

  @override
  Future<void> setNotificationToken(String token, String provider) async {
    await _protectedApiClient.patch<void>(
      AdminAuthApiEndpoints.deviceNotifications,
      data: {'push_token': token, 'push_provider': provider},
    );
  }
}
