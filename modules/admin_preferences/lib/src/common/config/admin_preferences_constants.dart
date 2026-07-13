import 'package:flutter/widgets.dart';

abstract final class AdminPreferencesConstants {
  static const Locale english = Locale('en');
  static const Locale russian = Locale('ru');
  static const Locale kazakh = Locale('kk');
  static const Locale defaultLocale = english;
  static const List<Locale> supportedLocales = [english, russian, kazakh];

  static const String themeModeStorageKey = 'theme_mode';
  static const String localeStorageKey = 'language_code';
}
