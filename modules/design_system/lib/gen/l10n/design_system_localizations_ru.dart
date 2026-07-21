// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'design_system_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class DesignSystemLocalizationsRu extends DesignSystemLocalizations {
  DesignSystemLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String countryDialCodeOption(String dialCode, String countryCode) {
    return '$dialCode ($countryCode)';
  }
}
