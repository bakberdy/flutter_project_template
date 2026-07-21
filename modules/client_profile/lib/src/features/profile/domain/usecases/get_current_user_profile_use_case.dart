import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@lazySingleton
class GetCurrentUserProfileUseCase extends UseCase<UserProfile, void> {

  GetCurrentUserProfileUseCase(this._repository);
  final UserProfileRepository _repository;

  @override
  FutureEither<UserProfile> call(void params) {
    return trackUserProfileUseCase(
      _repository.getCurrentProfile(),
      'get_current_profile',
    );
  }
}
