import 'package:core/core.dart';
import 'package:client_profile/src/features/users/configs/user_profile_api_endpoints.dart';
import 'package:client_profile/src/features/users/domain/entities/user_avatar_upload.dart';
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
}

@Singleton(as: UserProfileRemoteDataSource)
class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final ApiClient _apiClient;

  UserProfileRemoteDataSourceImpl(@Named('protectedApiClient') this._apiClient);

  @override
  Future<UserModel> getCurrentUser({ApiCancelToken? cancelToken}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      UserProfileApiEndpoints.me,
      cancelToken: cancelToken,
    );
    return UserModel.fromJson(response.data!);
  }

  @override
  Future<UserProfileModel> getCurrentProfile() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      UserProfileApiEndpoints.myProfile,
    );
    return UserProfileModel.fromJson(response.data!);
  }

  @override
  Future<UserProfileModel> createProfile({
    required String fullName,
    UserPhoneNumberModel? phoneNumber,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      UserProfileApiEndpoints.myProfile,
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
      UserProfileApiEndpoints.myProfile,
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
      UserProfileApiEndpoints.myAvatar,
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
      UserProfileApiEndpoints.myAvatar,
    );
    return UserProfileModel.fromJson(response.data!);
  }

  @override
  Future<UserModel> requestAccountDeletion() async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      UserProfileApiEndpoints.myDeleteRequest,
    );
    return UserModel.fromJson(response.data!);
  }
}
