import 'package:client_auth/src/common/config/constants/client_auth_api_endpoints.dart';
import 'package:client_auth/src/features/auth/data/models/auth_login_request_model/auth_login_request_model.dart';
import 'package:client_auth/src/features/auth/data/models/login_response_model/login_response_model.dart';
import 'package:client_auth/src/features/auth/data/models/verify_request_model/verify_request_model.dart';
import 'package:client_auth/src/features/auth/data/models/verify_response_model/verify_response_model.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(AuthLoginRequestModel request);
  Future<VerifyResponseModel> verify(VerifyRequestModel request);
  Future<VerifyResponseModel> refreshToken(String refreshToken);
}

@Singleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(@Named('publicApiClient') this._publicApiClient);
  static const _authorizationHeader = 'Authorization';
  static const _bearerPrefix = 'Bearer';

  final ApiClient _publicApiClient;

  @override
  Future<LoginResponseModel> login(AuthLoginRequestModel request) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      ClientAuthApiEndpoints.login,
      data: request.toJson(),
    );
    return LoginResponseModel.fromJson(response.data!);
  }

  @override
  Future<VerifyResponseModel> verify(VerifyRequestModel request) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      ClientAuthApiEndpoints.verifyEmail,
      data: request.toJson(),
    );
    return VerifyResponseModel.fromJson(response.data!);
  }

  @override
  Future<VerifyResponseModel> refreshToken(String refreshToken) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      ClientAuthApiEndpoints.refresh,
      data: {'refresh_token': refreshToken},
      options: ApiOptions(
        headers: {_authorizationHeader: '$_bearerPrefix $refreshToken'},
      ),
    );
    return VerifyResponseModel.fromJson(response.data!);
  }
}
