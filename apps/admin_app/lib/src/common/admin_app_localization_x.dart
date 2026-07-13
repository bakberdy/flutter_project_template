import 'package:admin_app/gen/l10n/admin_app_localizations.dart';
import 'package:flutter/widgets.dart';

extension AdminAppLocalizationContextX on BuildContext {
  AdminAppLocalizations get l10n => AdminAppLocalizations.of(this);
}
