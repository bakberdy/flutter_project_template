import 'package:client_preferences/gen/assets.gen.dart';
import 'package:client_preferences/gen/l10n/client_preferences_localizations.dart';
import 'package:flutter/widgets.dart';

extension ClientPreferencesContextX on BuildContext {
  ClientPreferencesLocalizations get l10n =>
      ClientPreferencesLocalizations.of(this);

  $AssetsClientPreferencesGen get assets => Assets.clientPreferences;
}
