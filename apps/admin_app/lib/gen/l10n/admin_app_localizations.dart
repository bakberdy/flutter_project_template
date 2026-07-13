import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'admin_app_localizations_en.dart';
import 'admin_app_localizations_kk.dart';
import 'admin_app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AdminAppLocalizations
/// returned by `AdminAppLocalizations.of(context)`.
///
/// Applications need to include `AdminAppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/admin_app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AdminAppLocalizations.localizationsDelegates,
///   supportedLocales: AdminAppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AdminAppLocalizations.supportedLocales
/// property.
abstract class AdminAppLocalizations {
  AdminAppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AdminAppLocalizations of(BuildContext context) {
    return Localizations.of<AdminAppLocalizations>(
      context,
      AdminAppLocalizations,
    )!;
  }

  static const LocalizationsDelegate<AdminAppLocalizations> delegate =
      _AdminAppLocalizationsDelegate();

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

  /// No description provided for @adminPanel.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get adminPanel;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to Admin Panel'**
  String get signInTitle;

  /// No description provided for @signInHero.
  ///
  /// In en, this message translates to:
  /// **'Manage your product from one secure workspace.'**
  String get signInHero;

  /// No description provided for @signInEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your administrator email to continue.'**
  String get signInEmailDescription;

  /// No description provided for @signInOtpDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to {email}.'**
  String signInOtpDescription(String email);

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @backToEmail.
  ///
  /// In en, this message translates to:
  /// **'Use another email'**
  String get backToEmail;

  /// No description provided for @usersCardDescription.
  ///
  /// In en, this message translates to:
  /// **'Review accounts, roles and access states.'**
  String get usersCardDescription;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @securityCardDescription.
  ///
  /// In en, this message translates to:
  /// **'Monitor administrator access and sessions.'**
  String get securityCardDescription;

  /// No description provided for @systemStatus.
  ///
  /// In en, this message translates to:
  /// **'System status'**
  String get systemStatus;

  /// No description provided for @systemStatusCardDescription.
  ///
  /// In en, this message translates to:
  /// **'Track the health of connected services.'**
  String get systemStatusCardDescription;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'The interface follows your browser language.'**
  String get languageDescription;
}

class _AdminAppLocalizationsDelegate
    extends LocalizationsDelegate<AdminAppLocalizations> {
  const _AdminAppLocalizationsDelegate();

  @override
  Future<AdminAppLocalizations> load(Locale locale) {
    return SynchronousFuture<AdminAppLocalizations>(
      lookupAdminAppLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AdminAppLocalizationsDelegate old) => false;
}

AdminAppLocalizations lookupAdminAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AdminAppLocalizationsEn();
    case 'kk':
      return AdminAppLocalizationsKk();
    case 'ru':
      return AdminAppLocalizationsRu();
  }

  throw FlutterError(
    'AdminAppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
