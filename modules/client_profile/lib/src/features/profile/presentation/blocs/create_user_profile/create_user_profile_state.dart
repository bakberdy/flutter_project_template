part of 'create_user_profile_bloc.dart';

@freezed
sealed class CreateUserProfileState with _$CreateUserProfileState {
  const factory CreateUserProfileState({
    @Default(FieldState<String>(value: '')) FieldState<String> fullName,
    @Default(
      FieldState<UserPhoneNumber>(
        value: UserPhoneNumber(countryCode: '', dialCode: '', number: ''),
      ),
    )
    FieldState<UserPhoneNumber> phoneNumber,
    @Default(StateStatus.initial()) StateStatus saveStatus,
  }) = _CreateUserProfileState;
}

extension CreateUserProfileStateX on CreateUserProfileState {
  bool get phoneNumberComplete => UserProfilePhoneNumberValidation.isValid(
    dialCode: phoneNumber.value.dialCode,
    localDigits: phoneNumber.value.number,
  );

  bool get hasUnsavedChanges => fullName.isDirty || phoneNumber.isDirty;

  bool get canSaveChanges =>
      hasUnsavedChanges &&
      !saveStatus.isLoading &&
      !fullName.isInvalid &&
      !phoneNumber.isInvalid;
}
