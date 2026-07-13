import 'package:core/core.dart';
import 'package:client_profile/src/features/users/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/users/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrentUserProfileUseCase extends UseCase<UserProfile, void> {
  final UserProfileRepository _repository;

  GetCurrentUserProfileUseCase(this._repository);

  @override
  FutureEither<UserProfile> call(void params) {
    return trackUserProfileUseCase(
      _repository.getCurrentProfile(),
      'get_current_profile',
    );
  }
}
