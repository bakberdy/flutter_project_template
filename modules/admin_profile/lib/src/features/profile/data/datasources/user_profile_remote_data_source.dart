import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:admin_profile/src/common/config/admin_profile_api_endpoints.dart';
import 'package:admin_profile/src/features/profile/domain/entities/user_avatar_upload.dart';
import 'package:injectable/injectable.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserModel> getCurrentUser({ApiCancelToken? cancelToken});

  Future<UserProfileModel> getCurrentProfile();

  Future<UserProfileModel> createProfile({
    required String fullName,
    UserPhoneNumberModel? phoneNumber,
  });

  Future<UserProfileModel> updateProfile({
    String? fullName,
    UserPhoneNumberModel? phoneNumber,
  });

  Future<UserProfileModel> updateAvatar(
    UserAvatarUpload avatar, {
    ApiProgressCallback? onSendProgress,
  });

  Future<UserProfileModel> removeAvatar();

  Future<UserModel> requestAccountDeletion();

  Future<void> logOut();
}

@Singleton(as: UserProfileRemoteDataSource)
class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final ApiClient _apiClient;

  UserProfileRemoteDataSourceImpl(@Named('protectedApiClient') this._apiClient);

  @override
  Future<UserModel> getCurrentUser({ApiCancelToken? cancelToken}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      AdminProfileApiEndpoints.me,
      cancelToken: cancelToken,
    );
    return UserModel.fromJson(response.data!);
  }

  @override
  Future<UserProfileModel> getCurrentProfile() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      AdminProfileApiEndpoints.profile,
    );
    return UserProfileModel.fromJson(response.data!);
  }

  @override
  Future<UserProfileModel> createProfile({
    required String fullName,
    UserPhoneNumberModel? phoneNumber,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      AdminProfileApiEndpoints.profile,
      data: {'full_name': fullName, 'phone_number': ?phoneNumber?.toJson()},
    );
    return UserProfileModel.fromJson(response.data!);
  }

  @override
  Future<UserProfileModel> updateProfile({
    String? fullName,
    UserPhoneNumberModel? phoneNumber,
  }) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      AdminProfileApiEndpoints.profile,
      data: {'full_name': ?fullName, 'phone_number': ?phoneNumber?.toJson()},
    );
    return UserProfileModel.fromJson(response.data!);
  }

  @override
  Future<UserProfileModel> updateAvatar(
    UserAvatarUpload avatar, {
    ApiProgressCallback? onSendProgress,
  }) async {
    final response = await _apiClient.put<Map<String, dynamic>>(
      AdminProfileApiEndpoints.avatar,
      data: ApiFormData(
        files: {
          'avatar': ApiMultipartFile(
            bytes: avatar.bytes,
            filename: avatar.filename,
            contentType: avatar.contentType,
          ),
        },
      ),
      options: const ApiOptions(contentType: 'multipart/form-data'),
      onSendProgress: onSendProgress,
    );
    return UserProfileModel.fromJson(response.data!);
  }

  @override
  Future<UserProfileModel> removeAvatar() async {
    final response = await _apiClient.delete<Map<String, dynamic>>(
      AdminProfileApiEndpoints.avatar,
    );
    return UserProfileModel.fromJson(response.data!);
  }

  @override
  Future<UserModel> requestAccountDeletion() async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      AdminProfileApiEndpoints.accountDeletion,
    );
    return UserModel.fromJson(response.data!);
  }

  @override
  Future<void> logOut() async {
    await _apiClient.post<Map<String, dynamic>>(
      AdminProfileApiEndpoints.logOut,
    );
  }
}
