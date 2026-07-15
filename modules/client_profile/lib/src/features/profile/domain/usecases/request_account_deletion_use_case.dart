import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/user_profile_use_case_tracking.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequestAccountDeletionUseCase extends UseCase<User, NoParams> {
  final UserProfileRepository _repository;

  RequestAccountDeletionUseCase(this._repository);

  @override
  FutureEither<User> call(NoParams params) {
    return trackUserProfileUseCase(
      _repository.requestAccountDeletion(),
      'request_account_deletion',
    );
  }
}
