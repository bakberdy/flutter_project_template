// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'client_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class ClientAppLocalizationsRu extends ClientAppLocalizations {
  ClientAppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get home => 'Главная';

  @override
  String get profile => 'Профиль';

  @override
  String homeItem(int number) {
    return 'Элемент $number';
  }
}
