// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AdminAppLocalizationsEn extends AdminAppLocalizations {
  AdminAppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get adminAppTitle => 'My App Admin';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get users => 'Users';

  @override
  String get logout => 'Log out';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get notifications => 'Notifications and sounds';

  @override
  String get preferences => 'Preferences';

  @override
  String get devices => 'Devices';

  @override
  String get language => 'Language';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageRussianNative => 'Русский';

  @override
  String get languageKazakhNative => 'Қазақ';

  @override
  String get logoutTitle => 'Log out?';

  @override
  String get logoutMessage =>
      'You will need to sign in again to access the admin panel.';

  @override
  String get cancel => 'Cancel';

  @override
  String get devTalkerOpen => 'Open Talker';

  @override
  String get devTalkerDockLeft => 'Move Talker control to the right';

  @override
  String get devTalkerDockRight => 'Move Talker control to the left';

  @override
  String get adminAccessRequired => 'Only administrators can sign in.';

  @override
  String get sessionLoadFailureTitle => 'Unable to load the admin session';

  @override
  String get sessionLoadFailureMessage =>
      'Check your connection and try again.';

  @override
  String get retry => 'Try again';
}
