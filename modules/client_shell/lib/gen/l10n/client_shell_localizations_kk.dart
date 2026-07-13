// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'client_shell_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class ClientShellLocalizationsKk extends ClientShellLocalizations {
  ClientShellLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get home => 'Басты бет';

  @override
  String get profile => 'Профиль';

  @override
  String homeItem(int number) {
    return 'Элемент $number';
  }
}
