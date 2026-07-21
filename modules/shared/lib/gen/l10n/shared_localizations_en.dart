// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'shared_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SharedLocalizationsEn extends SharedLocalizations {
  SharedLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonOk => 'OK';

  @override
  String get commonDismiss => 'Dismiss';

  @override
  String get errorNoConnection => 'No internet connection';

  @override
  String get errorTimeout => 'The server did not respond. Try again.';

  @override
  String get errorServiceUnavailable =>
      'The service is temporarily unavailable. Try again later.';

  @override
  String get errorSecureConnection =>
      'A secure connection could not be established.';

  @override
  String get errorInvalidResponse =>
      'The server response could not be processed.';

  @override
  String get errorRequestFailed =>
      'The request could not be completed. Try again.';

  @override
  String get errorUnauthorized => 'Your session has expired. Sign in again.';

  @override
  String get errorGetAppInfo => 'App information could not be loaded.';

  @override
  String get errorGetDeviceInfo => 'Device information could not be loaded.';

  @override
  String get errorUnknown => 'Something went wrong. Try again.';
}
