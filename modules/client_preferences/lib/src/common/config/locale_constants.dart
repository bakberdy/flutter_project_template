import 'package:flutter/widgets.dart';

abstract final class ClientPreferencesLocaleConstants {
  static const english = Locale('en');
  static const russian = Locale('ru');
  static const kazakh = Locale('kk');
  static const defaultLocale = english;
  static const supportedLocales = [english, russian, kazakh];
}
