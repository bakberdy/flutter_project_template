import 'package:core/core.dart';
import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/user_profile_use_case_tracking.dart';
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
