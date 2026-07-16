// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_profile_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AdminProfileLocalizationsRu extends AdminProfileLocalizations {
  AdminProfileLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get logout => 'Выйти';

  @override
  String get dismiss => 'Закрыть';

  @override
  String get profileAvatarActionChange => 'Изменить аватар';

  @override
  String get profileAvatarActionRemove => 'Удалить аватар';

  @override
  String get profileAvatarActionView => 'Посмотреть аватар';

  @override
  String get profileEditFullNameLabel => 'Полное имя';

  @override
  String get profileEditDiscardChanges => 'Выйти без сохранения';

  @override
  String get profileEditDiscardChangesMessage =>
      'Изменения профиля ещё не сохранены.';

  @override
  String get profileEditDiscardChangesTitle => 'Выйти без сохранения?';

  @override
  String get profileEditInvalidOtpMessage =>
      'Код не подошёл. Проверьте его и попробуйте ещё раз.';

  @override
  String profileEditOtpBottomSheetDescription(String phoneNumber) {
    return 'Мы отправили 6-значный код на номер $phoneNumber. Введите его, чтобы подтвердить номер.';
  }

  @override
  String get profileEditOtpBottomSheetTitle => 'Введите код подтверждения';

  @override
  String get profileEditPhoneNumberLabel => 'Номер телефона';

  @override
  String get profileEditPhoneNumberInvalidFormatMessage =>
      'Введите 10 цифр номера телефона.';

  @override
  String get profileEditPhoneVerificationPrompt =>
      'Номер телефона не подтверждён';

  @override
  String profileEditPhoneVerificationRequestMessage(String phoneNumber) {
    return 'Отправить код на $phoneNumber?';
  }

  @override
  String get profileEditPhoneVerificationRequestTitle =>
      'Подтвердить номер телефона';

  @override
  String get profileEditPhoneVerificationSendCode => 'Отправить';

  @override
  String get profileEditPhoneVerified => 'Подтверждён';

  @override
  String get profileEditRemoveAccount => 'Удалить аккаунт';

  @override
  String get profileEditRemoveAccountDialogMessage =>
      'Будет отправлен запрос на удаление аккаунта, после чего вы выйдете.';

  @override
  String get profileEditRemoveAccountDialogTitle => 'Удалить аккаунт?';

  @override
  String get profileEditSaveChanges => 'Сохранить изменения';

  @override
  String get profileEditVerifyNow => 'Подтвердить';

  @override
  String get profileSavedSuccessMessage => 'Профиль успешно сохранён';

  @override
  String get revokeAllSessions => 'Отозвать всё';

  @override
  String get revokeAllSessionsDialogMessage =>
      'Потребуется повторный вход на всех устройствах.';

  @override
  String get revokeAllSessionsDialogTitle => 'Отозвать все сеансы?';

  @override
  String get revokeSession => 'Отозвать';

  @override
  String get revokeSessionDialogMessage =>
      'На этом устройстве потребуется войти снова.';

  @override
  String get revokeSessionDialogTitle => 'Отозвать этот сеанс?';

  @override
  String get sessionsListEmptyTitle => 'Сеансов пока нет';

  @override
  String get sessionsRetry => 'Повторить';

  @override
  String sessionsSessionLastActive(String formatted) {
    return 'Последняя активность: $formatted';
  }

  @override
  String get sessionsTitle => 'Сеансы';

  @override
  String get userBlockedMessage =>
      'Ваш аккаунт заблокирован. Обратитесь в поддержку, если считаете, что это ошибка.';

  @override
  String get userBlockedTitle => 'Аккаунт заблокирован';

  @override
  String get userDeletionRequestedMessage =>
      'Запрос на удаление аккаунта обрабатывается. Пока удаление не завершено, доступ к приложению закрыт.';

  @override
  String get userDeletionRequestedTitle => 'Запрошено удаление';

  @override
  String appBuildNumberValue(String buildNumber) {
    return 'Номер сборки: $buildNumber';
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
  String appVersionWithBuild(String version, String buildNumber) {
    return 'Версия $version ($buildNumber)';
  }
}
