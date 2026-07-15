import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'client_app_localizations_en.dart';
import 'client_app_localizations_kk.dart';
import 'client_app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ClientAppLocalizations
/// returned by `ClientAppLocalizations.of(context)`.
///
/// Applications need to include `ClientAppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/client_app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ClientAppLocalizations.localizationsDelegates,
///   supportedLocales: ClientAppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ClientAppLocalizations.supportedLocales
/// property.
abstract class ClientAppLocalizations {
  ClientAppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ClientAppLocalizations of(BuildContext context) {
    return Localizations.of<ClientAppLocalizations>(
      context,
      ClientAppLocalizations,
    )!;
  }

  static const LocalizationsDelegate<ClientAppLocalizations> delegate =
      _ClientAppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @homeItem.
  ///
  /// In en, this message translates to:
  /// **'Home item {number}'**
  String homeItem(int number);

  /// No description provided for @profilePreferencesNotificationsAndSounds.
  ///
  /// In en, this message translates to:
  /// **'Notifications and sounds'**
  String get profilePreferencesNotificationsAndSounds;

  /// No description provided for @profilePreferencesAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profilePreferencesAppearance;

  /// No description provided for @profilePreferencesLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profilePreferencesLanguage;

  /// No description provided for @profilePreferencesDevices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get profilePreferencesDevices;

  /// No description provided for @profileSupportFaq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get profileSupportFaq;

  /// No description provided for @profileSupportSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get profileSupportSupport;

  /// No description provided for @appVersionWithBuild.
  ///
  /// In en, this message translates to:
  /// **'Version {version} ({buildNumber})'**
  String appVersionWithBuild(String version, String buildNumber);

  /// No description provided for @appNameValue.
  ///
  /// In en, this message translates to:
  /// **'App: {appName}'**
  String appNameValue(String appName);

  /// No description provided for @appPackageNameValue.
  ///
  /// In en, this message translates to:
  /// **'Package: {packageName}'**
  String appPackageNameValue(String packageName);

  /// No description provided for @appBuildNumberValue.
  ///
  /// In en, this message translates to:
  /// **'Build number: {buildNumber}'**
  String appBuildNumberValue(String buildNumber);

  /// No description provided for @profileAvatarRemoveDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove avatar?'**
  String get profileAvatarRemoveDialogTitle;

  /// No description provided for @profileAvatarRemoveDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Your current avatar will be removed from your profile.'**
  String get profileAvatarRemoveDialogMessage;

  /// No description provided for @profileAvatarActionRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove avatar'**
  String get profileAvatarActionRemove;

  /// No description provided for @profileAvatarRemovedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Avatar removed successfully'**
  String get profileAvatarRemovedSuccessMessage;

  /// No description provided for @profileAvatarUpdatedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Avatar updated successfully'**
  String get profileAvatarUpdatedSuccessMessage;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @sessionLoadFailureTitle.
  ///
  /// In en, this message translates to:
  /// **'Unable to load your session'**
  String get sessionLoadFailureTitle;

  /// No description provided for @sessionLoadFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get sessionLoadFailureMessage;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;
}

class _ClientAppLocalizationsDelegate
    extends LocalizationsDelegate<ClientAppLocalizations> {
  const _ClientAppLocalizationsDelegate();

  @override
  Future<ClientAppLocalizations> load(Locale locale) {
    return SynchronousFuture<ClientAppLocalizations>(
      lookupClientAppLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_ClientAppLocalizationsDelegate old) => false;
}

ClientAppLocalizations lookupClientAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return ClientAppLocalizationsEn();
    case 'kk':
      return ClientAppLocalizationsKk();
    case 'ru':
      return ClientAppLocalizationsRu();
  }

  throw FlutterError(
    'ClientAppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
