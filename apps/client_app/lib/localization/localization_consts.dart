import 'package:client_app/gen/l10n/client_app_localizations.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:client_preferences/gen/l10n/client_preferences_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final class LocalizationConsts {
  static const defaultLocale = Locale('en');
  static const supportedLocales = [Locale('ru'), Locale('kk'), Locale('en')];

  static const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates =
      [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        ClientAuthLocalizations.delegate,
        ClientPreferencesLocalizations.delegate,
        ClientAppLocalizations.delegate,
      ];
}
