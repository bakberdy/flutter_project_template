// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AdminAppLocalizationsRu extends AdminAppLocalizations {
  AdminAppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get adminAppTitle => 'Панель администратора';

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
  String get languageEnglishNative => 'English';

  @override
  String get languageRussianNative => 'Русский';

  @override
  String get languageKazakhNative => 'Қазақ';

  @override
  String get logoutTitle => 'Выйти?';

  @override
  String get logoutMessage =>
      'Для доступа к панели администратора потребуется войти снова.';

  @override
  String get cancel => 'Отмена';

  @override
  String get devTalkerOpen => 'Открыть Talker';

  @override
  String get devTalkerDockLeft => 'Переместить Talker вправо';

  @override
  String get devTalkerDockRight => 'Переместить Talker влево';

  @override
  String get adminAccessRequired => 'Войти могут только администраторы.';

  @override
  String get sessionLoadFailureTitle =>
      'Не удалось загрузить сессию администратора';

  @override
  String get sessionLoadFailureMessage =>
      'Проверьте подключение и повторите попытку.';

  @override
  String get retry => 'Повторить';
}
