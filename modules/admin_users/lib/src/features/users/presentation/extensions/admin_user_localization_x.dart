import 'package:admin_users/gen/l10n/admin_users_localizations.dart';
import 'package:shared/shared.dart';

extension AdminUserRoleLocalizationX on UserRole {
  String localizedName(AdminUsersLocalizations l10n) => switch (this) {
    UserRole.superAdmin => l10n.usersRoleSuperAdmin,
    UserRole.admin => l10n.usersRoleAdmin,
    UserRole.user => l10n.usersRoleUser,
  };
}

extension AdminUserStatusLocalizationX on UserStatus {
  String localizedName(AdminUsersLocalizations l10n) => switch (this) {
    UserStatus.active => l10n.usersStatusActive,
    UserStatus.blocked => l10n.usersStatusBlocked,
    UserStatus.deletionRequested => l10n.usersStatusDeletionRequested,
    UserStatus.deleted => l10n.usersStatusDeleted,
  };
}
