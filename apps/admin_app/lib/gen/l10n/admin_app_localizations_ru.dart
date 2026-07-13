// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AdminAppLocalizationsRu extends AdminAppLocalizations {
  AdminAppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get dashboard => 'Главная';

  @override
  String get users => 'Пользователи';

  @override
  String get logout => 'Выйти';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get notifications => 'Уведомления и звуки';

  @override
  String get preferences => 'Предпочтения';

  @override
  String get devices => 'Устройства';

  @override
  String get language => 'Язык';

  @override
  String get logoutTitle => 'Выйти?';

  @override
  String get logoutMessage =>
      'Для доступа к панели администратора потребуется войти снова.';

  @override
  String get cancel => 'Отмена';

  @override
  String get authEmailLabel => 'Электронная почта';

  @override
  String get authSubmitEmail => 'Продолжить';

  @override
  String get authSubmitOtp => 'Подтвердить';

  @override
  String get authTitle => 'Вход';

  @override
  String get devTalkerOpen => 'Открыть Talker';

  @override
  String get devTalkerDockLeft => 'Переместить Talker вправо';

  @override
  String get devTalkerDockRight => 'Переместить Talker влево';
}
