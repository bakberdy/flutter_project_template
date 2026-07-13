// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AdminAppLocalizationsEn extends AdminAppLocalizations {
  AdminAppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get adminPanel => 'Admin Panel';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get users => 'Users';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Log out';

  @override
  String get signInTitle => 'Sign in to Admin Panel';

  @override
  String get signInHero => 'Manage your product from one secure workspace.';

  @override
  String get signInEmailDescription =>
      'Enter your administrator email to continue.';

  @override
  String signInOtpDescription(String email) {
    return 'Enter the verification code sent to $email.';
  }

  @override
  String get email => 'Email';

  @override
  String get continueLabel => 'Continue';

  @override
  String get signIn => 'Sign in';

  @override
  String get backToEmail => 'Use another email';

  @override
  String get usersCardDescription =>
      'Review accounts, roles and access states.';

  @override
  String get security => 'Security';

  @override
  String get securityCardDescription =>
      'Monitor administrator access and sessions.';

  @override
  String get systemStatus => 'System status';

  @override
  String get systemStatusCardDescription =>
      'Track the health of connected services.';

  @override
  String get language => 'Language';

  @override
  String get languageDescription =>
      'The interface follows your browser language.';
}
