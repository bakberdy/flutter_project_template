// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'client_auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class ClientAuthLocalizationsRu extends ClientAuthLocalizations {
  ClientAuthLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get authEmailLabel => 'Электронная почта';

  @override
  String get authSubmitEmail => 'Продолжить';

  @override
  String get authSubmitOtp => 'Подтвердить';

  @override
  String get authTitle => 'Вход';
}
