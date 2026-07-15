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

  @override
  String get profilePreferencesNotificationsAndSounds =>
      'Хабарландырулар мен дыбыстар';

  @override
  String get profilePreferencesAppearance => 'Сыртқы көрініс';

  @override
  String get profilePreferencesLanguage => 'Тіл';

  @override
  String get profilePreferencesDevices => 'Құрылғылар';

  @override
  String get profileSupportFaq => 'FAQ';

  @override
  String get profileSupportSupport => 'Қолдау';

  @override
  String appVersionWithBuild(String version, String buildNumber) {
    return 'Нұсқа $version ($buildNumber)';
  }

  @override
  String appNameValue(String appName) {
    return 'Қолданба: $appName';
  }

  @override
  String appPackageNameValue(String packageName) {
    return 'Пакет: $packageName';
  }

  @override
  String appBuildNumberValue(String buildNumber) {
    return 'Жинақ нөмірі: $buildNumber';
  }

  @override
  String get profileAvatarRemoveDialogTitle => 'Аватарды жою керек пе?';

  @override
  String get profileAvatarRemoveDialogMessage =>
      'Қазіргі аватар профиліңізден жойылады.';

  @override
  String get profileAvatarActionRemove => 'Аватарды жою';

  @override
  String get profileAvatarRemovedSuccessMessage => 'Аватар сәтті жойылды';

  @override
  String get profileAvatarUpdatedSuccessMessage => 'Аватар сәтті жаңартылды';

  @override
  String get dismiss => 'Жабу';

  @override
  String get sessionLoadFailureTitle => 'Сессияны жүктеу мүмкін болмады';

  @override
  String get sessionLoadFailureMessage =>
      'Қосылымды тексеріп, әрекетті қайталаңыз.';

  @override
  String get retry => 'Қайталау';
}
