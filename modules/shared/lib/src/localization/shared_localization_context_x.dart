import 'package:flutter/widgets.dart';
import 'package:shared/gen/l10n/shared_localizations.dart';

extension SharedLocalizationContextX on BuildContext {
  SharedLocalizations get l10n => SharedLocalizations.of(this);
}
