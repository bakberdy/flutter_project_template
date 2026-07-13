import 'package:admin_auth/gen/assets.gen.dart';
import 'package:admin_auth/gen/l10n/admin_auth_localizations.dart';
import 'package:flutter/widgets.dart';

extension AdminAuthContextX on BuildContext {
  AdminAuthLocalizations get l10n => AdminAuthLocalizations.of(this);

  $AssetsAdminAuthGen get assets => Assets.adminAuth;
}
