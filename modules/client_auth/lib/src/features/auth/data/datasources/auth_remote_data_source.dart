import 'package:client_auth/src/common/config/client_auth_api_endpoints.dart';
import 'package:client_auth/src/features/auth/data/models/auth_login_request_json.dart';
import 'package:client_auth/src/features/auth/data/models/authorization_login_response_model/authorization_login_response_model.dart';
import 'package:client_auth/src/features/auth/data/models/authorization_verify_request_model/verify_request_model.dart';
import 'package:client_auth/src/features/auth/data/models/authorization_verify_response_model/authorization_verify_response_model.dart';
import 'package:client_auth/src/features/auth/domain/entities/auth_login_request.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(AuthLoginRequest request);
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
  Future<LoginResponseModel> login(AuthLoginRequest request) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      ClientAuthApiEndpoints.login,
      data: AuthLoginRequestJson.toMap(request),
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
