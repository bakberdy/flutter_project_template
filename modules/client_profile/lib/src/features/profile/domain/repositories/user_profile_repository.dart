import 'package:client_profile/src/features/profile/domain/entities/user_avatar_upload.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';

abstract class UserProfileRepository {
  FutureEither<User> getCurrentUser({ApiCancelToken? cancelToken});

  FutureEither<UserProfile> getCurrentProfile();

  FutureEither<UserProfile> createProfile({
    required String fullName,
    UserPhoneNumber? phoneNumber,
  });

  FutureEither<UserProfile> updateProfile({
    String? fullName,
    UserPhoneNumber? phoneNumber,
  });

  FutureEither<UserProfile> updateAvatar(
    UserAvatarUpload avatar, {
    ApiProgressCallback? onSendProgress,
  });

  FutureEither<UserProfile> removeAvatar();

  FutureEither<User> requestAccountDeletion();

  FutureEither<void> logOut();
}
