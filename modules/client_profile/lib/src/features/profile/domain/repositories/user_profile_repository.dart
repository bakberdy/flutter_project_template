import 'package:core/core.dart';
import 'package:shared/shared.dart';

abstract class UserProfileRepository {
  Future<bool> hasSession();

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
    AppPickedFile avatar, {
    ApiProgressCallback? onSendProgress,
  });

  FutureEither<UserProfile> removeAvatar();

  FutureEither<User> requestAccountDeletion();

  FutureEither<void> logOut();
}
