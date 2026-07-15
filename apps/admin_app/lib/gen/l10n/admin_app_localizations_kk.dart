// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AdminAppLocalizationsKk extends AdminAppLocalizations {
  AdminAppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get dashboard => 'Басты бет';

  @override
  String get users => 'Пайдаланушылар';

  @override
  String get logout => 'Шығу';

  @override
  String get editProfile => 'Профильді өңдеу';

  @override
  String get notifications => 'Хабарландырулар мен дыбыстар';

  @override
  String get preferences => 'Қалаулар';

  @override
  String get devices => 'Құрылғылар';

  @override
  String get language => 'Тіл';

  @override
  String get logoutTitle => 'Шығу керек пе?';

  @override
  String get logoutMessage =>
      'Әкімші панеліне кіру үшін қайта авторизациядан өту қажет.';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get devTalkerOpen => 'Talker ашу';

  @override
  String get devTalkerDockLeft => 'Talker басқаруын оңға жылжыту';

  @override
  String get devTalkerDockRight => 'Talker басқаруын солға жылжыту';

  @override
  String get adminAccessRequired => 'Тек әкімшілер кіре алады.';

  @override
  String get sessionLoadFailureTitle =>
      'Әкімші сессиясын жүктеу мүмкін болмады';

  @override
  String get sessionLoadFailureMessage =>
      'Қосылымды тексеріп, әрекетті қайталаңыз.';

  @override
  String get retry => 'Қайталау';
}
