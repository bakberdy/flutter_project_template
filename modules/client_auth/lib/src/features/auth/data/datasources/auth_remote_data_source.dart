import 'package:core/core.dart';
import 'package:client_auth/src/features/auth/configs/api_endpoints.dart';
import 'package:client_auth/src/features/auth/data/models/authorization_login_request_json.dart';
import 'package:client_auth/src/features/auth/data/models/authorization_login_response_model/authorization_login_response_model.dart';
import 'package:client_auth/src/features/auth/data/models/authorization_verify_request_model/authorization_verify_request_model.dart';
import 'package:client_auth/src/features/auth/data/models/authorization_verify_response_model/authorization_verify_response_model.dart';
import 'package:client_auth/src/features/auth/domain/entities/auth_login_request.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(AuthLoginRequest request);
  Future<VerifyResponseModel> verify(VerifyRequestModel request);
  Future<VerifyResponseModel> refreshToken(String refreshToken);
  Future<void> logOut();
  Future<void> setNotificationToken(String token, String provider);
}

@Singleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const _authorizationHeader = 'Authorization';
  static const _bearerPrefix = 'Bearer';

  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(@Named('protectedApiClient') this._apiClient);

  @override
  Future<LoginResponseModel> login(AuthLoginRequest request) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      AuthApiEndpoints.login,
      data: AuthLoginRequestJson.toMap(request),
    );
    return LoginResponseModel.fromJson(response.data!);
  }

  @override
  Future<VerifyResponseModel> verify(VerifyRequestModel request) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      AuthApiEndpoints.verifyEmail,
      data: request.toJson(),
    );
    return VerifyResponseModel.fromJson(response.data!);
  }

  @override
  Future<VerifyResponseModel> refreshToken(String refreshToken) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      AuthApiEndpoints.refresh,
      data: {'refresh_token': refreshToken},
      options: ApiOptions(
        headers: {_authorizationHeader: '$_bearerPrefix $refreshToken'},
      ),
    );
    return VerifyResponseModel.fromJson(response.data!);
  }

  @override
  Future<void> logOut() async {
    await _apiClient.post<Map<String, dynamic>>(AuthApiEndpoints.logOut);
  }

  @override
  Future<void> setNotificationToken(String token, String provider) async {
    await _apiClient.patch<void>(
      AuthApiEndpoints.deviceNotifications,
      data: {'push_token': token, 'push_provider': provider},
    );
  }
}
