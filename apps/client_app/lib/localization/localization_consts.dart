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
      ];
}
