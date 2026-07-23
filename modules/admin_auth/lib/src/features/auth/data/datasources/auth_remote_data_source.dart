import 'package:admin_auth/src/common/config/admin_auth_api_endpoints.dart';
import 'package:admin_auth/src/features/auth/data/models/auth_login_request_model/auth_login_request_model.dart';
import 'package:admin_auth/src/features/auth/data/models/login_response_model/login_response_model.dart';
import 'package:admin_auth/src/features/auth/data/models/verify_request_model/verify_request_model.dart';
import 'package:admin_auth/src/features/auth/data/models/verify_response_model/verify_response_model.dart';
import 'package:admin_auth/src/features/auth/domain/entities/auth_login_request.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(AuthLoginRequest request);
  Future<VerifyResponseModel> verify(VerifyRequestModel request);
  Future<VerifyResponseModel> refreshToken(String refreshToken);
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
  Future<LoginResponseModel> login(AuthLoginRequest request) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      AdminAuthApiEndpoints.login,
      data: AuthLoginRequestModel.fromEntity(request).toJson(),
    );
    return LoginResponseModel.fromJson(response.data!);
  }

  @override
  Future<VerifyResponseModel> verify(VerifyRequestModel request) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      AdminAuthApiEndpoints.verifyEmail,
      data: request.toJson(),
    );
    return VerifyResponseModel.fromJson(response.data!);
  }

  @override
  Future<VerifyResponseModel> refreshToken(String refreshToken) async {
    final response = await _publicApiClient.post<Map<String, dynamic>>(
      AdminAuthApiEndpoints.refresh,
      data: {'refresh_token': refreshToken},
      options: ApiOptions(
        headers: {_authorizationHeader: '$_bearerPrefix $refreshToken'},
      ),
    );
    return VerifyResponseModel.fromJson(response.data!);
  }

  @override
  Future<void> setNotificationToken(String token, String provider) async {
    await _protectedApiClient.patch<void>(
      AdminAuthApiEndpoints.deviceNotifications,
      data: {'push_token': token, 'push_provider': provider},
    );
  }
}
