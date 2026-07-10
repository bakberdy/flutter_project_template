import 'package:core/core.dart';
import 'package:client_auth/src/features/users/domain/repositories/user_profile_repository.dart';
import 'package:client_auth/src/features/users/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RemoveUserAvatarUseCase extends UseCase<UserProfile, NoParams> {
  final UserProfileRepository _repository;

  RemoveUserAvatarUseCase(this._repository);

  @override
  FutureEither<UserProfile> call(NoParams params) {
    return trackUserProfileUseCase(_repository.removeAvatar(), 'remove_avatar');
  }
}
