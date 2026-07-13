import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_users/src/common/config/admin_users_api_endpoints.dart';
import 'package:admin_users/src/features/users/data/mappers/users_api_mapper.dart';
import 'package:admin_users/src/features/users/data/models/admin_user_model/admin_user_model.dart';
import 'package:admin_users/src/features/users/data/models/admin_user_profile_model/admin_user_profile_model.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';

abstract class UsersRemoteDataSource {
  Future<PaginatedResponseModel<AdminUserModel>> getUsers(
    UsersQuery query, {
    ApiCancelToken? cancelToken,
  });

  Future<AdminUserModel> getUser(String userId, {ApiCancelToken? cancelToken});

  Future<AdminUserProfileModel> getUserProfile(
    String userId, {
    ApiCancelToken? cancelToken,
  });

  Future<AdminUserModel> changeUserStatus(
    String userId,
    AdminUserStatus status,
  );

  Future<AdminUserModel> changeUserRole(String userId, AdminUserRole role);

  Future<AdminUserModel> approveDeletionRequest(String userId);
}

@Singleton(as: UsersRemoteDataSource)
class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  const UsersRemoteDataSourceImpl(@Named('protectedApiClient') this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<PaginatedResponseModel<AdminUserModel>> getUsers(
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
      (json) => AdminUserModel.fromJson(json! as Map<String, dynamic>),
    );
  }

  @override
  Future<AdminUserModel> getUser(
    String userId, {
    ApiCancelToken? cancelToken,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      AdminUsersApiEndpoints.user(userId),
      cancelToken: cancelToken,
    );
    return AdminUserModel.fromJson(_requireData(response.data));
  }

  @override
  Future<AdminUserProfileModel> getUserProfile(
    String userId, {
    ApiCancelToken? cancelToken,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      AdminUsersApiEndpoints.profile(userId),
      cancelToken: cancelToken,
    );
    return AdminUserProfileModel.fromJson(_requireData(response.data));
  }

  @override
  Future<AdminUserModel> changeUserStatus(
    String userId,
    AdminUserStatus status,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      AdminUsersApiEndpoints.status(userId),
      data: {'status': status.apiValue},
    );
    return AdminUserModel.fromJson(_requireData(response.data));
  }

  @override
  Future<AdminUserModel> changeUserRole(
    String userId,
    AdminUserRole role,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      AdminUsersApiEndpoints.role(userId),
      data: {'role': role.apiValue},
    );
    return AdminUserModel.fromJson(_requireData(response.data));
  }

  @override
  Future<AdminUserModel> approveDeletionRequest(String userId) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      AdminUsersApiEndpoints.approveDeletionRequest(userId),
    );
    return AdminUserModel.fromJson(_requireData(response.data));
  }

  Map<String, dynamic> _requireData(Map<String, dynamic>? data) {
    if (data == null) {
      throw const FormatException('Missing user response data');
    }
    return data;
  }
}
