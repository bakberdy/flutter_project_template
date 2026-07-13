part of 'user_profile_edit_bloc.dart';

@freezed
sealed class UserProfileEditState with _$UserProfileEditState {
  const factory UserProfileEditState({
    @Default(FieldState<String>(value: '')) FieldState<String> fullName,
    @Default(
      FieldState<UserPhoneNumber>(
        value: UserPhoneNumber(countryCode: '', dialCode: '', number: ''),
      ),
    )
    FieldState<UserPhoneNumber> phoneNumber,
    @Default(FieldState<String>(value: '')) FieldState<String> otpCode,
    @Default(6) int otpLength,
    @Default(StateStatus.initial()) StateStatus otpStatus,
    @Default(StateStatus.initial()) StateStatus saveStatus,
    @Default(false) bool phoneNumberSaved,
    @Default(false) bool otpInvalid,
  }) = _UserProfileEditState;
}

extension UserProfileEditStateX on UserProfileEditState {
  bool get phoneNumberComplete => UserProfilePhoneNumberValidation.isValid(
    dialCode: phoneNumber.value.dialCode,
    localDigits: phoneNumber.value.number,
  );

  bool get showPhoneVerificationPrompt =>
      phoneNumberComplete && !phoneNumberSaved;

  bool get showPhoneVerified => phoneNumberComplete && phoneNumberSaved;

  bool get hasUnsavedChanges => fullName.isDirty || phoneNumber.isDirty;

  bool get canSaveChanges =>
      hasUnsavedChanges &&
      !saveStatus.isLoading &&
      !fullName.isInvalid &&
      !phoneNumber.isInvalid;
}
