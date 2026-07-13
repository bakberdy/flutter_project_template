// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AdminAppLocalizationsKk extends AdminAppLocalizations {
  AdminAppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get adminPanel => 'Әкімші панелі';

  @override
  String get dashboard => 'Басты бет';

  @override
  String get users => 'Пайдаланушылар';

  @override
  String get settings => 'Баптаулар';

  @override
  String get logout => 'Шығу';

  @override
  String get signInTitle => 'Әкімші панеліне кіру';

  @override
  String get signInHero => 'Өнімді бір қауіпсіз кеңістіктен басқарыңыз.';

  @override
  String get signInEmailDescription =>
      'Жалғастыру үшін әкімшінің email мекенжайын енгізіңіз.';

  @override
  String signInOtpDescription(String email) {
    return '$email мекенжайына жіберілген растау кодын енгізіңіз.';
  }

  @override
  String get email => 'Email';

  @override
  String get continueLabel => 'Жалғастыру';

  @override
  String get signIn => 'Кіру';

  @override
  String get backToEmail => 'Басқа email пайдалану';

  @override
  String get usersCardDescription =>
      'Аккаунттарды, рөлдерді және қолжетімділік күйлерін басқару.';

  @override
  String get security => 'Қауіпсіздік';

  @override
  String get securityCardDescription =>
      'Әкімші қолжетімділігі мен сессияларын бақылау.';

  @override
  String get systemStatus => 'Жүйе күйі';

  @override
  String get systemStatusCardDescription =>
      'Қосылған сервистердің қолжетімділігін бақылау.';

  @override
  String get language => 'Тіл';

  @override
  String get languageDescription =>
      'Интерфейс сақталған тіл баптауын қолданады.';

  @override
  String get editProfile => 'Профильді өңдеу';

  @override
  String get notifications => 'Хабарландырулар мен дыбыстар';

  @override
  String get preferences => 'Қалаулар';

  @override
  String get devices => 'Құрылғылар';

  @override
  String get appearance => 'Безендіру';

  @override
  String get moreExamples => 'Басқа мысалдар';

  @override
  String get innerItemOne => 'Ішкі тармақ 1';

  @override
  String get innerItemTwo => 'Ішкі тармақ 2';

  @override
  String get logoutTitle => 'Шығу керек пе?';

  @override
  String get logoutMessage =>
      'Әкімші панеліне кіру үшін қайта авторизациядан өту қажет.';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get authEmailLabel => 'Электрондық пошта';

  @override
  String get authSubmitEmail => 'Жалғастыру';

  @override
  String get authSubmitOtp => 'Растау';

  @override
  String get authTitle => 'Кіру';

  @override
  String get devTalkerOpen => 'Talker ашу';

  @override
  String get devTalkerDockLeft => 'Talker басқаруын оңға жылжыту';

  @override
  String get devTalkerDockRight => 'Talker басқаруын солға жылжыту';
}
