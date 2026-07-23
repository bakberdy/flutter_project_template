import 'package:client_profile/src/common/config/constants/client_profile_api_endpoints.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

abstract class SessionsRemoteDataSource {
  Future<PaginatedResponse<UserSession>> getSessions({
    required int pageNumber,
    required int limit,
    bool? isActive,
    ApiCancelToken? cancelToken,
  });

  Future<void> revokeSession(String sessionId);
  Future<void> revokeAllSessions();
}

@Singleton(as: SessionsRemoteDataSource)
class SessionsRemoteDataSourceImpl implements SessionsRemoteDataSource {
  SessionsRemoteDataSourceImpl(@Named('protectedApiClient') this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<PaginatedResponse<UserSession>> getSessions({
    required int pageNumber,
    required int limit,
    bool? isActive,
    ApiCancelToken? cancelToken,
  }) async {
    final queryParameters = <String, dynamic>{
      'page_number': pageNumber,
      'limit': limit,
    };
    if (isActive != null) {
      queryParameters['is_active'] = isActive;
    }
    final response = await _apiClient.get<Map<String, dynamic>>(
      ClientProfileApiEndpoints.sessions,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    return PaginatedResponseModel<UserSession>.fromJson(
      response.data ??
          (throw const FormatException('Missing sessions response data')),
      (Object? json) => UserSessionModel.fromJson(_requireJsonMap(json)),
    );
  }

  @override
  Future<void> revokeSession(String sessionId) async {
    await _apiClient.delete<void>(ClientProfileApiEndpoints.session(sessionId));
  }

  @override
  Future<void> revokeAllSessions() async {
    await _apiClient.delete<void>(ClientProfileApiEndpoints.sessions);
  }
}

Map<String, dynamic> _requireJsonMap(Object? json) {
  if (json case final Map<String, dynamic> value) {
    return value;
  }
  throw const FormatException('Invalid session response data');
}
