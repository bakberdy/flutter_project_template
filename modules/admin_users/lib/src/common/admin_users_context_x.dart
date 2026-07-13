import 'package:admin_users/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';
import 'package:admin_users/gen/l10n/admin_users_localizations.dart';

extension AdminUsersContextX on BuildContext {
  AdminUsersLocalizations get l10n => AdminUsersLocalizations.of(this);

  $AssetsAdminUsersGen get assets => Assets.adminUsers;
}
