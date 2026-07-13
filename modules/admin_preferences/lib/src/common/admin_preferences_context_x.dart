import 'package:admin_preferences/gen/assets.gen.dart';
import 'package:admin_preferences/gen/l10n/admin_preferences_localizations.dart';
import 'package:flutter/widgets.dart';

extension AdminPreferencesContextX on BuildContext {
  AdminPreferencesLocalizations get l10n =>
      AdminPreferencesLocalizations.of(this);

  $AssetsAdminPreferencesGen get assets => Assets.adminPreferences;
}
