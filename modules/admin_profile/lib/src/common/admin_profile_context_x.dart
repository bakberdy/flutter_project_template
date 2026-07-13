import 'package:admin_profile/gen/assets.gen.dart';
import 'package:admin_profile/gen/l10n/admin_profile_localizations.dart';
import 'package:flutter/widgets.dart';

extension AdminProfileContextX on BuildContext {
  AdminProfileLocalizations get l10n => AdminProfileLocalizations.of(this);

  $AssetsAdminProfileGen get assets => Assets.adminProfile;
}
