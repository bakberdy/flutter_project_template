import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

class UpdateUserAvatarParams extends Equatable {
  const UpdateUserAvatarParams({required this.avatar, this.onSendProgress});
  final AppPickedFile avatar;
  final ApiProgressCallback? onSendProgress;

  @override
  List<Object?> get props => [avatar, onSendProgress];
}

@lazySingleton
class UpdateUserAvatarUseCase
    extends UseCase<UserProfile, UpdateUserAvatarParams> {
  UpdateUserAvatarUseCase(this._repository);
  final UserProfileRepository _repository;

  @override
  FutureEither<UserProfile> call(UpdateUserAvatarParams params) {
    return trackUserProfileUseCase(
      _repository.updateAvatar(
        params.avatar,
        onSendProgress: params.onSendProgress,
      ),
      'update_avatar',
    );
  }
}
