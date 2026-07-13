import 'package:client_app/gen/l10n/client_app_localizations.dart';
import 'package:flutter/widgets.dart';

extension ClientAppLocalizationContextX on BuildContext {
  ClientAppLocalizations get l10n => ClientAppLocalizations.of(this);
}
