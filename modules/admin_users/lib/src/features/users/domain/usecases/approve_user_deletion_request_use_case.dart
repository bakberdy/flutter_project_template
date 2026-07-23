import 'package:admin_users/src/features/users/domain/repositories/users_repository.dart';
import 'package:admin_users/src/features/users/domain/usecases/admin_users_use_case_tracking.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@lazySingleton
class ApproveUserDeletionRequestUseCase extends UseCase<User, String> {
  ApproveUserDeletionRequestUseCase(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<User> call(String userId) => trackAdminUsersUseCase(
    _repository.approveDeletionRequest(userId),
    'approve_deletion_request',
    properties: {'target_user_id': userId},
  );
}
