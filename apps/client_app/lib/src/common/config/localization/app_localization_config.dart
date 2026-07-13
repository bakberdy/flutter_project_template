import 'package:client_app/gen/l10n/client_app_localizations.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:client_preferences/client_preferences.dart';
import 'package:design_system/gen/l10n/design_system_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final class AppLocalizationConfig {
  static const defaultLocale = ClientPreferencesLocaleConstants.defaultLocale;
  static const supportedLocales =
      ClientPreferencesLocaleConstants.supportedLocales;

  static const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates =
      [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        ClientAuthLocalizations.delegate,
        ClientPreferencesLocalizations.delegate,
        DesignSystemLocalizations.delegate,
        ClientAppLocalizations.delegate,
      ];
}
