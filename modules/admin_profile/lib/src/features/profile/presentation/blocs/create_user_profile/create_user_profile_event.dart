part of 'create_user_profile_bloc.dart';

@freezed
sealed class CreateUserProfileEvent with _$CreateUserProfileEvent {
  const factory CreateUserProfileEvent.started() = _Started;

  const factory CreateUserProfileEvent.countryCodeSelected(
    CountryDialCode dialCode,
  ) = _CountryCodeSelected;

  const factory CreateUserProfileEvent.fullNameChanged(String value) =
      _FullNameChanged;

  const factory CreateUserProfileEvent.phoneNumberChanged({
    required String value,
  }) = _PhoneNumberChanged;

  const factory CreateUserProfileEvent.saveRequested() = _SaveRequested;
}
