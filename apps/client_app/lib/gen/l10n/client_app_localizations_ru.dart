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

  @override
  String get profilePreferencesNotificationsAndSounds => 'Уведомления и звуки';

  @override
  String get profilePreferencesAppearance => 'Внешний вид';

  @override
  String get profilePreferencesLanguage => 'Язык';

  @override
  String get profilePreferencesDevices => 'Устройства';

  @override
  String get profileSupportFaq => 'FAQ';

  @override
  String get profileSupportSupport => 'Поддержка';

  @override
  String appVersionWithBuild(String version, String buildNumber) {
    return 'Версия $version ($buildNumber)';
  }

  @override
  String appNameValue(String appName) {
    return 'Приложение: $appName';
  }

  @override
  String appPackageNameValue(String packageName) {
    return 'Пакет: $packageName';
  }

  @override
  String appBuildNumberValue(String buildNumber) {
    return 'Номер сборки: $buildNumber';
  }

  @override
  String get profileAvatarRemoveDialogTitle => 'Удалить аватар?';

  @override
  String get profileAvatarRemoveDialogMessage =>
      'Текущий аватар будет удалён из вашего профиля.';

  @override
  String get profileAvatarActionRemove => 'Удалить аватар';

  @override
  String get profileAvatarRemovedSuccessMessage => 'Аватар успешно удалён';

  @override
  String get profileAvatarUpdatedSuccessMessage => 'Аватар успешно обновлён';

  @override
  String get dismiss => 'Закрыть';
}
