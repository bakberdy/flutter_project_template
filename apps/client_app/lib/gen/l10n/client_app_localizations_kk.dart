// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'client_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class ClientAppLocalizationsKk extends ClientAppLocalizations {
  ClientAppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get home => 'Басты бет';

  @override
  String get profile => 'Профиль';

  @override
  String homeItem(int number) {
    return 'Элемент $number';
  }
}
