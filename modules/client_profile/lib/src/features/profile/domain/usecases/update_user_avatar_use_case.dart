import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:client_profile/src/features/profile/domain/entities/user_avatar_upload.dart';
import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class UpdateUserAvatarParams extends Equatable {
  final UserAvatarUpload avatar;
  final ApiProgressCallback? onSendProgress;

  const UpdateUserAvatarParams({required this.avatar, this.onSendProgress});

  @override
  List<Object?> get props => [avatar, onSendProgress];
}

@lazySingleton
class UpdateUserAvatarUseCase
    extends UseCase<UserProfile, UpdateUserAvatarParams> {
  final UserProfileRepository _repository;

  UpdateUserAvatarUseCase(this._repository);

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
