import 'package:flutter/widgets.dart';
import 'package:admin_users/gen/l10n/admin_users_localizations.dart';

extension AdminUsersLocalizationContextX on BuildContext {
  AdminUsersLocalizations get adminUsersL10n =>
      AdminUsersLocalizations.of(this);
}
