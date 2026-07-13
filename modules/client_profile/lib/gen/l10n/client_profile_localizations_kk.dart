// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'client_profile_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class ClientProfileLocalizationsKk extends ClientProfileLocalizations {
  ClientProfileLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get continueToLogin => 'Кіруге жалғастыру';

  @override
  String get dismiss => 'Жабу';

  @override
  String get profileAvatarActionChange => 'Аватарды өзгерту';

  @override
  String get profileAvatarActionRemove => 'Аватарды жою';

  @override
  String get profileAvatarActionView => 'Аватарды көру';

  @override
  String get profileEditFullNameLabel => 'Толық аты';

  @override
  String get profileEditDiscardChanges => 'Сақтамай шығу';

  @override
  String get profileEditDiscardChangesMessage =>
      'Профильдегі өзгерістер әлі сақталған жоқ.';

  @override
  String get profileEditDiscardChangesTitle => 'Сақтамай шығасыз ба?';

  @override
  String get profileEditInvalidOtpMessage =>
      'Код сәйкес келмеді. Тексеріп, қайта енгізіңіз.';

  @override
  String get profileEditLogout => 'Шығу';

  @override
  String get profileEditLogoutDialogMessage =>
      'Аккаунтқа қайта кіру үшін қайта авторизациядан өту қажет болады.';

  @override
  String get profileEditLogoutDialogTitle => 'Шығу керек пе?';

  @override
  String profileEditOtpBottomSheetDescription(String phoneNumber) {
    return '$phoneNumber нөміріне 6 таңбалы код жібердік. Нөмірді растау үшін сол кодты енгізіңіз.';
  }

  @override
  String get profileEditOtpBottomSheetTitle => 'Растау кодын енгізіңіз';

  @override
  String get profileEditPhoneNumberLabel => 'Телефон нөмірі';

  @override
  String get profileEditPhoneNumberInvalidFormatMessage =>
      'Телефон нөмірінің 10 санын енгізіңіз.';

  @override
  String get profileEditPhoneVerificationPrompt => 'Телефон нөмірі расталмаған';

  @override
  String profileEditPhoneVerificationRequestMessage(String phoneNumber) {
    return '$phoneNumber нөміріне код жіберу керек пе?';
  }

  @override
  String get profileEditPhoneVerificationRequestTitle =>
      'Телефон нөмірін растау';

  @override
  String get profileEditPhoneVerificationSendCode => 'Жіберу';

  @override
  String get profileEditPhoneVerified => 'Расталды';

  @override
  String get profileEditRemoveAccount => 'Аккаунтты жою';

  @override
  String get profileEditRemoveAccountDialogMessage =>
      'Аккаунтты жоюға сұрау жіберіледі, содан кейін жүйеден шығасыз.';

  @override
  String get profileEditRemoveAccountDialogTitle => 'Аккаунтты жою керек пе?';

  @override
  String get profileEditSaveChanges => 'Өзгерістерді сақтау';

  @override
  String get profileEditTitle => 'Профильді өңдеу';

  @override
  String get profileEditVerifyNow => 'Растау';

  @override
  String get profileSavedSuccessMessage => 'Профиль сәтті сақталды';

  @override
  String get revokeAllSessions => 'Барлық сеанстарды алып тастау';

  @override
  String get revokeAllSessionsDialogMessage =>
      'Барлық құрылғыларға қайта кіру қажет болады.';

  @override
  String get revokeAllSessionsDialogTitle =>
      'Барлық сеанстар алып тасталсын ба?';

  @override
  String get revokeSession => 'Алып тастау';

  @override
  String get revokeSessionDialogMessage =>
      'Бұл құрылғыға қайта кіру қажет болады.';

  @override
  String get revokeSessionDialogTitle => 'Бұл сеанс алып тасталсын ба?';

  @override
  String get sessionsListEmptyTitle => 'Әзірше сеанстар жоқ';

  @override
  String get sessionsRetry => 'Қайталау';

  @override
  String sessionsSessionLastActive(String formatted) {
    return 'Соңғы белсенділік: $formatted';
  }

  @override
  String get sessionsTitle => 'Сеанстар';

  @override
  String get userBlockedMessage =>
      'Аккаунтыңыз бұғатталған. Бұл қате деп ойласаңыз, қолдау қызметіне хабарласыңыз.';

  @override
  String get userBlockedTitle => 'Аккаунт бұғатталған';

  @override
  String get userDeletionRequestedMessage =>
      'Аккаунтты жою сұрауы өңделіп жатыр. Жою аяқталғанша қолданбаға кіру мүмкін емес.';

  @override
  String get userDeletionRequestedTitle => 'Жою сұралды';

  @override
  String get userDeletedTitle => 'Аккаунтыңыз жойылды';

  @override
  String get userDeletedMessage =>
      'Бұл аккаунт біржола жойылды. Жалғастыру үшін басқа аккаунтпен кіріңіз.';
}
