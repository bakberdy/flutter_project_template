import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'client_auth_localizations_en.dart';
import 'client_auth_localizations_kk.dart';
import 'client_auth_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ClientAuthLocalizations
/// returned by `ClientAuthLocalizations.of(context)`.
///
/// Applications need to include `ClientAuthLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/client_auth_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ClientAuthLocalizations.localizationsDelegates,
///   supportedLocales: ClientAuthLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ClientAuthLocalizations.supportedLocales
/// property.
abstract class ClientAuthLocalizations {
  ClientAuthLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ClientAuthLocalizations of(BuildContext context) {
    return Localizations.of<ClientAuthLocalizations>(
      context,
      ClientAuthLocalizations,
    )!;
  }

  static const LocalizationsDelegate<ClientAuthLocalizations> delegate =
      _ClientAuthLocalizationsDelegate();

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

  /// No description provided for @addTodo.
  ///
  /// In en, this message translates to:
  /// **'Add Todo'**
  String get addTodo;

  /// No description provided for @apiFailureDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Request failed. Try again.'**
  String get apiFailureDefaultMessage;

  /// No description provided for @appApiUrlValue.
  ///
  /// In en, this message translates to:
  /// **'API URL: {apiUrl}'**
  String appApiUrlValue(String apiUrl);

  /// No description provided for @appBuildNumberValue.
  ///
  /// In en, this message translates to:
  /// **'Build number: {buildNumber}'**
  String appBuildNumberValue(String buildNumber);

  /// No description provided for @appEnvironmentValue.
  ///
  /// In en, this message translates to:
  /// **'Environment: {environment}'**
  String appEnvironmentValue(String environment);

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

  /// No description provided for @appVersionWithBuild.
  ///
  /// In en, this message translates to:
  /// **'Version {version} ({buildNumber})'**
  String appVersionWithBuild(String version, String buildNumber);

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authOtpLabel.
  ///
  /// In en, this message translates to:
  /// **'One-time code'**
  String get authOtpLabel;

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

  /// No description provided for @baseDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get baseDefaultMessage;

  /// No description provided for @clearForm.
  ///
  /// In en, this message translates to:
  /// **'Clear form'**
  String get clearForm;

  /// No description provided for @continueToLogin.
  ///
  /// In en, this message translates to:
  /// **'Continue to Login'**
  String get continueToLogin;

  /// No description provided for @createdAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAtLabel;

  /// No description provided for @createTodo.
  ///
  /// In en, this message translates to:
  /// **'Create todo'**
  String get createTodo;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @deleteTodo.
  ///
  /// In en, this message translates to:
  /// **'Delete todo'**
  String get deleteTodo;

  /// No description provided for @devClearAuthTokens.
  ///
  /// In en, this message translates to:
  /// **'Clear tokens'**
  String get devClearAuthTokens;

  /// No description provided for @devTokensCleared.
  ///
  /// In en, this message translates to:
  /// **'Tokens cleared'**
  String get devTokensCleared;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @editTodo.
  ///
  /// In en, this message translates to:
  /// **'Edit todo'**
  String get editTodo;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// No description provided for @exampleTodosTitle.
  ///
  /// In en, this message translates to:
  /// **'Todo Example'**
  String get exampleTodosTitle;

  /// No description provided for @internetConnectionErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again.'**
  String get internetConnectionErrorMessage;

  /// No description provided for @kazakh.
  ///
  /// In en, this message translates to:
  /// **'Kazakh'**
  String get kazakh;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @markTodoDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as done'**
  String get markTodoDone;

  /// No description provided for @markTodoUndone.
  ///
  /// In en, this message translates to:
  /// **'Mark as not done'**
  String get markTodoUndone;

  /// No description provided for @navigationHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigationHomeTitle;

  /// No description provided for @navigationProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navigationProfileTitle;

  /// No description provided for @noTodosYet.
  ///
  /// In en, this message translates to:
  /// **'No todos yet'**
  String get noTodosYet;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Not Selected'**
  String get notSelected;

  /// No description provided for @parseFailureDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not read the response. Try again.'**
  String get parseFailureDefaultMessage;

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

  /// No description provided for @profileAvatarRemoveDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Your current avatar will be removed from your profile.'**
  String get profileAvatarRemoveDialogMessage;

  /// No description provided for @profileAvatarRemoveDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove avatar?'**
  String get profileAvatarRemoveDialogTitle;

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

  /// No description provided for @profilePreferencesAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profilePreferencesAppearance;

  /// No description provided for @profilePreferencesDevices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get profilePreferencesDevices;

  /// No description provided for @profilePreferencesEmailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email notifications'**
  String get profilePreferencesEmailNotifications;

  /// No description provided for @profilePreferencesLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profilePreferencesLanguage;

  /// No description provided for @profilePreferencesMarketingNotifications.
  ///
  /// In en, this message translates to:
  /// **'Marketing notifications'**
  String get profilePreferencesMarketingNotifications;

  /// No description provided for @profilePreferencesNotificationsAndSounds.
  ///
  /// In en, this message translates to:
  /// **'Notifications and sounds'**
  String get profilePreferencesNotificationsAndSounds;

  /// No description provided for @profilePreferencesPushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get profilePreferencesPushNotifications;

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

  /// No description provided for @refreshTodos.
  ///
  /// In en, this message translates to:
  /// **'Refresh todos'**
  String get refreshTodos;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

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

  /// No description provided for @sessionRevokedBadge.
  ///
  /// In en, this message translates to:
  /// **'Revoked'**
  String get sessionRevokedBadge;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @santoniLuxuryFurnitureDescription.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Santoni Luxury Furniture, your one-stop destination for premium furniture. Explore our curated collection of stylish and elegant pieces.'**
  String get santoniLuxuryFurnitureDescription;

  /// No description provided for @santoniLuxuryFurnitureTitle.
  ///
  /// In en, this message translates to:
  /// **'Santoni Luxury Furniture'**
  String get santoniLuxuryFurnitureTitle;

  /// No description provided for @sessionsListEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No sessions yet'**
  String get sessionsListEmptyTitle;

  /// No description provided for @sessionsLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get sessionsLoadMore;

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

  /// No description provided for @secureConnectionErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Secure connection failed. Try again.'**
  String get secureConnectionErrorMessage;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @todoDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get todoDescriptionLabel;

  /// No description provided for @todoDoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get todoDoneLabel;

  /// No description provided for @todoFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Todo form'**
  String get todoFormTitle;

  /// No description provided for @todoListTitle.
  ///
  /// In en, this message translates to:
  /// **'Todo list'**
  String get todoListTitle;

  /// No description provided for @todoTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get todoTitleLabel;

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

  /// No description provided for @updateTodo.
  ///
  /// In en, this message translates to:
  /// **'Update todo'**
  String get updateTodo;
}

class _ClientAuthLocalizationsDelegate
    extends LocalizationsDelegate<ClientAuthLocalizations> {
  const _ClientAuthLocalizationsDelegate();

  @override
  Future<ClientAuthLocalizations> load(Locale locale) {
    return SynchronousFuture<ClientAuthLocalizations>(
      lookupClientAuthLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_ClientAuthLocalizationsDelegate old) => false;
}

ClientAuthLocalizations lookupClientAuthLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return ClientAuthLocalizationsEn();
    case 'kk':
      return ClientAuthLocalizationsKk();
    case 'ru':
      return ClientAuthLocalizationsRu();
  }

  throw FlutterError(
    'ClientAuthLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
