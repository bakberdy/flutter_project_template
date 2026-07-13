import 'package:client_auth/gen/assets.gen.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:flutter/widgets.dart';

extension ClientAuthContextX on BuildContext {
  ClientAuthLocalizations get l10n => ClientAuthLocalizations.of(this);

  $AssetsClientAuthGen get assets => Assets.clientAuth;
}
