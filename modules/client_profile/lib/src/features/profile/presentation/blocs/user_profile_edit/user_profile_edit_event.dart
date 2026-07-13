part of 'user_profile_edit_bloc.dart';

@freezed
sealed class UserProfileEditEvent with _$UserProfileEditEvent {
  const factory UserProfileEditEvent.started(UserProfile profile) =
      UserProfileEditStarted;

  const factory UserProfileEditEvent.countryCodeSelected(
    CountryDialCode dialCode,
  ) = UserProfileEditCountryCodeSelected;

  const factory UserProfileEditEvent.fullNameChanged(String value) =
      UserProfileEditFullNameChanged;

  const factory UserProfileEditEvent.phoneNumberChanged({
    required String value,
  }) = UserProfileEditPhoneNumberChanged;

  const factory UserProfileEditEvent.otpSheetOpened() =
      UserProfileEditOtpSheetOpened;

  const factory UserProfileEditEvent.otpSubmitted(String otpCode) =
      UserProfileEditOtpSubmitted;

  const factory UserProfileEditEvent.saveChangesRequested() =
      UserProfileEditSaveChangesRequested;

  const factory UserProfileEditEvent.resetAfterSave() =
      UserProfileEditResetAfterSave;
}
