// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'client_shell_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ClientShellLocalizationsEn extends ClientShellLocalizations {
  ClientShellLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String homeItem(int number) {
    return 'Home item $number';
  }
}
