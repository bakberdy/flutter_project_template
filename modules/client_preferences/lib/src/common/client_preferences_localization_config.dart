import 'package:client_preferences/src/common/config/client_preferences_constants.dart';
import 'package:flutter/widgets.dart';

abstract final class ClientPreferencesLocalizationConfig {
  static const Locale defaultLocale = ClientPreferencesConstants.defaultLocale;
  static const List<Locale> supportedLocales =
      ClientPreferencesConstants.supportedLocales;
}
