import 'package:core/core.dart';
import 'package:admin_auth/src/common/config/admin_auth_api_endpoints.dart';
import 'package:admin_auth/src/features/sessions/data/models/session_model/session_model.dart';
import 'package:admin_auth/src/features/sessions/domain/entities/session.dart';
import 'package:injectable/injectable.dart';

abstract class SessionsRemoteDataSource {
  Future<PaginatedResponse<Session>> getSessions({
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
  Future<PaginatedResponse<Session>> getSessions({
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
      AdminAuthApiEndpoints.sessions,
      queryParameters: queryParameters,
    );
    return PaginatedResponseModel<Session>.fromJson(
      response.data!,
      (Object? json) => SessionModel.fromJson(json! as Map<String, dynamic>),
    );
  }

  @override
  Future<void> revokeSession(String sessionId) async {
    await _apiClient.delete<void>(AdminAuthApiEndpoints.session(sessionId));
  }

  @override
  Future<void> revokeAllSessions() async {
    await _apiClient.delete<void>(AdminAuthApiEndpoints.sessions);
  }
}
