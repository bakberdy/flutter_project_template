import 'package:design_system/gen/l10n/design_system_localizations.dart';
import 'package:flutter/widgets.dart';

extension DesignSystemLocalizationContextX on BuildContext {
  DesignSystemLocalizations get l10n => DesignSystemLocalizations.of(this);
}
