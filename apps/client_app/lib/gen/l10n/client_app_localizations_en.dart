// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'client_app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ClientAppLocalizationsEn extends ClientAppLocalizations {
  ClientAppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String homeItem(int number) {
    return 'Home item $number';
  }

  @override
  String get profilePreferencesNotificationsAndSounds =>
      'Notifications and sounds';

  @override
  String get profilePreferencesAppearance => 'Appearance';

  @override
  String get profilePreferencesLanguage => 'Language';

  @override
  String get profilePreferencesDevices => 'Devices';

  @override
  String get profileSupportFaq => 'FAQ';

  @override
  String get profileSupportSupport => 'Support';

  @override
  String appVersionWithBuild(String version, String buildNumber) {
    return 'Version $version ($buildNumber)';
  }

  @override
  String appNameValue(String appName) {
    return 'App: $appName';
  }

  @override
  String appPackageNameValue(String packageName) {
    return 'Package: $packageName';
  }

  @override
  String appBuildNumberValue(String buildNumber) {
    return 'Build number: $buildNumber';
  }

  @override
  String get profileAvatarRemoveDialogTitle => 'Remove avatar?';

  @override
  String get profileAvatarRemoveDialogMessage =>
      'Your current avatar will be removed from your profile.';

  @override
  String get profileAvatarActionRemove => 'Remove avatar';

  @override
  String get profileAvatarRemovedSuccessMessage =>
      'Avatar removed successfully';

  @override
  String get profileAvatarUpdatedSuccessMessage =>
      'Avatar updated successfully';

  @override
  String get dismiss => 'Dismiss';
}
