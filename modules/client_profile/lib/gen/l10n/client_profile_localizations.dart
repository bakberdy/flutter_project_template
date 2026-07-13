import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'client_profile_localizations_en.dart';
import 'client_profile_localizations_kk.dart';
import 'client_profile_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ClientProfileLocalizations
/// returned by `ClientProfileLocalizations.of(context)`.
///
/// Applications need to include `ClientProfileLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/client_profile_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ClientProfileLocalizations.localizationsDelegates,
///   supportedLocales: ClientProfileLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ClientProfileLocalizations.supportedLocales
/// property.
abstract class ClientProfileLocalizations {
  ClientProfileLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ClientProfileLocalizations of(BuildContext context) {
    return Localizations.of<ClientProfileLocalizations>(
      context,
      ClientProfileLocalizations,
    )!;
  }

  static const LocalizationsDelegate<ClientProfileLocalizations> delegate =
      _ClientProfileLocalizationsDelegate();

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

  /// No description provided for @continueToLogin.
  ///
  /// In en, this message translates to:
  /// **'Continue to Login'**
  String get continueToLogin;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @profileAvatarActionChange.
  ///
  /// In en, this message translates to:
  /// **'Change avatar'**
  String get profileAvatarActionChange;

  /// No description provided for @profileAvatarActionRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove avatar'**
  String get profileAvatarActionRemove;

  /// No description provided for @profileAvatarActionView.
  ///
  /// In en, this message translates to:
  /// **'View avatar'**
  String get profileAvatarActionView;

  /// No description provided for @profileEditFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profileEditFullNameLabel;

  /// No description provided for @profileEditDiscardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard changes'**
  String get profileEditDiscardChanges;

  /// No description provided for @profileEditDiscardChangesMessage.
  ///
  /// In en, this message translates to:
  /// **'Your profile changes have not been saved.'**
  String get profileEditDiscardChangesMessage;

  /// No description provided for @profileEditDiscardChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave without saving?'**
  String get profileEditDiscardChangesTitle;

  /// No description provided for @profileEditInvalidOtpMessage.
  ///
  /// In en, this message translates to:
  /// **'That code is not valid. Check it and try again.'**
  String get profileEditInvalidOtpMessage;

  /// No description provided for @profileEditLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileEditLogout;

  /// No description provided for @profileEditLogoutDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access your account.'**
  String get profileEditLogoutDialogMessage;

  /// No description provided for @profileEditLogoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get profileEditLogoutDialogTitle;

  /// No description provided for @profileEditOtpBottomSheetDescription.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to {phoneNumber}. Enter it to confirm your number.'**
  String profileEditOtpBottomSheetDescription(String phoneNumber);

  /// No description provided for @profileEditOtpBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get profileEditOtpBottomSheetTitle;

  /// No description provided for @profileEditPhoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profileEditPhoneNumberLabel;

  /// No description provided for @profileEditPhoneNumberInvalidFormatMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter 10 phone number digits.'**
  String get profileEditPhoneNumberInvalidFormatMessage;

  /// No description provided for @profileEditPhoneVerificationPrompt.
  ///
  /// In en, this message translates to:
  /// **'Phone number not verified'**
  String get profileEditPhoneVerificationPrompt;

  /// No description provided for @profileEditPhoneVerificationRequestMessage.
  ///
  /// In en, this message translates to:
  /// **'Send code to {phoneNumber}?'**
  String profileEditPhoneVerificationRequestMessage(String phoneNumber);

  /// No description provided for @profileEditPhoneVerificationRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify phone number'**
  String get profileEditPhoneVerificationRequestTitle;

  /// No description provided for @profileEditPhoneVerificationSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get profileEditPhoneVerificationSendCode;

  /// No description provided for @profileEditPhoneVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get profileEditPhoneVerified;

  /// No description provided for @profileEditRemoveAccount.
  ///
  /// In en, this message translates to:
  /// **'Remove account'**
  String get profileEditRemoveAccount;

  /// No description provided for @profileEditRemoveAccountDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will request account deletion and sign you out.'**
  String get profileEditRemoveAccountDialogMessage;

  /// No description provided for @profileEditRemoveAccountDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove account?'**
  String get profileEditRemoveAccountDialogTitle;

  /// No description provided for @profileEditSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get profileEditSaveChanges;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditTitle;

  /// No description provided for @profileEditVerifyNow.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get profileEditVerifyNow;

  /// No description provided for @profileSavedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile saved successfully'**
  String get profileSavedSuccessMessage;

  /// No description provided for @revokeAllSessions.
  ///
  /// In en, this message translates to:
  /// **'Revoke all'**
  String get revokeAllSessions;

  /// No description provided for @revokeAllSessionsDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again on every device.'**
  String get revokeAllSessionsDialogMessage;

  /// No description provided for @revokeAllSessionsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Revoke all sessions?'**
  String get revokeAllSessionsDialogTitle;

  /// No description provided for @revokeSession.
  ///
  /// In en, this message translates to:
  /// **'Revoke'**
  String get revokeSession;

  /// No description provided for @revokeSessionDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This device will need to sign in again.'**
  String get revokeSessionDialogMessage;

  /// No description provided for @revokeSessionDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Revoke this session?'**
  String get revokeSessionDialogTitle;

  /// No description provided for @sessionsListEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No sessions yet'**
  String get sessionsListEmptyTitle;

  /// No description provided for @sessionsRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get sessionsRetry;

  /// No description provided for @sessionsSessionLastActive.
  ///
  /// In en, this message translates to:
  /// **'Last active: {formatted}'**
  String sessionsSessionLastActive(String formatted);

  /// No description provided for @sessionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessionsTitle;

  /// No description provided for @userBlockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account is blocked. Contact support if you think this is a mistake.'**
  String get userBlockedMessage;

  /// No description provided for @userBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Account blocked'**
  String get userBlockedTitle;

  /// No description provided for @userDeletionRequestedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account deletion request is being processed. You cannot access the app while deletion is pending.'**
  String get userDeletionRequestedMessage;

  /// No description provided for @userDeletionRequestedTitle.
  ///
  /// In en, this message translates to:
  /// **'Deletion requested'**
  String get userDeletionRequestedTitle;
}

class _ClientProfileLocalizationsDelegate
    extends LocalizationsDelegate<ClientProfileLocalizations> {
  const _ClientProfileLocalizationsDelegate();

  @override
  Future<ClientProfileLocalizations> load(Locale locale) {
    return SynchronousFuture<ClientProfileLocalizations>(
      lookupClientProfileLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_ClientProfileLocalizationsDelegate old) => false;
}

ClientProfileLocalizations lookupClientProfileLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return ClientProfileLocalizationsEn();
    case 'kk':
      return ClientProfileLocalizationsKk();
    case 'ru':
      return ClientProfileLocalizationsRu();
  }

  throw FlutterError(
    'ClientProfileLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
