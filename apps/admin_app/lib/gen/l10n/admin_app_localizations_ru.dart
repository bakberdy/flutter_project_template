// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AdminAppLocalizationsRu extends AdminAppLocalizations {
  AdminAppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get adminPanel => 'Панель администратора';

  @override
  String get dashboard => 'Главная';

  @override
  String get users => 'Пользователи';

  @override
  String get settings => 'Настройки';

  @override
  String get logout => 'Выйти';

  @override
  String get signInTitle => 'Вход в панель администратора';

  @override
  String get signInHero =>
      'Управляйте продуктом из единого защищённого пространства.';

  @override
  String get signInEmailDescription =>
      'Введите email администратора, чтобы продолжить.';

  @override
  String signInOtpDescription(String email) {
    return 'Введите код подтверждения, отправленный на $email.';
  }

  @override
  String get email => 'Email';

  @override
  String get continueLabel => 'Продолжить';

  @override
  String get signIn => 'Войти';

  @override
  String get backToEmail => 'Использовать другой email';

  @override
  String get usersCardDescription =>
      'Управление аккаунтами, ролями и статусами доступа.';

  @override
  String get security => 'Безопасность';

  @override
  String get securityCardDescription =>
      'Контроль доступа администраторов и сессий.';

  @override
  String get systemStatus => 'Состояние системы';

  @override
  String get systemStatusCardDescription =>
      'Мониторинг доступности подключённых сервисов.';

  @override
  String get language => 'Язык';

  @override
  String get languageDescription =>
      'Интерфейс использует сохранённую языковую настройку.';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get notifications => 'Уведомления и звуки';

  @override
  String get preferences => 'Предпочтения';

  @override
  String get devices => 'Устройства';

  @override
  String get appearance => 'Оформление';

  @override
  String get moreExamples => 'Другие примеры';

  @override
  String get innerItemOne => 'Вложенный пункт 1';

  @override
  String get innerItemTwo => 'Вложенный пункт 2';

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
