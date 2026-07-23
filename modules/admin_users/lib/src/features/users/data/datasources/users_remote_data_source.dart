import 'package:admin_users/src/common/config/constants/admin_users_api_endpoints.dart';
import 'package:admin_users/src/features/users/data/mappers/users_api_mapper.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

abstract class UsersRemoteDataSource {
  Future<PaginatedResponseModel<UserModel>> getUsers(
    UsersQuery query, {
    ApiCancelToken? cancelToken,
  });

  Future<UserModel> getUser(String userId, {ApiCancelToken? cancelToken});

  Future<UserProfileModel> getUserProfile(
    String userId, {
    ApiCancelToken? cancelToken,
  });

  Future<UserModel> changeUserStatus(
    String userId,
    UserStatus status,
  );

  Future<UserModel> changeUserRole(String userId, UserRole role);

  Future<UserModel> approveDeletionRequest(String userId);
}

@Singleton(as: UsersRemoteDataSource)
class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  const UsersRemoteDataSourceImpl(@Named('protectedApiClient') this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<PaginatedResponseModel<UserModel>> getUsers(
    UsersQuery query, {
    ApiCancelToken? cancelToken,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      AdminUsersApiEndpoints.users,
      queryParameters: {
        'page_number': query.pageNumber,
        'limit': query.limit,
        'sorting_method': query.sortDirection.apiValue,
        'sort_key': query.sortField.apiValue,
        'status': ?query.status?.apiValue,
        'role': ?query.role?.apiValue,
        'is_verified': ?query.isVerified,
        'is_profile_completed': ?query.isProfileCompleted,
        'created_at_from': ?query.createdAtFrom?.toUtc().toIso8601String(),
        'created_at_to': ?query.createdAtTo?.toUtc().toIso8601String(),
        'search': ?query.search,
      },
      cancelToken: cancelToken,
    );
    final data = response.data;
    if (data == null) {
      throw const FormatException('Missing users response data');
    }
    return PaginatedResponseModel.fromJson(
      data,
      (json) => UserModel.fromJson(_requireJsonMap(json)),
    );
  }

  @override
  Future<UserModel> getUser(
    String userId, {
    ApiCancelToken? cancelToken,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      AdminUsersApiEndpoints.user(userId),
      cancelToken: cancelToken,
    );
    return UserModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserProfileModel> getUserProfile(
    String userId, {
    ApiCancelToken? cancelToken,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      AdminUsersApiEndpoints.profile(userId),
      cancelToken: cancelToken,
    );
    return UserProfileModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserModel> changeUserStatus(
    String userId,
    UserStatus status,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      AdminUsersApiEndpoints.status(userId),
      data: {'status': status.apiValue},
    );
    return UserModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserModel> changeUserRole(
    String userId,
    UserRole role,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      AdminUsersApiEndpoints.role(userId),
      data: {'role': role.apiValue},
    );
    return UserModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserModel> approveDeletionRequest(String userId) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      AdminUsersApiEndpoints.approveDeletionRequest(userId),
    );
    return UserModel.fromJson(_requireData(response.data));
  }

  Map<String, dynamic> _requireData(Map<String, dynamic>? data) {
    if (data == null) {
      throw const FormatException('Missing user response data');
    }
    return data;
  }

  Map<String, dynamic> _requireJsonMap(Object? json) {
    if (json case final Map<String, dynamic> value) {
      return value;
    }
    throw const FormatException('Invalid user response data');
  }
}
