// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'client_auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ClientAuthLocalizationsEn extends ClientAuthLocalizations {
  ClientAuthLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get apiFailureDefaultMessage => 'Request failed. Try again.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authOtpLabel => 'One-time code';

  @override
  String get authSubmitEmail => 'Continue';

  @override
  String get authSubmitOtp => 'Verify';

  @override
  String get authTitle => 'Sign in';

  @override
  String get baseDefaultMessage => 'Something went wrong. Try again.';

  @override
  String get clearForm => 'Clear form';

  @override
  String get continueToLogin => 'Continue to Login';

  @override
  String get createdAtLabel => 'Created At';

  @override
  String get createTodo => 'Create todo';

  @override
  String get dark => 'Dark';

  @override
  String get deleteTodo => 'Delete todo';

  @override
  String get devClearAuthTokens => 'Clear tokens';

  @override
  String get devTokensCleared => 'Tokens cleared';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get editTodo => 'Edit todo';

  @override
  String get english => 'English';

  @override
  String get errorTitle => 'Error';

  @override
  String get exampleTodosTitle => 'Todo Example';

  @override
  String get internetConnectionErrorMessage =>
      'Check your internet connection and try again.';

  @override
  String get kazakh => 'Kazakh';

  @override
  String get light => 'Light';

  @override
  String get markTodoDone => 'Mark as done';

  @override
  String get markTodoUndone => 'Mark as not done';

  @override
  String get navigationHomeTitle => 'Home';

  @override
  String get navigationProfileTitle => 'Profile';

  @override
  String get noTodosYet => 'No todos yet';

  @override
  String get notSelected => 'Not Selected';

  @override
  String get parseFailureDefaultMessage =>
      'Could not read the response. Try again.';

  @override
  String get profileAvatarActionChange => 'Change avatar';

  @override
  String get profileAvatarActionRemove => 'Remove avatar';

  @override
  String get profileAvatarActionView => 'View avatar';

  @override
  String get profileAvatarRemoveDialogMessage =>
      'Your current avatar will be removed from your profile.';

  @override
  String get profileAvatarRemoveDialogTitle => 'Remove avatar?';

  @override
  String get profileAvatarRemovedSuccessMessage =>
      'Avatar removed successfully';

  @override
  String get profileAvatarUpdatedSuccessMessage =>
      'Avatar updated successfully';

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
  String get requiredField => 'This field is required';

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
  String get sessionRevokedBadge => 'Revoked';

  @override
  String get russian => 'Russian';

  @override
  String get santoniLuxuryFurnitureDescription =>
      'Welcome to Santoni Luxury Furniture, your one-stop destination for premium furniture. Explore our curated collection of stylish and elegant pieces.';

  @override
  String get santoniLuxuryFurnitureTitle => 'Santoni Luxury Furniture';

  @override
  String get sessionsListEmptyTitle => 'No sessions yet';

  @override
  String get sessionsLoadMore => 'Load more';

  @override
  String get sessionsRetry => 'Try again';

  @override
  String sessionsSessionLastActive(String formatted) {
    return 'Last active: $formatted';
  }

  @override
  String get sessionsTitle => 'Sessions';

  @override
  String get secureConnectionErrorMessage =>
      'Secure connection failed. Try again.';

  @override
  String get system => 'System';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get todoDescriptionLabel => 'Description';

  @override
  String get todoDoneLabel => 'Done';

  @override
  String get todoFormTitle => 'Todo form';

  @override
  String get todoListTitle => 'Todo list';

  @override
  String get todoTitleLabel => 'Title';

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
  String get updateTodo => 'Update todo';
}
