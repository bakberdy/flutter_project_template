import 'package:admin_preferences/src/common/config/admin_preferences_constants.dart';
import 'package:flutter/widgets.dart';

abstract final class AdminPreferencesLocalizationConfig {
  static const Locale defaultLocale = AdminPreferencesConstants.defaultLocale;
  static const List<Locale> supportedLocales =
      AdminPreferencesConstants.supportedLocales;
}
