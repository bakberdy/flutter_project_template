// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'client_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ClientAppLocalizationsEn extends ClientAppLocalizations {
  ClientAppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String homeItem(int number) {
    return 'Home item $number';
  }
}
