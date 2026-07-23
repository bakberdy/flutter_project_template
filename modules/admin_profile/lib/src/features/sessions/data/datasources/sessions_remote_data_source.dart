import 'package:admin_profile/src/common/config/constants/admin_profile_api_endpoints.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

abstract class SessionsRemoteDataSource {
  Future<PaginatedResponse<UserSession>> getSessions({
    required int pageNumber,
    required int limit,
    bool? isActive,
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
  }) async {
    final queryParameters = <String, dynamic>{
      'page_number': pageNumber,
      'limit': limit,
    };
    if (isActive != null) {
      queryParameters['is_active'] = isActive;
    }
    final response = await _apiClient.get<Map<String, dynamic>>(
      AdminProfileApiEndpoints.sessions,
      queryParameters: queryParameters,
    );
    return PaginatedResponseModel<UserSession>.fromJson(
      response.data ??
          (throw const FormatException('Missing sessions response data')),
      (Object? json) => UserSessionModel.fromJson(_requireJsonMap(json)),
    );
  }

  @override
  Future<void> revokeSession(String sessionId) async {
    await _apiClient.delete<void>(AdminProfileApiEndpoints.session(sessionId));
  }

  @override
  Future<void> revokeAllSessions() async {
    await _apiClient.delete<void>(AdminProfileApiEndpoints.sessions);
  }
}

Map<String, dynamic> _requireJsonMap(Object? json) {
  if (json case final Map<String, dynamic> value) {
    return value;
  }
  throw const FormatException('Invalid session response data');
}
