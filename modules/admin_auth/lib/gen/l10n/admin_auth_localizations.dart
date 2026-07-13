import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'admin_auth_localizations_en.dart';
import 'admin_auth_localizations_kk.dart';
import 'admin_auth_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AdminAuthLocalizations
/// returned by `AdminAuthLocalizations.of(context)`.
///
/// Applications need to include `AdminAuthLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/admin_auth_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AdminAuthLocalizations.localizationsDelegates,
///   supportedLocales: AdminAuthLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AdminAuthLocalizations.supportedLocales
/// property.
abstract class AdminAuthLocalizations {
  AdminAuthLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AdminAuthLocalizations of(BuildContext context) {
    return Localizations.of<AdminAuthLocalizations>(
      context,
      AdminAuthLocalizations,
    )!;
  }

  static const LocalizationsDelegate<AdminAuthLocalizations> delegate =
      _AdminAuthLocalizationsDelegate();

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

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authSubmitEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get authSubmitEmail;

  /// No description provided for @authSubmitOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get authSubmitOtp;

  /// No description provided for @authTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authTitle;
}

class _AdminAuthLocalizationsDelegate
    extends LocalizationsDelegate<AdminAuthLocalizations> {
  const _AdminAuthLocalizationsDelegate();

  @override
  Future<AdminAuthLocalizations> load(Locale locale) {
    return SynchronousFuture<AdminAuthLocalizations>(
      lookupAdminAuthLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AdminAuthLocalizationsDelegate old) => false;
}

AdminAuthLocalizations lookupAdminAuthLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AdminAuthLocalizationsEn();
    case 'kk':
      return AdminAuthLocalizationsKk();
    case 'ru':
      return AdminAuthLocalizationsRu();
  }

  throw FlutterError(
    'AdminAuthLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
