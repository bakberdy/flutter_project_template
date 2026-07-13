import 'package:admin_auth/gen/l10n/admin_auth_localizations.dart';
import 'package:admin_users/gen/l10n/admin_users_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:design_system/gen/l10n/design_system_localizations.dart';

final class LocalizationConsts {
  static const defaultLocale = Locale('en');
  static const supportedLocales = [Locale('ru'), Locale('kk'), Locale('en')];

  static const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates =
      [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AdminAuthLocalizations.delegate,
        AdminUsersLocalizations.delegate,
        DesignSystemLocalizations.delegate,
      ];
}
