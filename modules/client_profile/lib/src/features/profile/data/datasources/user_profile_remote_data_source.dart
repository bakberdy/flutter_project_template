import 'package:client_profile/src/common/config/constants/client_profile_api_endpoints.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

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
    AppPickedFile avatar, {
    ApiProgressCallback? onSendProgress,
  });

  Future<UserProfileModel> removeAvatar();

  Future<UserModel> requestAccountDeletion();

  Future<void> logOut();
}

@Singleton(as: UserProfileRemoteDataSource)
class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  UserProfileRemoteDataSourceImpl(@Named('protectedApiClient') this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<UserModel> getCurrentUser({ApiCancelToken? cancelToken}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ClientProfileApiEndpoints.me,
      cancelToken: cancelToken,
    );
    return UserModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserProfileModel> getCurrentProfile() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ClientProfileApiEndpoints.profile,
    );
    return UserProfileModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserProfileModel> createProfile({
    required String fullName,
    UserPhoneNumberModel? phoneNumber,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ClientProfileApiEndpoints.profile,
      data: {'full_name': fullName, 'phone_number': ?phoneNumber?.toJson()},
    );
    return UserProfileModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserProfileModel> updateProfile({
    String? fullName,
    UserPhoneNumberModel? phoneNumber,
  }) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      ClientProfileApiEndpoints.profile,
      data: {'full_name': ?fullName, 'phone_number': ?phoneNumber?.toJson()},
    );
    return UserProfileModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserProfileModel> updateAvatar(
    AppPickedFile avatar, {
    ApiProgressCallback? onSendProgress,
  }) async {
    final response = await _apiClient.put<Map<String, dynamic>>(
      ClientProfileApiEndpoints.avatar,
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
    return UserProfileModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserProfileModel> removeAvatar() async {
    final response = await _apiClient.delete<Map<String, dynamic>>(
      ClientProfileApiEndpoints.avatar,
    );
    return UserProfileModel.fromJson(_requireData(response.data));
  }

  @override
  Future<UserModel> requestAccountDeletion() async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ClientProfileApiEndpoints.accountDeletion,
    );
    return UserModel.fromJson(_requireData(response.data));
  }

  @override
  Future<void> logOut() async {
    await _apiClient.post<Map<String, dynamic>>(
      ClientProfileApiEndpoints.logOut,
    );
  }

  Map<String, dynamic> _requireData(Map<String, dynamic>? data) =>
      data ?? (throw const FormatException('Missing user response data'));
}
