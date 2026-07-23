import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';

abstract class UsersRepository {
  FutureEither<PaginatedResponse<User>> getUsers(UsersQuery query);

  FutureEither<User> getUser(String userId);

  FutureEither<UserProfile> getUserProfile(String userId);

  FutureEither<User> changeUserStatus(
    String userId,
    UserStatus status,
  );

  FutureEither<User> changeUserRole(String userId, UserRole role);

  FutureEither<User> approveDeletionRequest(String userId);
}
