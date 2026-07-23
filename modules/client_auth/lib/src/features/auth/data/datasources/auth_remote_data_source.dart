import 'package:client_auth/src/common/config/constants/client_auth_api_endpoints.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

abstract class AuthRemoteDataSource {
  Future<AuthLoginResponseModel> login(AuthLoginRequestModel request);
  Future<AuthVerifyResponseModel> verify(AuthVerifyRequestModel request);
  Future<AuthVerifyResponseModel> refreshToken(String refreshToken);
}

@Singleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(@Named('publicApiClient') this._publicApiClient);
  static const _authorizationHeader = 'Authorization';
  static const _bearerPrefix = 'Bearer';

  final ApiClient _publicApiClient;

  @override
  Future<AuthLoginResponseModel> login(AuthLoginRequestModel request) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      ClientAuthApiEndpoints.login,
      data: request.toJson(),
    );
    return AuthLoginResponseModel.fromJson(response.data!);
  }

  @override
  Future<AuthVerifyResponseModel> verify(AuthVerifyRequestModel request) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      ClientAuthApiEndpoints.verifyEmail,
      data: request.toJson(),
    );
    return AuthVerifyResponseModel.fromJson(response.data!);
  }

  @override
  Future<AuthVerifyResponseModel> refreshToken(String refreshToken) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      ClientAuthApiEndpoints.refresh,
      data: {'refresh_token': refreshToken},
      options: ApiOptions(
        headers: {_authorizationHeader: '$_bearerPrefix $refreshToken'},
      ),
    );
    return AuthVerifyResponseModel.fromJson(response.data!);
  }
}
