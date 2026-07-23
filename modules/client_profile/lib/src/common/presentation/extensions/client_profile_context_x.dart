import 'package:client_profile/gen/assets.gen.dart';
import 'package:client_profile/gen/l10n/client_profile_localizations.dart';
import 'package:flutter/widgets.dart';

extension ClientProfileContextX on BuildContext {
  ClientProfileLocalizations get l10n => ClientProfileLocalizations.of(this);

  $AssetsClientProfileGen get assets => Assets.clientProfile;
}
