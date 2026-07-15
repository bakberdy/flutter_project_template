// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'shared_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class SharedLocalizationsRu extends SharedLocalizations {
  SharedLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get commonOk => 'ОК';

  @override
  String get commonDismiss => 'Закрыть';

  @override
  String get errorNoConnection => 'Нет подключения к интернету';

  @override
  String get errorTimeout => 'Сервер не ответил. Попробуйте ещё раз.';

  @override
  String get errorServiceUnavailable =>
      'Сервис временно недоступен. Попробуйте позже.';

  @override
  String get errorSecureConnection =>
      'Не удалось установить безопасное соединение.';

  @override
  String get errorInvalidResponse => 'Не удалось обработать ответ сервера.';

  @override
  String get errorRequestFailed =>
      'Не удалось выполнить запрос. Попробуйте ещё раз.';

  @override
  String get errorUnauthorized => 'Сессия истекла. Войдите снова.';

  @override
  String get errorUnknown => 'Что-то пошло не так. Попробуйте ещё раз.';
}
