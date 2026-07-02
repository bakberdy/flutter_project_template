import 'package:admin_users/gen/l10n/admin_users_localizations.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';

extension AdminUserRoleLocalizationX on AdminUserRole {
  String localizedName(AdminUsersLocalizations l10n) => switch (this) {
    AdminUserRole.superAdmin => l10n.usersRoleSuperAdmin,
    AdminUserRole.admin => l10n.usersRoleAdmin,
    AdminUserRole.user => l10n.usersRoleUser,
  };
}

extension AdminUserStatusLocalizationX on AdminUserStatus {
  String localizedName(AdminUsersLocalizations l10n) => switch (this) {
    AdminUserStatus.active => l10n.usersStatusActive,
    AdminUserStatus.blocked => l10n.usersStatusBlocked,
    AdminUserStatus.deletionRequested => l10n.usersStatusDeletionRequested,
    AdminUserStatus.deleted => l10n.usersStatusDeleted,
  };
}
