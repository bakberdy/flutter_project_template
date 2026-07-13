import 'package:admin_app/gen/l10n/admin_app_localizations.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:admin_preferences/admin_preferences.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:admin_users/admin_users.dart';
import 'package:design_system/gen/l10n/design_system_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final class AppLocalizationConfig {
  static const defaultLocale = AdminPreferencesLocalizationConfig.defaultLocale;
  static const supportedLocales =
      AdminPreferencesLocalizationConfig.supportedLocales;

  static const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates =
      [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AdminAuthLocalizations.delegate,
        AdminProfileLocalizations.delegate,
        AdminPreferencesLocalizations.delegate,
        AdminUsersLocalizations.delegate,
        DesignSystemLocalizations.delegate,
        AdminAppLocalizations.delegate,
      ];
}
