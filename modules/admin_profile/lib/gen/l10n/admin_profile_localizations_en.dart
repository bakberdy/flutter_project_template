// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_profile_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AdminProfileLocalizationsEn extends AdminProfileLocalizations {
  AdminProfileLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get continueToLogin => 'Continue to Login';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get profileAvatarActionChange => 'Change avatar';

  @override
  String get profileAvatarActionRemove => 'Remove avatar';

  @override
  String get profileAvatarActionView => 'View avatar';

  @override
  String get profileEditFullNameLabel => 'Full Name';

  @override
  String get profileEditDiscardChanges => 'Discard changes';

  @override
  String get profileEditDiscardChangesMessage =>
      'Your profile changes have not been saved.';

  @override
  String get profileEditDiscardChangesTitle => 'Leave without saving?';

  @override
  String get profileEditInvalidOtpMessage =>
      'That code is not valid. Check it and try again.';

  @override
  String get profileEditLogout => 'Log out';

  @override
  String get profileEditLogoutDialogMessage =>
      'You will need to sign in again to access your account.';

  @override
  String get profileEditLogoutDialogTitle => 'Log out?';

  @override
  String profileEditOtpBottomSheetDescription(String phoneNumber) {
    return 'We sent a 6-digit code to $phoneNumber. Enter it to confirm your number.';
  }

  @override
  String get profileEditOtpBottomSheetTitle => 'Enter verification code';

  @override
  String get profileEditPhoneNumberLabel => 'Phone Number';

  @override
  String get profileEditPhoneNumberInvalidFormatMessage =>
      'Enter 10 phone number digits.';

  @override
  String get profileEditPhoneVerificationPrompt => 'Phone number not verified';

  @override
  String profileEditPhoneVerificationRequestMessage(String phoneNumber) {
    return 'Send code to $phoneNumber?';
  }

  @override
  String get profileEditPhoneVerificationRequestTitle => 'Verify phone number';

  @override
  String get profileEditPhoneVerificationSendCode => 'Send';

  @override
  String get profileEditPhoneVerified => 'Verified';

  @override
  String get profileEditRemoveAccount => 'Remove account';

  @override
  String get profileEditRemoveAccountDialogMessage =>
      'This will request account deletion and sign you out.';

  @override
  String get profileEditRemoveAccountDialogTitle => 'Remove account?';

  @override
  String get profileEditSaveChanges => 'Save changes';

  @override
  String get profileEditTitle => 'Edit Profile';

  @override
  String get profileEditVerifyNow => 'Verify';

  @override
  String get profileSavedSuccessMessage => 'Profile saved successfully';

  @override
  String get revokeAllSessions => 'Revoke all';

  @override
  String get revokeAllSessionsDialogMessage =>
      'You will need to sign in again on every device.';

  @override
  String get revokeAllSessionsDialogTitle => 'Revoke all sessions?';

  @override
  String get revokeSession => 'Revoke';

  @override
  String get revokeSessionDialogMessage =>
      'This device will need to sign in again.';

  @override
  String get revokeSessionDialogTitle => 'Revoke this session?';

  @override
  String get sessionsListEmptyTitle => 'No sessions yet';

  @override
  String get sessionsRetry => 'Try again';

  @override
  String sessionsSessionLastActive(String formatted) {
    return 'Last active: $formatted';
  }

  @override
  String get sessionsTitle => 'Sessions';

  @override
  String get userBlockedMessage =>
      'Your account is blocked. Contact support if you think this is a mistake.';

  @override
  String get userBlockedTitle => 'Account blocked';

  @override
  String get userDeletionRequestedMessage =>
      'Your account deletion request is being processed. You cannot access the app while deletion is pending.';

  @override
  String get userDeletionRequestedTitle => 'Deletion requested';

  @override
  String appBuildNumberValue(String buildNumber) {
    return 'Build number: $buildNumber';
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
  String appVersionWithBuild(String version, String buildNumber) {
    return 'Version $version ($buildNumber)';
  }
}
