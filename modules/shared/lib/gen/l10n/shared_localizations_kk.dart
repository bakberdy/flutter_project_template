// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'shared_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class SharedLocalizationsKk extends SharedLocalizations {
  SharedLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get commonOk => 'ОК';

  @override
  String get commonDismiss => 'Жабу';

  @override
  String get errorNoConnection => 'Интернет байланысы жоқ';

  @override
  String get errorTimeout => 'Сервер жауап бермеді. Қайталап көріңіз.';

  @override
  String get errorServiceUnavailable =>
      'Қызмет уақытша қолжетімсіз. Кейінірек қайталап көріңіз.';

  @override
  String get errorSecureConnection =>
      'Қауіпсіз байланыс орнату мүмкін болмады.';

  @override
  String get errorInvalidResponse => 'Сервер жауабын өңдеу мүмкін болмады.';

  @override
  String get errorRequestFailed =>
      'Сұрауды орындау мүмкін болмады. Қайталап көріңіз.';

  @override
  String get errorUnauthorized => 'Сессия аяқталды. Қайта кіріңіз.';

  @override
  String get errorGetAppInfo =>
      'Қолданба туралы ақпаратты жүктеу мүмкін болмады.';

  @override
  String get errorGetDeviceInfo =>
      'Құрылғы туралы ақпаратты жүктеу мүмкін болмады.';

  @override
  String get errorUnknown => 'Бірдеңе дұрыс болмады. Қайталап көріңіз.';
}
