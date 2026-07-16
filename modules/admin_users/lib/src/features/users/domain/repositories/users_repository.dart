import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:core/core.dart';

abstract class UsersRepository {
  FutureEither<PaginatedResponse<AdminUser>> getUsers(UsersQuery query);

  FutureEither<AdminUser> getUser(String userId);

  FutureEither<AdminUserProfile> getUserProfile(String userId);

  FutureEither<AdminUser> changeUserStatus(
    String userId,
    AdminUserStatus status,
  );

  FutureEither<AdminUser> changeUserRole(String userId, AdminUserRole role);

  FutureEither<AdminUser> approveDeletionRequest(String userId);
}
